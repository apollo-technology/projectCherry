//
//  PCTrendController.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <Parse/Parse.h>

@interface PCTrendController : NSObject

+(void)searchedForPlace:(NSString *)placeId;
+(void)loadedPlace:(NSString *)placeId;
+(void)viewedWebsiteForPlace:(NSString *)placeId;
+(void)sharedPlace:(NSString *)placeId;

@end
