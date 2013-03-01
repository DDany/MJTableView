//
//  MJDateTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-1-23.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJDateTableRow.h"
#import "MJDateTableViewCell.h"

@implementation MJDateTableRow

#pragma mark - Public Methods

+ (MJDateTableRow *)row
{
    return [[MJDateTableRow alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        _dateValue = [NSDate date];
        self.cellStyle = UITableViewCellStyleValue1;
        self.mode = UIDatePickerModeDateAndTime;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)cell {
    MJDateTableViewCell *cell = [[MJDateTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
    
    [cell prepareForRow:self];
    
    return cell;
}

#pragma mark - Private
- (NSString *)showDateFormatter {
    if (!_showDateFormatter || _showDateFormatter.length == 0) {
        if (self.mode == UIDatePickerModeDateAndTime) {
            _showDateFormatter = @"yyyy-MM-dd HH:mm";
        }else if (self.mode == UIDatePickerModeDate) {
            _showDateFormatter = @"yyyy-MM-dd";
        }else if (self.mode == UIDatePickerModeTime) {
            _showDateFormatter = @"HH:mm";
        }else {
            _showDateFormatter = @"yyyy-MM-dd HH:mm:ss";
        }
    }
    
    return _showDateFormatter;
}

@end
