//
//  MJTextViewTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-2-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextViewTableRow.h"
#import "MJTextViewTableViewCell.h"

@implementation MJTextViewTableRow
{
    UITextView      *_tester;
}

#pragma mark - Public Methods

+ (MJTextViewTableRow *)row {
    return [[MJTextViewTableRow alloc] init];
}


+ (MJTextViewTableRow *)rowWithText:(NSString *)text stringValue:(NSString *)string {
    MJTextViewTableRow *row = [self row];
    row.text = text;
    row.stringValue = string;
    return row;
}

#pragma mark - Init
- (id)init {
    self = [super init];
    if (self) {
        self.cellStyle = UITableViewCellStyleValue1;
        
        self.selectionStyle = UITableViewCellEditingStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.spellCheckingType = UITextSpellCheckingTypeDefault;
        self.keyboardType = UIKeyboardTypeDefault;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.enablesReturnKeyAutomatically = NO;
        self.secureTextEntry = NO;
        
        self.dynamicAdjustRowHeightWhenShow = YES;
        self.maxRowHeight = 130;
        self.minRowHeight = 44;
        self.textViewWidth = 120.0f;
        self.editable = YES;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)createCell {
    MJTextViewTableViewCell *cell = [[MJTextViewTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
        
    return cell;
}

#pragma mark - Row height
- (CGFloat)rowHeightForTableView:(UITableView *)tableView {
    if (!self.editable && self.dynamicAdjustRowHeightWhenShow) {
        CGSize detailSize = [self.stringValue sizeWithFont:self.detailTextFont
                                         constrainedToSize:CGSizeMake(self.textViewWidth - 8*2, 1000)
                                             lineBreakMode:NSLineBreakByCharWrapping];
        [self setRowHeight:detailSize.height + ADJUST_TOP_INSET*2];
    }
    
    return self.rowHeight;
}

- (UITextView *)testHeightTextView {
    if (!_tester) {
        _tester = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.textViewWidth, 100)];
    }
    _tester.contentInset = UIEdgeInsetsMake(-8, 0, -8, 0);
    _tester.frame = CGRectMake(0, 0, self.textViewWidth, 100);
    _tester.text = self.stringValue;
    _tester.textColor = self.detailTextColor;
    _tester.autocorrectionType = self.autocorrectionType;
	_tester.autocapitalizationType = self.autocapitalizationType;
	_tester.font = self.detailTextFont;
	_tester.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tester.spellCheckingType = self.spellCheckingType;
    _tester.keyboardType = self.keyboardType;
    _tester.keyboardAppearance = self.keyboardAppearance;
    _tester.returnKeyType = self.returnKeyType;
    _tester.enablesReturnKeyAutomatically = self.enablesReturnKeyAutomatically;
    _tester.secureTextEntry = self.secureTextEntry;
    _tester.editable = self.editable;
    _tester.userInteractionEnabled = _tester.editable;
    
    return _tester;
}

@end
