//
//  PlaceViewController.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCController.h"
#import <MapKit/MapKit.h>

@interface PlaceViewController : UITableViewController <MKMapViewDelegate> {
    PCPlace *place;
}

@property PCPlace *place;

@end
