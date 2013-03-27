//
//  MJTextViewTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-2-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextViewTableViewCell.h"
#import "MJTextViewTableRow.h"
#import <QuartzCore/QuartzCore.h>


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
    self.textView.contentInset = UIEdgeInsetsMake(-8, 0, -8, 0);
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

#pragma mark - Selcet
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
- (void)configForRow:(MJTextViewTableRow *)row {
    [super configForRow:row];
    self.selectionStyle = row.selectionStyle;
	self.accessoryType = row.accessoryType;
    
    self.textView.text = row.stringValue;
    self.textView.textColor = row.detailTextColor;
    //self.textView.placeholder = row.placeHolder;
    self.textView.autocorrectionType = row.autocorrectionType;
	self.textView.autocapitalizationType = row.autocapitalizationType;
	self.textView.font = row.detailTextFont;
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textView.spellCheckingType = row.spellCheckingType;
    self.textView.keyboardType = row.keyboardType;
    self.textView.keyboardAppearance = row.keyboardAppearance;
    self.textView.returnKeyType = row.returnKeyType;
    self.textView.enablesReturnKeyAutomatically = row.enablesReturnKeyAutomatically;
    self.textView.secureTextEntry = row.secureTextEntry;
    self.textView.editable = row.editable;
    self.textView.userInteractionEnabled = self.textView.editable;

//    if (self.textView.editable && row.showTextViewBolderWhenEdit) {
        self.textView.layer.borderWidth = 1.0f;
        self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    }else {
//        self.textView.layer.borderWidth = 0.0f;;
//    }
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
    
    if (((MJTextViewTableRow *)self.row).dynamicAdjustRowHeightWhenEdit) {
        UITableView *tableView = [self tableView];
        
        CGFloat oldRowHeight = self.row.rowHeight;
        CGFloat newRowHeight = [self.stringValue sizeWithFont:((MJTextViewTableRow *)self.row).detailTextFont
                                            constrainedToSize:CGSizeMake(((MJTextViewTableRow *)self.row).textViewWidth - 8*2, 1000)
                                                lineBreakMode:NSLineBreakByCharWrapping].height
                                + ADJUST_TOP_INSET*2;
        if (newRowHeight < ((MJTextViewTableRow *)self.row).minRowHeight) {
            newRowHeight = ((MJTextViewTableRow *)self.row).minRowHeight;
        }else if (newRowHeight > ((MJTextViewTableRow *)self.row).maxRowHeight) {
            newRowHeight = ((MJTextViewTableRow *)self.row).maxRowHeight;
        }
        self.row.rowHeight = newRowHeight;
        
        if (oldRowHeight != self.row.rowHeight) {
            [tableView beginUpdates];
            [tableView endUpdates];
        }
    }
    
    ((MJTextViewTableRow *)self.row).stringValue = textView.text;
    
    if (((MJTextViewTableRow *)self.row).onValueChanged) {
        ((MJTextViewTableRow *)self.row).onValueChanged(((MJTextViewTableRow *)self.row).stringValue);
    }
}

#pragma mark
- (void)layoutSubviews {
	[super layoutSubviews];
    
    MJTextViewTableRow *row = (MJTextViewTableRow *)self.row;
    
	CGRect editFrame = self.contentView.frame;
    editFrame.origin.x = editFrame.size.width - row.textViewWidth;
    editFrame.origin.y = ADJUST_TOP_INSET;
    editFrame.size = CGSizeMake(row.textViewWidth, editFrame.size.height - ADJUST_TOP_INSET*2);
    
	self.textView.frame = editFrame;
}

@end
