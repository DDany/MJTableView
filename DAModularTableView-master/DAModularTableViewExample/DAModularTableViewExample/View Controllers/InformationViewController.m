//
//  InformationViewController.m
//  DAModularTableViewExample
//
//  Created by Daniel Amitay on 9/18/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Information";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(dismiss)];
	self.navigationItem.leftBarButtonItem = doneButton;
    
    MJTableSection *appSection = [MJTableSection section];
    appSection.footerHeight = 2.0f;
    [self.tableView insertSection:appSection];
    
    MJTableRow *appRow = [MJTableRow row];
    appRow.text = @"DAModularTableView";
    appRow.detailText = @"By Daniel Amitay";
    appRow.cellStyle = UITableViewCellStyleSubtitle;
    appRow.selectionStyle = UITableViewCellSelectionStyleNone;
    appRow.image = [UIImage imageNamed:@"icon"];
    appRow.rowHeight = 72.0f;
    [self.tableView insertRow:appRow];
    
    
    MJTableSection *settingsSection = [MJTableSection section];
    settingsSection.headerTitle = @"Settings";
    settingsSection.headerHeight = 35.0f;
    settingsSection.footerHeight = 2.0f;
    [self.tableView insertSection:settingsSection];
    
    MJTableRow *pushRow = [MJTableRow row];
    pushRow.text = @"Push Notifications";
    pushRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    pushRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tableRow.text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:pushRow];
    
    MJTableRow *otherRow = [MJTableRow row];
    otherRow.text = @"Other Preferences";
    otherRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    otherRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tableRow.text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:otherRow];
    
    
    MJTableSection *shareSection = [MJTableSection section];
    shareSection.headerTitle = @"Share";
    shareSection.headerHeight = 35.0f;
    [self.tableView insertSection:shareSection];
    
    MJTableRow *emailRow = [MJTableRow row];
    emailRow.text = @"Share via Email";
    emailRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tableRow.text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:emailRow];
    
    MJTableRow *smsRow = [MJTableRow row];
    smsRow.text = @"Share via SMS";
    smsRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tableRow.text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:smsRow];
    
    MJTableRow *twitterRow = [MJTableRow row];
    twitterRow.text = @"Share via Twitter";
    twitterRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:tableRow.text
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:twitterRow];
    
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
