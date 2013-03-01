//
//  MJTextFieldTableViewCell.m
//  MJTableViewExample
//
//  Created by xudong on 13-1-26.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextFieldTableViewCell.h"
#import "MJTextFieldTableRow.h"

@interface MJTextFieldTableViewCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;

@end

@implementation MJTextFieldTableViewCell
{
    UIToolbar           *inputAccessoryView;
}

- (void)initialize {
	// Initialization code
	self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
	self.textField.autocorrectionType = UITextAutocorrectionTypeDefault;
	self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	self.textField.textAlignment = NSTextAlignmentRight;
	self.textField.font = [UIFont systemFontOfSize:16.0f];
	self.textField.clearButtonMode = UITextFieldViewModeNever;
	self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self addSubview:self.textField];
	
	self.textField.delegate = self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
		[self initialize];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	if (selected) {
		[self.textField becomeFirstResponder];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		[self.textField becomeFirstResponder];
	}
}

#pragma mark
- (void)prepareForRow:(MJTextFieldTableRow *)row
{
    [super prepareForRow:row];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.accessoryType = UITableViewCellAccessoryNone;
    
    self.textField.text = ((MJTextFieldTableRow *)self.row).stringValue;
    self.textField.placeholder = ((MJTextFieldTableRow *)self.row).placeHolder;
    self.textField.autocorrectionType = ((MJTextFieldTableRow *)self.row).autocorrectionType;
	self.textField.autocapitalizationType = ((MJTextFieldTableRow *)self.row).autocapitalizationType;
	self.textField.textAlignment = NSTextAlignmentRight;
	self.textField.font = [UIFont systemFontOfSize:16.0f];
	self.textField.clearButtonMode = UITextFieldViewModeNever;
	self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.spellCheckingType = ((MJTextFieldTableRow *)self.row).spellCheckingType;
    self.textField.keyboardType = ((MJTextFieldTableRow *)self.row).keyboardType;
    self.textField.keyboardAppearance = ((MJTextFieldTableRow *)self.row).keyboardAppearance;
    self.textField.returnKeyType = ((MJTextFieldTableRow *)self.row).returnKeyType;
    self.textField.enablesReturnKeyAutomatically = ((MJTextFieldTableRow *)self.row).enablesReturnKeyAutomatically;
    self.textField.secureTextEntry = ((MJTextFieldTableRow *)self.row).secureTextEntry;
}

#pragma mark
- (void)setStringValue:(NSString *)value {
	self.textField.text = value;
}

- (NSString *)stringValue {
	return self.textField.text;
}

#pragma mark
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

- (void)done:(id)sender {
	[self.textField resignFirstResponder];
}

#pragma mark
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	UITableView *tableView = [self tableView];
	[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (((MJTextFieldTableRow *)self.row).onValueChanged) {
        ((MJTextFieldTableRow *)self.row).onValueChanged(textField.text);
    }
    return YES;
}

#pragma mark
- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect editFrame = CGRectInset(self.contentView.frame, 10, 0);
	
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.origin.x += textSize.width + 10;
        editFrame.origin.y = self.textLabel.frame.origin.y;
		editFrame.size.width -= textSize.width + 10;
		self.textField.textAlignment = NSTextAlignmentRight;
	} else {
		CGSize textSize = [self.textField sizeThatFits:CGSizeZero];
        editFrame.origin.y = (self.contentView.frame.size.height - textSize.height)/2;
		self.textField.textAlignment = NSTextAlignmentRight;
	}

	self.textField.frame = editFrame;
}


@end
