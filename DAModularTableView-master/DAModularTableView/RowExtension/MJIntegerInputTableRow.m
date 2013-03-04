//
//  MJIntegerInputTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-4.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJIntegerInputTableRow.h"

@implementation MJIntegerInputTableRow

#pragma mark - Public Methods

+ (MJIntegerInputTableRow *)row
{
    return [[MJIntegerInputTableRow alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.cellStyle = UITableViewCellStyleValue1;
        
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

#pragma mark - Getter & Setter
- (NSString *)stringValue {
    return @(self.value).stringValue;
}

- (void)setStringValue:(NSString *)stringValue {
    self.value = stringValue.integerValue;
}

@end
