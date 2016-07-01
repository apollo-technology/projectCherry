//
//  PCPlace.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCPlace : NSObject

@property NSString *type;
@property NSString *name;
@property NSString *phoneNumber;
@property NSString *address;
@property NSString *website;
@property NSArray *images;
@property NSArray *reviews;
@property NSString *rating;
@property NSString *lng;
@property NSString *lat;
@property NSString *pcId;
@property NSArray *files;

@end
