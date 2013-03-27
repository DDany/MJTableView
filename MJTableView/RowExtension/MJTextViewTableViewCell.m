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
    self.textView.backgroundColor = [UIColor whiteColor];
	self.textView.autocorrectionType = UITextAutocorrectionTypeDefault;
	self.textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
	self.textView.font = [UIFont systemFontOfSize:16.0f];
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textView.contentInset = UIEdgeInsetsMake(-ADJUST_TOP_INSET*2, 0, -ADJUST_TOP_INSET*2, 0);
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

    if (self.textView.editable && row.showTextViewBolderWhenEdit) {
        self.textView.layer.borderWidth = 1.0f;
        self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }else {
        self.textView.layer.borderWidth = 0.0f;;
    }
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
        self.row.rowHeight = [self suitableHeight];
        
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
- (CGFloat)suitableHeight {
    
    CGFloat minRowHeight = ((MJTextViewTableRow *)self.row).minRowHeight;
    CGFloat maxRowHeight = ((MJTextViewTableRow *)self.row).maxRowHeight;
    
    CGFloat height = [self.textView.text sizeWithFont:self.textView.font
                                    constrainedToSize:CGSizeMake(self.textView.bounds.size.width, 1000)
                                        lineBreakMode:NSLineBreakByWordWrapping].height;
    height += ADJUST_TOP_INSET*2;
    
    if (height < minRowHeight) {
        return minRowHeight;
    }else if (height > maxRowHeight) {
        return maxRowHeight;
    }else {
        return height;
    }
}

#pragma mark
- (void)layoutSubviews {
    // frame分布:
    // indicator : 20
    // textlabel距离contentview左边10
    // textlabel与textview距离10
    // 剩余全是textview的部分
    // 上下各空ADJUST_TOP_INSET距离.
    
	[super layoutSubviews];
    self.contentView.backgroundColor = [UIColor redColor];
	CGRect editFrame = CGRectInset(self.contentView.frame, 10, ADJUST_TOP_INSET);
	
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.origin.x += textSize.width + 10;
		editFrame.size.width -= textSize.width + 10;
        editFrame.size.height = self.bounds.size.height - ADJUST_TOP_INSET*2;
	} else {
		CGSize textSize = [self.textView sizeThatFits:CGSizeZero];
        editFrame.origin.y = (self.contentView.frame.size.height - textSize.height)/2;
	}
    
	self.textView.frame = editFrame;
}

@end
