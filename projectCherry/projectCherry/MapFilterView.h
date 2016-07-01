//
//  MapFilterView.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapFilterView;

@protocol MapFilterViewDelegate <NSObject>

-(void)mapFilterFinishedPickingWithOptions:(int)options;

@end


@interface MapFilterView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <MapFilterViewDelegate> delegate;

@end