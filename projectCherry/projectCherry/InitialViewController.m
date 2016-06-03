//
//  InitialViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/3/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "InitialViewController.h"
#import "ATPlaceController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

-(void)viewDidAppear:(BOOL)animated{
    [ATPlaceController getPlaces:^(BOOL succeeded) {
        [self performSegueWithIdentifier:@"home" sender:nil];
    }];
}

@end
