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
        
        CGSize textSize = CGSizeZero;
        
        // Dynamic adjust rowHeight.
        if (self.text && self.text.length > 0) {
            // text and detailText.
            textSize = [self.text sizeWithFont:self.textFont
                             constrainedToSize:CGSizeMake(tableView.bounds.size.width, 44)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        }else {
            // only detailText.
            // do nothing.
        }
        
        CGFloat offset = tableView.bounds.size.width - 320;
        CGFloat contentViewWidth = self.accessoryType == UITableViewCellAccessoryNone ? (tableView.bounds.size.width-40) : (tableView.bounds.size.width-80);
        if (tableView.style == UITableViewStylePlain) contentViewWidth += 16;
        CGFloat contentViewWidhtForDetail = contentViewWidth - offset - textSize.width - 10;
        
        CGSize detailSize = [self.stringValue sizeWithFont:self.detailTextFont
                                         constrainedToSize:CGSizeMake(contentViewWidhtForDetail, self.maxRowHeight)
                                             lineBreakMode:NSLineBreakByWordWrapping];
        
        [self setRowHeight:detailSize.height + ADJUST_TOP_INSET*2];
        
    }
    
    return self.rowHeight;
}

@end
