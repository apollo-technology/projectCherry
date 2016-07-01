//
//  PCController.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <Parse/Parse.h>
#import "PCPlace.h"
#import "PCTrendController.h"
#import "PlaceViewController.h"

@interface PCController : NSObject

+(instancetype)sharedManager;

/*!
 @brief This method will download a place object from Parse and return the object as a PCPlace and a BOOL saying if it succeeded.
 */
+(void)getPlaceForId:(NSString *)pcId completion:(void (^)(PCPlace *place, BOOL succeeded))completionHandler;

/*!
 @brief This method will download an array of place objects from Parse for a certain type and return the objects as a PCPlace and a BOOL saying if it succeeded.
 */
+(void)getPlacesForType:(NSString *)type completion:(void (^)(NSArray *places, BOOL succeeded))completionHandler;

/*!
 @brief This method will download an array of place objects from Parse for a search term and return the objects as a PCPlace and a BOOL saying if it succeeded.
 */
+(void)getPlacesForSearch:(NSString *)search completion:(void (^)(NSArray *places, BOOL succeeded))completionHandler;

/*!
 @brief This method will convert a PFObject to a PCPlace.
 */
+(PCPlace *)placeFromObject:(PFObject *)object;

/*!
 @brief This method will save a PFFile and return a URL. */
+(void)saveFile:(PFFile *)file completion:(void (^)(NSString *fileURL))completionHandler percentDone:(void (^)(int percentDone))percentHandler;

/*!
 @brief This method will present a Place View Controller from a delegate. */
+(void)presentPlaceViewControllerWithPlace:(PCPlace *)place delegate:(UIViewController *)delegate;

/*!
 @brief This method will present a Place View Controller from a delegate. */
+(void)presentPlaceViewControllerWithPlaceId:(NSString *)placeId delegate:(UIViewController *)delegate;

@end
