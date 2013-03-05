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
    UILabel             *messageLabel;
    NSTimer             *messageTimer;
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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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

- (void)dealloc {
    if (messageTimer) {
        [messageTimer invalidate];
        messageTimer = nil;
    }
}

#pragma mark - Select
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

#pragma mark - Custom cell
- (void)prepareForRow:(MJTextFieldTableRow *)row {
    [super prepareForRow:row];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.accessoryType = UITableViewCellAccessoryNone;
    
    self.textField.text = row.stringValue;
    self.textField.textColor = row.detailTextColor;
    self.textField.placeholder = row.placeHolder;
    self.textField.autocorrectionType = row.autocorrectionType;
	self.textField.autocapitalizationType = row.autocapitalizationType;
	self.textField.textAlignment = NSTextAlignmentRight;
	self.textField.font = row.detailTextFont;
	self.textField.clearButtonMode = UITextFieldViewModeNever;
	self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.spellCheckingType = row.spellCheckingType;
    self.textField.keyboardType = row.keyboardType;
    self.textField.keyboardAppearance = row.keyboardAppearance;
    self.textField.returnKeyType = row.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = row.enablesReturnKeyAutomatically;
    self.textField.secureTextEntry = row.secureTextEntry;
}

#pragma mark - Getter - Setter


#pragma mark - Message Timer
- (void)startMessageTimer {
    messageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(clearMessage) userInfo:nil repeats:YES];
}

- (void)stopMessageTimer {
    [messageTimer invalidate];
    messageTimer = nil;
}

- (void)clearMessage {
    messageLabel.text = @"";
}

#pragma mark - Input Accessory View
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
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.shadowColor = [UIColor darkGrayColor];
        messageLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        
        UIBarButtonItem *label = [[UIBarButtonItem alloc] initWithCustomView:messageLabel];
        
        NSArray *array = [NSArray arrayWithObjects:label, flexibleSpaceLeft, doneBtn, nil];
        [inputAccessoryView setItems:array];
    }
    return inputAccessoryView;
}

- (void)done:(id)sender {
	[self.textField resignFirstResponder];
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	UITableView *tableView = [self tableView];
	[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    
    if (((MJTextFieldTableRow *)self.row).limitLength > 0) {
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        result = newLength <= ((MJTextFieldTableRow *)self.row).limitLength || returnKey;
    }
    
    if (result) {
        ((MJTextFieldTableRow *)self.row).stringValue = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (((MJTextFieldTableRow *)self.row).onValueChanged) {
            ((MJTextFieldTableRow *)self.row).onValueChanged(((MJTextFieldTableRow *)self.row).stringValue);
        }
    }
    
    if (messageLabel) {
        // show warning message.
        messageLabel.text = result ? @"" : [NSString stringWithFormat:@"最大长度不能超过%d位!", ((MJTextFieldTableRow *)self.row).limitLength];
        if (messageLabel.text.length > 0) {
            [self stopMessageTimer];
            [self startMessageTimer];
        }
    }
    
    return result;
}

#pragma mark - Layout subView
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
