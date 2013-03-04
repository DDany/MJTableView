//
//  DynamicModificationViewController.m
//  DAModularTableViewExample
//
//  Created by Daniel Amitay on 9/18/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DynamicModificationViewController.h"
#import "MJTable.h"
#import <QuartzCore/QuartzCore.h>

@interface DynamicModificationViewController ()

@end

@implementation DynamicModificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Performance Test";
    

    for (int i = 0; i < (self.performanceTestMode ? 99 : 1); i++) {
        
    //////////////////////////////////////////////////////////////////
    // section header
    MJTableSection *section_header = [MJTableSection section];
    section_header.headerHeight = 80;
    section_header.headerView = [self dynamicHeaderView:80];
    
    //////////////////////////////////////////////////////////////////
    // section 0
    MJTableSection *section0 = [MJTableSection section];
    
    // header change row
    MJTableRow *headerChangeRow = [MJTableRow row];
    headerChangeRow.reuseIdentifier = @"headerChangeRow";
    headerChangeRow.text = @"                header Change";
    headerChangeRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    headerChangeRow.rowHeight = 32.0f;
    headerChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableSection *section = [self.tableView sectionAtIndex:0];
        section.headerHeight = section.headerHeight == 80 ? 160 : 80;
        section.headerView = [self dynamicHeaderView:section.headerHeight];
        [self.tableView reloadSection:section animated:YES];
    };
    [section0.rows addObject:headerChangeRow];
    
    // height change row
    MJTableRow *heightChangeRow = [MJTableRow row];
    heightChangeRow.reuseIdentifier = @"heightChangeRow";
    heightChangeRow.text = @"                Height Change";
    heightChangeRow.rowHeight = 32.0f;
    heightChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJTableRow *row = [self.tableView rowAtIndexPath:indexPath];
        row.rowHeight = (row.rowHeight == 32.0f ? 120.0f : 32.0f);
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    };
    [section0.rows addObject:heightChangeRow];
    
    // text change row
    MJTableRow *textChangeRow = [MJTableRow row];
    textChangeRow.reuseIdentifier = @"textChangeRow";
    textChangeRow.text = @"Text Change";
    textChangeRow.didSelectBlock = ^(NSIndexPath *indexPath){
        self.view.tag += 1;
        MJTableRow *tableRow = [self.tableView rowAtIndexPath:indexPath];
        tableRow.text = [NSString stringWithFormat:@"Text Change (%d)", self.view.tag];
        [self.tableView reloadRow:tableRow animated:YES];
    };
    [section0.rows addObject:textChangeRow];

    // multiline text row
    MJTableRow *multiLineRow = [MJTableRow row];
    multiLineRow.reuseIdentifier = @"multiLineRow";
    multiLineRow.text = @"Multiline Text";
    multiLineRow.isDetailTextMultiLine = YES;
    multiLineRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    multiLineRow.detailText = @"他人的个人资料 TA的拼车里没有发布过事件的情况下 您的附近暂无人拼车改为：TA暂没有发布过拼车";
    
    [section0.rows addObject:multiLineRow];
    
    // style change row
    MJTableRow *styleChangeRow = [MJTableRow row];
    styleChangeRow.reuseIdentifier = @"styleChangeRow";
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
    dateRow.reuseIdentifier = @"dateRow";
    dateRow.text = @"Date row";
    dateRow.onValueChanged = ^(NSDate *newDate){
        NSLog(@"log here:%@", newDate);
    };
    [section0.rows addObject:dateRow];
    
    // integer input row
    MJIntegerInputTableRow *integerRow = [MJIntegerInputTableRow row];
    integerRow.reuseIdentifier = @"integerRow";
    integerRow.text = @"Integer Row";
    integerRow.value = 5;
    integerRow.limitLength = 2;
    integerRow.onValueChanged = ^(NSString *newText){
        NSLog(@"log here:%@", newText);
    };
    [section0.rows addObject:integerRow];
    
    // text input row
    MJTextFieldTableRow *textFieldRow = [MJTextFieldTableRow row];
    textFieldRow.reuseIdentifier = @"textFieldRow";
    textFieldRow.text = @"Text field row";
    textFieldRow.placeHolder = @"请输入字符";
    textFieldRow.onValueChanged = ^(NSString *newText){
        NSLog(@"log here:%@", newText);
    };
    [section0.rows addObject:textFieldRow];

    // multiple text show row
    MJTextViewTableRow *textViewRow = [MJTextViewTableRow row];
    textViewRow.reuseIdentifier = @"textViewRow";
    textViewRow.text = @"多行显示";
    textViewRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    textViewRow.selectionStyle = UITableViewCellSelectionStyleBlue;
    textViewRow.stringValue = @"浦东南路3905号,博文园,6号502室(云台路地铁站3号口)";
    textViewRow.dynamicAdjustRowHeightWhenShow = YES;
    textViewRow.editable = NO;
    textViewRow.minRowHeight = 44;
    textViewRow.didSelectBlock = ^(NSIndexPath *indexPath){
        NSLog(@"log here:Multiple text show row selected.");
    };
    [section0.rows addObject:textViewRow];
    
    // multiple text input row
    MJTextViewTableRow *textViewEditRow = [MJTextViewTableRow row];
    textViewEditRow.reuseIdentifier = @"textViewEditRow";
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
    
    //////////////////////////////////////////////////////////////////
    // section 1
    MJTableSection *section1 = [MJTableSection section];
    
    // button row
    MJTableRow *buttonRow = [MJTableRow row];
    buttonRow.reuseIdentifier = @"buttonRow";
    buttonRow.text = @"                         我的拼车";
    buttonRow.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    buttonRow.selectionStyle = UITableViewCellSelectionStyleBlue;
    buttonRow.didSelectBlock = ^(NSIndexPath *indexPath){
        NSLog(@"log here:Button row selected.");
    };
    [section1.rows addObject:buttonRow];
    
    // split row
    MJSplitTableRow *splitRow = [MJSplitTableRow row];
    splitRow.reuseIdentifier = @"splitRow";
    splitRow.rowHeight = 36.0;
    splitRow.alignment = SplitTextAlignmentVertical;
    splitRow.titles = @[@"拼车次数", @"赞", @"没到"];
    splitRow.values = @[@"227", @"3", @"2"];
    splitRow.didSelectBlock = ^(NSIndexPath *indexPath){
        MJSplitTableRow *tableRow = (MJSplitTableRow *)[self.tableView rowAtIndexPath:indexPath];
        if ([tableRow isKindOfClass:[MJSplitTableRow class]]) {
            tableRow.alignment = tableRow.alignment == SplitTextAlignmentHorizontal ? SplitTextAlignmentVertical : SplitTextAlignmentHorizontal;
            [self.tableView reloadRow:tableRow animated:YES];
        }
    };
    
    [section1.rows addObject:splitRow];
    
    // custom row
    MJTableRow *customRow = [MJTableRow row];
    customRow.reuseIdentifier = @"customRow";
    customRow.rowHeight = 76.0f;
    customRow.cellForRowBlock = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        UIImage *route_prev = [UIImage imageNamed:@"map_route_prev.png"];
        UIImageView *route_prev_view = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 288, 60)];
        route_prev_view.image = route_prev;
        route_prev_view.contentMode = UIViewContentModeScaleAspectFill;
        //route_prev_view.layer.cornerRadius = 5.0;
        route_prev_view.layer.masksToBounds = NO;
        route_prev_view.layer.shouldRasterize = YES;
        route_prev_view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:route_prev_view];
    };
    
    [section1.rows addObject:customRow];
    
    //////////////////////////////////////////////////////////////////
    // section 2
    MJTableSection *section2 = [MJTableSection section];
    
    // segemented row
    MJSegmentedTableRow *segmentedRow = [MJSegmentedTableRow row];
    segmentedRow.reuseIdentifier = @"segmentedRow";
    segmentedRow.text = @"Segmented Row";
    segmentedRow.titles = @[@"1", @"2", @"3"];
    segmentedRow.keys = @[@"11", @"22", @"33"];
    segmentedRow.rowHeight = 44.0f;
    segmentedRow.onValueChanged = ^(id newKey) {
        NSLog(@"log here:%@", newKey);
    };
    [section2.rows addObject:segmentedRow];
    
    [self.tableView insertSection:section_header];
    [self.tableView insertSection:section0];
    [self.tableView insertSection:section1];
    [self.tableView insertSection:section2];
        
    }

}

- (UIView *)dynamicHeaderView:(CGFloat)height {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    view.backgroundColor = [UIColor grayColor];
    
    
    return view;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
