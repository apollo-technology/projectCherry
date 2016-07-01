//
//  MapViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "MapViewController.h"
#import "MapFilterView.h"
#import <Parse/Parse.h>
#import "CollectionViewCell.h"
#import "PCController.h"
#import "PlaceViewController.h"

@interface MapViewController (){
    IBOutlet UIToolbar *cancelBar;
    IBOutlet UIBarButtonItem *filterButton;
    IBOutlet UIView *filterView;
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

-(IBAction)filterButtonAction:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        filterView.alpha = 1;
    } completion:^(BOOL finished) {
        _mapView.userInteractionEnabled = NO;
        filterButton.enabled = NO;
    }];
}

-(IBAction)cancelButtonAction:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        filterView.alpha = 0;
    } completion:^(BOOL finished) {
        _mapView.userInteractionEnabled = YES;
        filterButton.enabled = YES;
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    cell.layer.cornerRadius = 30.5;
    cell.layer.borderColor = [[UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.00] CGColor];
    cell.layer.borderWidth = 1;
    cell.iconImage.image = [UIImage imageNamed:@"back1.jpg"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMapZoom];
    
    
    self.mapView.delegate = self;
    
    filterView.alpha = 0;
    
    cancelBar.layer.borderColor = [[UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.00] CGColor];
    
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
    [self.mapView setShowsPointsOfInterest:NO];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(44.7256083, -85.6392635);
    myAnnotation.title = @"Jackson Hewitt Tax Service";
    myAnnotation.subtitle = @"accounting";
    [self.mapView addAnnotation:myAnnotation];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSString *title, *subtitle;
    title = view.annotation.title;
    subtitle = view.annotation.subtitle;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Finding Place...\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 80);
    spinner.color = [UIColor grayColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [self presentViewController:alert animated:YES completion:^{
        [mapView deselectAnnotation:view.annotation animated:YES];
        PFQuery *query = [PFQuery queryWithClassName:@"places"];
        [query whereKey:@"name" equalTo:title];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            NSLog(@"%@",object);
        }];
    }];
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
