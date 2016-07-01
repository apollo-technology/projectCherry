//
//  BusinessPlaceViewController.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/23/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "BusinessPlaceViewController.h"

@interface BusinessPlaceViewController (){
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *websiteField;
    IBOutlet UILabel *typeLabel;
    IBOutlet UITableViewCell *typeCell;
    IBOutlet UITableViewCell *trendsCell;
    
    UIPickerView *picker;
    NSInteger pickedRow;
    NSArray *pickerData;
    
    PCPlace *place;
}

@end

@implementation BusinessPlaceViewController

-(void)viewDidAppear:(BOOL)animated{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 80);
    spinner.color = [UIColor grayColor];
    [spinner startAnimating];
    [alert.view addSubview:spinner];
    [self presentViewController:alert animated:YES completion:^{
        [PCController getPlaceForId:[PCBusinessManager getBusinessId] completion:^(PCPlace *placeData, BOOL succeeded) {
            place = placeData;
            [self dismissViewControllerAnimated:YES completion:^{
                [self setView];
            }];
        }];
    }];
}

-(void)resignKeyboard{
    [self.view endEditing:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setClipsToBounds:NO];
    [toolbar setTranslucent:NO];
    [toolbar sizeToFit];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton,doneButton, nil];
    
    [toolbar setItems:itemsArray];
    toolbar.backgroundColor = [UIColor colorWithRed:0.820 green:0.835 blue:0.855 alpha:1.00];
    toolbar.barTintColor = [UIColor colorWithRed:0.820 green:0.835 blue:0.855 alpha:1.00];
    toolbar.clipsToBounds = YES;
    toolbar.translucent = NO;
    [nameField setInputAccessoryView:toolbar];
    [phoneField setInputAccessoryView:toolbar];
    [websiteField setInputAccessoryView:toolbar];
}

-(void)setView{
    nameField.text = place.name;
    phoneField.text = place.phoneNumber;
    websiteField.text = place.website;
    typeLabel.text = [PCBusinessManager decodedTypeFromString:place.type];
    self.navigationItem.title = place.pcId;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (selectedCell == typeCell) {
        [self presentPickerWithData:[PCBusinessManager getTypeArray] title:@"Select a Type" completion:^(NSString *value) {
            typeLabel.text = value;
            NSLog(@"%@",[PCBusinessManager codedTypeFromString:value]);
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
    } else if (selectedCell == trendsCell) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void)presentPickerWithData:(NSArray *)array title:(NSString *)title completion:(void (^)(NSString *value))completionHandler{
    [self.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@\n\n\n\n\n\n",title] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 50, 230, 140)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerData = array;
    pickedRow = 0;
    [alertController.view addSubview:pickerView];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(array[pickedRow]);
    }]];
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    pickedRow = row;
}


@end
