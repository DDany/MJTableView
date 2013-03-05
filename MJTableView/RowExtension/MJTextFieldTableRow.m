//
//  MJTextFieldTableRow.m
//  MJTableViewExample
//
//  Created by xudong on 13-1-26.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextFieldTableRow.h"
#import "MJTextFieldTableViewCell.h"

@implementation MJTextFieldTableRow

#pragma mark - Public Methods

+ (MJTextFieldTableRow *)row {
    return [[MJTextFieldTableRow alloc] init];
}

+ (MJTextFieldTableRow *)rowWithText:(NSString *)text stringValue:(NSString *)string {
    MJTextFieldTableRow *row = [self row];
    row.text = text;
    row.stringValue = string;
    return row;
}

- (id)init {
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
        
        self.limitLength = 0;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)cell {
    MJTextFieldTableViewCell *cell = [[MJTextFieldTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
        
    return cell;
}


@end
