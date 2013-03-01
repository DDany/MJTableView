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
        
        self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        self.spellCheckingType = UITextSpellCheckingTypeDefault;
        self.keyboardType = UIKeyboardTypeDefault;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.enablesReturnKeyAutomatically = NO;
        self.secureTextEntry = NO;
        
        self.maxRowHeight = 80;
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


@end
