//
//  MJIntegerInputTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-3-4.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTextFieldTableRow.h"

@interface MJIntegerInputTableRow : MJTextFieldTableRow

+ (MJIntegerInputTableRow *)row;
+ (MJIntegerInputTableRow *)rowWithText:(NSString *)text intValue:(NSUInteger)value;

@property (nonatomic, assign) NSUInteger value;

@end
