//
//  MJSplitTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJSplitTableRow.h"
#import "MJSplitTableViewCell.h"

@implementation MJSplitTableRow

+ (MJSplitTableRow *)row
{
    return [[MJSplitTableRow alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.cellStyle = UITableViewCellStyleDefault;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.alignment = SplitTextAlignmentHorizontal;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)cell {
    MJSplitTableViewCell *cell = [[MJSplitTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
        
    return cell;
}

@end
