//
//  ATPlaceController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/3/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "ATPlaceController.h"

NSString *const apiKey = @"AIzaSyAvX_Pof2gULtyNUcTXdWb-QLOALQNEqrw";

@implementation ATPlaceController

+ (instancetype)sharedManager {
    static ATPlaceController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+(void)getPlaces:(void (^)(BOOL succeeded))completion{
    NSString *location = @"%2044.763057,-85.620632";
    
    NSString *stringToSend = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/radarsearch/json?location=%@&radius=10000&type=all&key=%@",location,apiKey];
    NSData *recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    if (recievedData) {
        NSDictionary *contentData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
        NSArray *results = contentData[@"results"];
        NSLog(@"%lu",results.count);
        NSMutableArray *places = [NSMutableArray new];
        for (NSDictionary *resultPlace in results) {
            
        }
    } else {
        //error getting data
    }
}

+(void)getPlaceForLocation:(NSArray *)location completion:(void (^)(ATPlace *place))completionHandler{
    
}

+(void)getPlaceForId:(NSString *)placeId completion:(void (^)(ATPlace *place))completion{
    NSString *stringToSend = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",placeId,apiKey];
    NSData *recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    if (recievedData) {
        NSDictionary *contentData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
        //go on
        NSLog(@"%@",contentData);
    } else {
        //error getting data
    }
}

@end
