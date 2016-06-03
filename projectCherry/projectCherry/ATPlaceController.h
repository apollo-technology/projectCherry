//
//  ATPlaceController.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/3/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPlace.h"

@interface ATPlaceController : NSObject

+(instancetype)sharedManager;

+(void)getPlaces:(void (^)(BOOL succeeded))completion;

+(void)getPlaceForId:(NSString *)placeId completion:(void (^)(ATPlace *place))completion;

@end
