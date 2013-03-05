//
//  MJDateTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-1-23.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableRow.h"

@interface MJDateTableRow : MJTableRow

+ (MJDateTableRow *)row;
+ (MJDateTableRow *)rowWithText:(NSString *)text date:(NSDate *)date;

@property (nonatomic, strong) NSDate *dateValue;

@property (assign) UIDatePickerMode mode;

@property (nonatomic, strong) NSDate *maximumDate;

@property (nonatomic, strong) NSDate *minimumDate;

@property (assign) BOOL showDateWithSecond; // 2012-12-24 19:17:25 -> 2012-12-24 19:17

@property (nonatomic, strong) NSString *showDateFormatter; // HH:mm

@property(nonatomic, copy) void (^onValueChanged)(NSDate *newDate);

@end
