//
//  MJTextViewTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-2-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextViewTableViewCell.h"
#import "MJTextViewTableRow.h"

@interface MJTextViewTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;

@end

@implementation MJTextViewTableViewCell
{
    UIToolbar           *inputAccessoryView;
}

- (void)initialize {
	// Initialization code
	self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.backgroundColor = [UIColor clearColor];
	self.textView.autocorrectionType = UITextAutocorrectionTypeDefault;
	self.textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
	self.textView.font = [UIFont systemFontOfSize:16.0f];
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self addSubview:self.textView];
	
	self.textView.delegate = self;
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
		[self.textView becomeFirstResponder];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		[self.textView becomeFirstResponder];
	}
}

#pragma mark
- (void)prepareForRow:(MJTextViewTableRow *)row
{
    [super prepareForRow:row];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.accessoryType = UITableViewCellAccessoryNone;
    
    self.textView.text = ((MJTextViewTableRow *)self.row).stringValue;
    //self.textView.placeholder = ((MJTextViewTableRow *)self.row).placeHolder;
    self.textView.autocorrectionType = ((MJTextViewTableRow *)self.row).autocorrectionType;
	self.textView.autocapitalizationType = ((MJTextViewTableRow *)self.row).autocapitalizationType;
	self.textView.font = [UIFont systemFontOfSize:16.0f];
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textView.spellCheckingType = ((MJTextViewTableRow *)self.row).spellCheckingType;
    self.textView.keyboardType = ((MJTextViewTableRow *)self.row).keyboardType;
    self.textView.keyboardAppearance = ((MJTextViewTableRow *)self.row).keyboardAppearance;
    self.textView.returnKeyType = ((MJTextViewTableRow *)self.row).returnKeyType;
    self.textView.enablesReturnKeyAutomatically = ((MJTextViewTableRow *)self.row).enablesReturnKeyAutomatically;
    self.textView.secureTextEntry = ((MJTextViewTableRow *)self.row).secureTextEntry;
    self.textView.editable = ((MJTextViewTableRow *)self.row).editable;
}

#pragma mark
- (void)setStringValue:(NSString *)value {
	self.textView.text = value;
}

- (NSString *)stringValue {
	return self.textView.text;
}

#pragma mark
- (UIView *)inputAccessoryView {
    if (!self.textView.editable) {
        return nil;
    }
    
	if (!inputAccessoryView) {
        inputAccessoryView = [[UIToolbar alloc] init];
        inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
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
	[self.textView resignFirstResponder];
}

#pragma mark
- (void)textViewDidEndEditing:(UITextView *)textView {
    UITableView *tableView = [self tableView];
	[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (((MJTextViewTableRow *)self.row).dynamicAdjustRowHeight) {
        UITableView *tableView = [self tableView];
        CGFloat minRowHeight = ((MJTextViewTableRow *)self.row).minRowHeight;
        CGFloat maxRowHeight = ((MJTextViewTableRow *)self.row).maxRowHeight;
        
        CGFloat height = [self.textView.text sizeWithFont:self.textView.font
                                        constrainedToSize:CGSizeMake(self.textView.bounds.size.width, 1000)
                                            lineBreakMode:NSLineBreakByWordWrapping].height;
        if (height < minRowHeight) {
            self.row.rowHeight = minRowHeight;
        }else if (height > maxRowHeight) {
            self.row.rowHeight = maxRowHeight;
        }else {
            self.row.rowHeight = height;
            
        }
        [tableView beginUpdates];
        [tableView endUpdates];
    }
    
    if (((MJTextViewTableRow *)self.row).onValueChanged) {
        ((MJTextViewTableRow *)self.row).onValueChanged(textView.text);
    }
}

#pragma mark
- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect editFrame = CGRectInset(self.contentView.frame, 10, 10);
	
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.origin.x += textSize.width + 10;
		editFrame.size.width -= textSize.width + 10;
        editFrame.size.height = self.bounds.size.height - 20;
	} else {
		CGSize textSize = [self.textView sizeThatFits:CGSizeZero];
        editFrame.origin.y = (self.contentView.frame.size.height - textSize.height)/2;
	}
    
	self.textView.frame = editFrame;
}

@end
