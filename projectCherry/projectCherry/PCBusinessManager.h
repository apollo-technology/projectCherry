//
//  PCLBusinessManager.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/23/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <Parse/Parse.h>
#import "PCPlace.h"

@interface PCBusinessManager : NSObject

@property NSString *businessId;

+(instancetype)manager;

+(void)setBusinessId:(NSString *)pcId;

+(NSString *)getBusinessId;

+(void)updatePlace:(PCPlace *)place completion:(void (^)(BOOL succeeded))completionHandler;

+(NSArray *)getTypeArray;

+(NSString *)codedTypeFromString:(NSString *)string;

+(NSString *)decodedTypeFromString:(NSString *)string;

@end
