//
//  PlaceViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//
#import <SafariServices/SafariServices.h>
#import "PlaceViewController.h"

@interface PlaceViewController (){
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *directionButton;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UITableViewCell *phoneCell;
    IBOutlet UILabel *hompageLabel;
    IBOutlet UITableViewCell *homepageCell;
    IBOutlet UILabel *addressLabel;
    IBOutlet UITableViewCell *addressCell;
    IBOutlet UIView *imageSelectView;
}

@end

@implementation PlaceViewController

@synthesize place;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageView.alpha = 0;
    titleLabel.text = place.name;
    phoneLabel.text = place.phoneNumber;
    hompageLabel.text = place.website;
    addressLabel.text = [place.address stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    if (place.images.count > 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //background thread
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:place.images[0]]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //main thread
                imageView.image = image;
                [UIView animateWithDuration:0.5 animations:^{
                    imageView.alpha = 1;
                }];
            });
        });
    } else {
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([place.lat intValue], [place.lng intValue]);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
        [mapView setRegion:adjustedRegion];
        mapView.mapType =  MKMapTypeStandard;
        [imageView addSubview:mapView];
    }
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [imageSelectView addGestureRecognizer:imageTap];
    [titleLabel addGestureRecognizer:imageTap];
    
}

-(void)tapImage{
    NSLog(@"Tapped Image");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell == phoneCell) {
        NSString *phoneNumber = [place.phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneNumber = [NSString stringWithFormat:@"tel://%@",phoneNumber];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Place Call" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
        } else {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    } else if (selectedCell == homepageCell) {
        if (![place.website isEqualToString:@"ATENTER"]) {
            SFSafariViewController *browser = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:place.website]];
            [self presentViewController:browser animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
        } else {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    } else if (selectedCell == addressCell) {
        
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
