//
//  SearchViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/20/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "SearchViewController.h"
#import "PCController.h"

@interface SearchViewController (){
    IBOutlet UITextField *textField;
}

@end

@implementation SearchViewController

-(IBAction)search:(id)sender{
    [textField resignFirstResponder];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 80);
    spinner.color = [UIColor grayColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [self presentViewController:alert animated:YES completion:^{
        [PCController getPlacesForSearch:textField.text completion:^(NSArray *places, BOOL succeeded) {
            [self dismissViewControllerAnimated:YES completion:^{
                if (places.count > 1) {
                    PCPlace *place = [places firstObject];
                    [PCController presentPlaceViewControllerWithPlace:place delegate:self];
                } else {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Results" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
