//
//  MJDateTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-1-23.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJDateTableViewCell.h"
#import "MJDateTableRow.h"

@interface MJDateTableViewCell ()

@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation MJDateTableViewCell
{
    UIToolbar           *inputAccessoryView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

#pragma mark - init
- (void)initialize {
    self.dateValue = [NSDate date];
	
    // Initialization code
	self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	[self.datePicker setDatePickerMode:UIDatePickerModeDate];
	self.datePicker.date = self.dateValue;
	[self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
	
    CGRect frame = self.inputView.frame;
    frame.size = [self.datePicker sizeThatFits:CGSizeZero];
    self.inputView.frame = frame;
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	self.dateFormatter = [[NSDateFormatter alloc] init];
	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	
	self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
}

#pragma mark 
- (void)prepareForRow:(MJDateTableRow *)row {
    [super prepareForRow:row];
    
    [self.dateFormatter setDateFormat:row.showDateFormatter];
    self.dateValue = row.dateValue;
    
    self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
}

#pragma mark
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self becomeFirstResponder];
    }
}

#pragma mark
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    UITableView *tableView = [self tableView];
    if ([tableView isKindOfClass:[UITableView class]]) {
        [tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
    }
	return [super resignFirstResponder];
}

#pragma mark
- (UIView *)inputView {
    return self.datePicker;
}

- (UIView *)inputAccessoryView {
	if (!inputAccessoryView) {
        inputAccessoryView = [[UIToolbar alloc] init];
        inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
        //inputAccessoryView.tintColor = [UIColor redColor];
        inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [inputAccessoryView sizeToFit];
        CGRect frame = inputAccessoryView.frame;
        frame.size.height = 44.0f;
        inputAccessoryView.frame = frame;
        
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
        [inputAccessoryView setItems:array];
    }
    return inputAccessoryView;
}

#pragma mark
- (void)done:(id)sender {
	[self resignFirstResponder];
}

- (void)dateChanged:(id)sender {
	((MJDateTableRow *)self.row).dateValue = ((UIDatePicker *)sender).date;
    
	self.detailTextLabel.text = [self.dateFormatter stringFromDate:((MJDateTableRow *)self.row).dateValue];

    self.dateValue = ((MJDateTableRow *)self.row).dateValue;

    if (((MJDateTableRow *)self.row).onValueChanged) {
        ((MJDateTableRow *)self.row).onValueChanged(((MJDateTableRow *)self.row).dateValue);
    }
}

@end
