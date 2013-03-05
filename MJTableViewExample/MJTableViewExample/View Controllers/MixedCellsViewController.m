//
//  MixedCellsViewController.m
//  MJTableViewExample
//
//  Created by Daniel Amitay on 9/18/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MixedCellsViewController.h"

@interface MixedCellsViewController ()

@end

@implementation MixedCellsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Mixed Cells";
    
    MJTableSection *selectionSection = [MJTableSection section];
    selectionSection.headerTitle = @"Selection Styles";
    [self.tableView insertSection:selectionSection];
    
    MJTableRow *blueSelectionRow = [MJTableRow row];
    blueSelectionRow.text = @"Blue";
    blueSelectionRow.selectionStyle = UITableViewCellSelectionStyleBlue;
    blueSelectionRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:blueSelectionRow];
    
    MJTableRow *graySelectionRow = [MJTableRow row];
    graySelectionRow.text = @"Gray";
    graySelectionRow.selectionStyle = UITableViewCellSelectionStyleGray;
    graySelectionRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:graySelectionRow];
    
    MJTableRow *noneSelectionRow = [MJTableRow row];
    noneSelectionRow.text = @"None";
    noneSelectionRow.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableView insertRow:noneSelectionRow];
    
    
    MJTableSection *cellStyleSection = [MJTableSection section];
    cellStyleSection.headerTitle = @"Cell Styles";
    [self.tableView insertSection:cellStyleSection];
    
    MJTableRow *defaultStyleRow = [MJTableRow row];
    defaultStyleRow.text = @"Default";
    defaultStyleRow.detailText = @"detailText";
    defaultStyleRow.cellStyle = UITableViewCellStyleDefault;
    defaultStyleRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:defaultStyleRow];
    
    MJTableRow *subtitleStyleRow = [MJTableRow row];
    subtitleStyleRow.text = @"Subtitle";
    subtitleStyleRow.detailText = @"detailText";
    subtitleStyleRow.cellStyle = UITableViewCellStyleSubtitle;
    subtitleStyleRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:subtitleStyleRow];
    
    MJTableRow *value1StyleRow = [MJTableRow row];
    value1StyleRow.text = @"Value1";
    value1StyleRow.detailText = @"detailText";
    value1StyleRow.cellStyle = UITableViewCellStyleValue1;
    value1StyleRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:value1StyleRow];
    
    MJTableRow *value2StyleRow = [MJTableRow row];
    value2StyleRow.text = @"Value2";
    value2StyleRow.detailText = @"detailText";
    value2StyleRow.cellStyle = UITableViewCellStyleValue2;
    value2StyleRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:value2StyleRow];
    
    
    MJTableSection *accessoryTypeSection = [MJTableSection section];
    accessoryTypeSection.headerTitle = @"Accessory Types";
    [self.tableView insertSection:accessoryTypeSection];
    
    MJTableRow *checkmarkAccessoryRow = [MJTableRow row];
    checkmarkAccessoryRow.text = @"Checkmark";
    checkmarkAccessoryRow.accessoryType = UITableViewCellAccessoryCheckmark;
    checkmarkAccessoryRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:checkmarkAccessoryRow];
    
    MJTableRow *detailDisclosureAccessoryRow = [MJTableRow row];
    detailDisclosureAccessoryRow.text = @"Detail Disclosure";
    detailDisclosureAccessoryRow.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    detailDisclosureAccessoryRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:detailDisclosureAccessoryRow];
        
    MJTableRow *disclosureAccessoryRow = [MJTableRow row];
    disclosureAccessoryRow.text = @"Disclosure";
    disclosureAccessoryRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    disclosureAccessoryRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:disclosureAccessoryRow];
    
    
    MJTableSection *cellHeightSection = [MJTableSection section];
    cellHeightSection.headerTitle = @"Row Height";
    [self.tableView insertSection:cellHeightSection];
    
    MJTableRow *height10Row = [MJTableRow row];
    height10Row.text = @"10 points";
    height10Row.rowHeight = 10.0f;
    height10Row.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:height10Row];
    
    MJTableRow *height20Row = [MJTableRow row];
    height20Row.text = @"20 points";
    height20Row.rowHeight = 20.0f;
    height20Row.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:height20Row];
    
    MJTableRow *height40Row = [MJTableRow row];
    height40Row.text = @"40 points";
    height40Row.rowHeight = 40.0f;
    height40Row.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:height40Row];
    
    MJTableRow *height80Row = [MJTableRow row];
    height80Row.text = @"80 points";
    height80Row.rowHeight = 80.0f;
    height80Row.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:height80Row];
    
    MJTableRow *height160Row = [MJTableRow row];
    height160Row.text = @"160 points";
    height160Row.rowHeight = 160.0f;
    height160Row.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [self.tableView insertRow:height160Row];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
