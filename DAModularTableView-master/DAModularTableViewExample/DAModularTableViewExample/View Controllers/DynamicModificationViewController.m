//
//  DynamicModificationViewController.m
//  DAModularTableViewExample
//
//  Created by Daniel Amitay on 9/18/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DynamicModificationViewController.h"
#import "MJTable.h"

@interface DynamicModificationViewController ()

@end

@implementation DynamicModificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Dynamic Modification";
    
    //////////////////////////////////////////////////////////////////
    // section 0
    MJTableSection *section0 = [MJTableSection section];
    
    // height change row
    MJTableRow *heightChangeRow = [MJTableRow row];
    heightChangeRow.text = @"                Height Change";
    heightChangeRow.rowHeight = 32.0f;
    heightChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *row = [self.tableView rowAtIndexPath:indexPath];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        row.rowHeight = (row.rowHeight == 32.0f ? 120.0f : 32.0f);
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    [section0.rows addObject:heightChangeRow];
    
    // text change row
    MJTableRow *textChangeRow = [MJTableRow row];
    textChangeRow.text = @"Text Change";
    textChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        self.view.tag += 1;
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        tableRow.text = [NSString stringWithFormat:@"Text Change (%d)", self.view.tag];
        [self.tableView reloadRow:tableRow animated:YES];
    };
    [section0.rows addObject:textChangeRow];

    // style change row
    MJTableRow *styleChangeRow = [MJTableRow row];
    styleChangeRow.text = @"Style Change";
    styleChangeRow.detailText = @"Detail Text";
    styleChangeRow.cellStyle = UITableViewCellStyleValue1;
    styleChangeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    styleChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        tableRow.cellStyle = (tableRow.cellStyle == UITableViewCellStyleValue1 ? UITableViewCellStyleSubtitle : UITableViewCellStyleValue1);
        tableRow.accessoryType = (tableRow.accessoryType == UITableViewCellAccessoryDisclosureIndicator ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryDisclosureIndicator);
        [self.tableView reloadRow:tableRow animated:YES];
    };
    [section0.rows addObject:styleChangeRow];

    // date row
    MJDateTableRow *dateRow = [MJDateTableRow row];
    dateRow.rowHeight = 44;
    dateRow.text = @"Date row";
    dateRow.onValueChanged = ^(NSDate *newDate){
        NSLog(@"log here:%@", newDate);
    };
    [section0.rows addObject:dateRow];
    
    // text input row
    MJTextFieldTableRow *textFieldRow = [MJTextFieldTableRow row];
    textFieldRow.text = @"Text field row";
    textFieldRow.rowHeight = 44;
    textFieldRow.placeHolder = @"请输入字符";
    textFieldRow.onValueChanged = ^(NSString *newText){
        NSLog(@"log here:%@", newText);
    };
    [section0.rows addObject:textFieldRow];

    // multiple text show row
    MJTextViewTableRow *textViewRow = [MJTextViewTableRow row];
    textViewRow.text = @"多行显示";
    textViewRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    textViewRow.selectionStyle = UITableViewCellSelectionStyleBlue;
    textViewRow.stringValue = @"浦东南路3905号,博文园,6号502室(云台路地铁站3号口)";
    textViewRow.dynamicAdjustRowHeightWhenShow = YES;
    textViewRow.editable = NO;
    textViewRow.minRowHeight = 44;
    textViewRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"log here:Multiple text show row selected.");
    };
    [section0.rows addObject:textViewRow];
    
    // multiple text input row
    MJTextViewTableRow *textViewEditRow = [MJTextViewTableRow row];
    textViewEditRow.showTextViewBolderWhenEdit = YES;
    textViewEditRow.text = @"多行输入";
    textViewEditRow.stringValue = @"浦东南路3905号,博文园,6号502室(云台路地铁站3号口)";
    //textViewRow.rowHeight = 70;
    textViewEditRow.dynamicAdjustRowHeightWhenEdit = YES;
    textViewEditRow.minRowHeight = 44;
    textViewEditRow.onValueChanged = ^(NSString *newText){
        NSLog(@"log here:%@", newText);
    };
    [section0.rows addObject:textViewEditRow];

    [self.tableView insertSection:section0];
    
    //////////////////////////////////////////////////////////////////
    // section 1
    MJTableSection *section1 = [MJTableSection section];
    
    // button row
    MJTableRow *buttonRow = [MJTableRow row];
    buttonRow.text = @"                         我的拼车";
    buttonRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    buttonRow.selectionStyle = UITableViewCellSelectionStyleBlue;
    buttonRow.didSelectBlock = ^(NSIndexPath *indexPath){
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"log here:Button row selected.");
    };
    [section1.rows addObject:buttonRow];
    
    // split row
    __weak MJSplitTableRow *splitRow = [MJSplitTableRow row];
    splitRow.rowHeight = 36.0;
    splitRow.alignment = SplitTextAlignmentVertical;
    splitRow.titles = @[@"拼车次数", @"赞", @"没到"];
    splitRow.values = @[@"227", @"3", @"2"];
    splitRow.didSelectBlock = ^(NSIndexPath *indexPath){
        splitRow.alignment = splitRow.alignment == SplitTextAlignmentHorizontal ? SplitTextAlignmentVertical : SplitTextAlignmentHorizontal;
        [self.tableView reloadRow:splitRow animated:YES];
    };
    
    [section1.rows addObject:splitRow];

    [self.tableView insertSection:section1];
    
    //////////////////////////////////////////////////////////////////
    // section 2
    MJTableSection *section2 = [MJTableSection section];
    
    // segemented row
    MJSegmentedTableRow *segmentedRow = [MJSegmentedTableRow row];
    segmentedRow.text = @"Segmented Row";
    segmentedRow.titles = @[@"1", @"2", @"3"];
    segmentedRow.keys = @[@"11", @"22", @"33"];
    segmentedRow.rowHeight = 44.0f;
    segmentedRow.onValueChanged = ^(id newKey) {
        NSLog(@"log here:%@", newKey);
    };
    [section2.rows addObject:segmentedRow];
    
    [self.tableView insertSection:section2];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
