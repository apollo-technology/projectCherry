//
//  DevelopersViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "DevelopersViewController.h"
#import "IonIcons.h"

@interface DevelopersViewController (){
    IBOutlet UIView *topCard;
    IBOutlet UIView *bottomCard;
    IBOutlet UIBarButtonItem *topEmailButton;
    IBOutlet UIBarButtonItem *topPhoneButton;
    IBOutlet UIBarButtonItem *bottomEmailButton;
    IBOutlet UIBarButtonItem *bottomPhoneButton;
}

@end

@implementation DevelopersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCardForView:topCard];
    [self createCardForView:bottomCard];
    
    topEmailButton.image = [IonIcons imageWithIcon:ioniosemailoutline];
    topPhoneButton.image = [IonIcons imageWithIcon:ioniostelephoneoutline];
    bottomEmailButton.image = [IonIcons imageWithIcon:ioniosemailoutline];
    bottomPhoneButton.image = [IonIcons imageWithIcon:ioniostelephoneoutline];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createCardForView:(UIView *)view{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(-10, 30);
    view.layer.shadowRadius = 10;
    view.layer.shadowOpacity = 0.8;
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
