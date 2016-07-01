//
//  MapFilterView.m
//  projectCherry
//
//  Created by Elijah Cobb on 6/2/16.
//  Copyright © 2016 Apollo Technology. All rights reserved.
//

#import "MapFilterView.h"

@interface MapFilterView (){
    IBOutlet UIView *cardView;
    IBOutlet UITableView *pickerTable;
    NSArray *pickableContent;
    int pickedIndex;
}

@end

@implementation MapFilterView

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cardView.layer.masksToBounds = NO;
    cardView.layer.shadowOffset = CGSizeMake(-10, 30);
    cardView.layer.shadowRadius = 10;
    cardView.layer.shadowOpacity = 0.8;
    //pickerTable.allowsMultipleSelection = YES;

    pickableContent = @[@"Restaraunt",@"Hotel",@"Restroom",@"Drinking Fountain",@"Park",@"Beach",@"Groceries",@"Merchandise Store",@"Movie Theatre",@"ATM",@"Bank",@"Post Office Mailbox",@"Gov Buildings"];
    
    pickedIndex = 69;
}

-(IBAction)done:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate mapFilterFinishedPickingWithOptions:pickedIndex];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pickableContent.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    // if you don't use a custom image then
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
    pickedIndex = (int)indexPath.row;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    // if you don't use a custom image then
    tableViewCell.accessoryType = UITableViewCellAccessoryNone;
    pickedIndex = 69;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = pickableContent[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:17];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (pickedIndex == (int)indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
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