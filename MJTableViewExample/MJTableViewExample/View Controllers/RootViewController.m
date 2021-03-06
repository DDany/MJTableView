//
//  RootViewController.m
//  MJTableViewExample
//
//  Created by Daniel Amitay on 8/15/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "RootViewController.h"

#import "InformationViewController.h"
#import "DynamicInsertionViewController.h"
#import "MixedCellsViewController.h"
#import "DynamicModificationViewController.h"
#import "WaterfallViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MJTableView";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:nil
                                                                            action:nil];
    
    MJTableSection *section0 = [MJTableSection section];
    section0.headerTitle = @"From DAModularTableViewExample";
    [self.tableView insertSection:section0];
    
    MJTableRow *informationView = [MJTableRow row];
    informationView.text = @"Information View";
    informationView.didSelectBlock = ^(NSIndexPath *indexPath){
        InformationViewController *ivc = [[InformationViewController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *inc = [[UINavigationController alloc] initWithRootViewController:ivc];
        [self presentViewController:inc
                           animated:YES
                         completion:nil];
    };
    [self.tableView insertRow:informationView];
    
    MJTableRow *dynamicInsertionRow = [MJTableRow row];
    dynamicInsertionRow.text = @"Dynamic Insertion";
    dynamicInsertionRow.didSelectBlock = ^(NSIndexPath *indexPath){
        DynamicInsertionViewController *divc = [[DynamicInsertionViewController alloc] init];
        [self.navigationController pushViewController:divc animated:YES];
    };
    [self.tableView insertRow:dynamicInsertionRow];
    
    MJTableRow *mixedCellsRow = [MJTableRow row];
    mixedCellsRow.text = @"Mixed Cells";
    mixedCellsRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MixedCellsViewController *mcvc = [[MixedCellsViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:mcvc animated:YES];
    };
    [self.tableView insertRow:mixedCellsRow];
    
    MJTableRow *waterfallRow = [MJTableRow row];
    waterfallRow.text = @"Waterfall Example";
    waterfallRow.didSelectBlock = ^(NSIndexPath *indexPath){
        WaterfallViewController *wvc = [[WaterfallViewController alloc] init];
        [self.navigationController pushViewController:wvc animated:YES];
    };
    [self.tableView insertRow:waterfallRow];
    
    MJTableSection *section1 = [MJTableSection section];
    section1.headerTitle = @"From MJTableViewExample";
    [self.tableView insertSection:section1];
    
    MJTableRow *dynamicModificationRow = [MJTableRow row];
    dynamicModificationRow.text = @"Dynamic Modification";
    dynamicModificationRow.didSelectBlock = ^(NSIndexPath *indexPath){
        DynamicModificationViewController *dmvc = [[DynamicModificationViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:dmvc animated:YES];
    };
    [self.tableView insertRow:dynamicModificationRow];
    
    MJTableRow *dynamicModificationTestRow = [MJTableRow row];
    dynamicModificationTestRow.text = @"Performance Test";
    dynamicModificationTestRow.didSelectBlock = ^(NSIndexPath *indexPath){
        DynamicModificationViewController *dmvc = [[DynamicModificationViewController alloc] initWithStyle:UITableViewStyleGrouped];
        dmvc.performanceTestMode = YES;
        [self.navigationController pushViewController:dmvc animated:YES];
    };
    [self.tableView insertRow:dynamicModificationTestRow];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
