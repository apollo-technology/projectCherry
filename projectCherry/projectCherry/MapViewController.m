//
//  MapViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "MapViewController.h"
#import "MapFilterView.h"

@interface MapViewController (){
    
}

@end

@implementation MapViewController

-(void)loadMapZoom{
    MKCoordinateRegion region;
    region.center.latitude = 44.763693;
    region.center.longitude = -85.620771;
    region.span.longitudeDelta = 0.006613;
    region.span.latitudeDelta = 0.006936;
    [self.mapView setRegion:region animated:YES];
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}

-(IBAction)filterView:(id)sender{
    MapFilterView *popUp = [self.storyboard instantiateViewControllerWithIdentifier:@"mapFilterView"];
    popUp.delegate = self;
    popUp.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    popUp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:popUp animated:YES completion:^{
        
    }];
}

-(void)mapFilterFinishedPickingWithOptions:(NSArray *)options{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMapZoom];
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
        
    }
    
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(44.763693, -85.620771);
    myAnnotation.title = @"Matthews Pizza";
    myAnnotation.subtitle = @"Best Pizza in Town";
    [self.mapView addAnnotation:myAnnotation];
    [self.mapView setShowsPointsOfInterest:NO];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSString *title, *subtitle;
    title = view.annotation.title;
    subtitle = view.annotation.subtitle;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    } else {
        // Handle any custom annotations.
        if ([annotation isKindOfClass:[MKPointAnnotation class]]){
            // Try to dequeue an existing pin view first.
            MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ew"];
            if (!pinView)
            {
                // If an existing pin view was not available, create one.
                pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ew"];
                pinView.animatesDrop = YES;
                pinView.canShowCallout = YES;
                
                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                pinView.rightCalloutAccessoryView = rightButton;
            } else {
                pinView.annotation = annotation;
                pinView.annotation = nil;
            }
            return pinView;
        } else {
            return nil;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
