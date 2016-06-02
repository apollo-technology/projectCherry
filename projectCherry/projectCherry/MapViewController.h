//
//  MapViewController.h
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapFilterView.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, MapFilterViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
