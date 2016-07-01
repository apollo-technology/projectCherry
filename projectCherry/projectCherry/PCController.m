//
//  PCController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "PCController.h"

@implementation PCController

+ (instancetype)sharedManager {
    static PCController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+(void)getPlaceForId:(NSString *)pcId completion:(void (^)(PCPlace *place, BOOL succeeded))completionHandler{
    PFQuery *query = [PFQuery queryWithClassName:@"places"];
    [query whereKey:@"id" equalTo:pcId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error) {
            PCPlace *place = [PCPlace new];
            completionHandler(place, NO);
        } else {
            PCPlace *place = [PCController placeFromObject:object];
            [PCTrendController searchedForPlace:pcId];
            completionHandler(place,YES);
        }
    }];
}

+(void)getPlacesForType:(NSString *)type completion:(void (^)(NSArray *places, BOOL succeeded))completionHandler{
    PFQuery *query = [PFQuery queryWithClassName:@"places"];
    [query whereKey:@"type" equalTo:type];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            completionHandler(@[], NO);
        } else {
            NSMutableArray *tempPlaces = [NSMutableArray new];
            for (PFObject *object in objects) {
                PCPlace *place = [PCController placeFromObject:object];
                [tempPlaces addObject:place];
            }
            NSArray *returnValue = tempPlaces;
            completionHandler(returnValue,YES);
        }
    }];
}

+(void)saveFile:(PFFile *)file completion:(void (^)(NSString *fileURL))completionHandler percentDone:(void (^)(int percentDone))percentHandler{
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completionHandler(file.url);
    } progressBlock:^(int percentDone) {
        percentHandler(percentDone);
    }];
}

+(void)getPlacesForSearch:(NSString *)search completion:(void (^)(NSArray *places, BOOL succeeded))completionHandler{
    PFQuery *query = [PFQuery queryWithClassName:@"places"];
    [query whereKey:@"name" matchesRegex:[search capitalizedString]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            completionHandler(@[],NO);
        } else {
            NSMutableArray *tempPlaces = [NSMutableArray new];
            for (PFObject *object in objects) {
                PCPlace *place = [PCController placeFromObject:object];
                [tempPlaces addObject:place];
            }
            NSArray *returnValue = tempPlaces;
            completionHandler(returnValue,YES);
        }
    }];
}

+(void)presentPlaceViewControllerWithPlace:(PCPlace *)place delegate:(UIViewController *)delegate{
    PlaceViewController *placeViewController = [delegate.storyboard instantiateViewControllerWithIdentifier:@"placeViewController"];
    placeViewController.place = place;
    [delegate.navigationController pushViewController:placeViewController animated:YES];
}

+(void)presentPlaceViewControllerWithPlaceId:(NSString *)placeId delegate:(UIViewController *)delegate{
    [PCController getPlaceForId:placeId completion:^(PCPlace *place, BOOL succeeded) {
        PlaceViewController *placeViewController = [delegate.storyboard instantiateViewControllerWithIdentifier:@"placeViewController"];
        placeViewController.place = place;
        [delegate.navigationController pushViewController:placeViewController animated:YES];
    }];
}


+(PCPlace *)placeFromObject:(PFObject *)object{
    PCPlace *place = [PCPlace new];
    
    place.pcId = object[@"id"];
    place.name = object[@"name"];
    place.type = object[@"type"];
    place.rating = object[@"rating"];
    place.lat = object[@"lat"];
    place.lng = object[@"lng"];
    place.phoneNumber = object[@"phoneNumber"];
    place.address = object[@"address"];
    place.website = object[@"website"];
    place.images = object[@"images"];
    place.files = object[@"files"];
    place.reviews = object[@"reviews"];
    
    return place;
}

@end
