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

+ (MJTextViewTableRow *)row
{
    return [[MJTextViewTableRow alloc] init];
}

- (id)init
{
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
        self.editable = YES;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)cell {
    MJTextViewTableViewCell *cell = [[MJTextViewTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
    
    [cell prepareForRow:self];
    
    return cell;
}

#pragma mark - Getter
- (CGFloat)rowHeight {
    if (!self.editable && self.dynamicAdjustRowHeightWhenShow) {
        
        CGSize textSize = CGSizeZero;
        
        // Dynamic adjust rowHeight.
        if (self.text && self.text.length > 0) {
            // text and detailText.
            textSize = [self.text sizeWithFont:self.textFont
                                    constrainedToSize:CGSizeMake(100, 44)
                                        lineBreakMode:NSLineBreakByWordWrapping];
        }else {
            // only detailText.
            // do nothing.
        }
        
        CGFloat contentViewWidth = 280;
        CGFloat contentViewWidhtForDetail = contentViewWidth - textSize.width - 10;
        
        CGSize detailSize = [self.stringValue sizeWithFont:self.detailTextFont
                                         constrainedToSize:CGSizeMake(contentViewWidhtForDetail, self.maxRowHeight)
                                             lineBreakMode:NSLineBreakByWordWrapping];
        
        [self setRowHeight:detailSize.height + 0];
        
    }
    
    return [super rowHeight];
}

@end
