//
//  MJSegmentedTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-2-22.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJSegmentedTableRow.h"
#import "MJSegmentedTableViewCell.h"

@implementation MJSegmentedTableRow

+ (MJSegmentedTableRow *)row {
    return [[MJSegmentedTableRow alloc] init];
}

+ (MJSegmentedTableRow *)rowWithText:(NSString *)text titles:(NSArray *)titles keys:(NSArray *)keys selectedKey:(id)selectedKey {
    MJSegmentedTableRow *row = [self row];
    
    row.text = text;
    row.titles = titles;
    row.keys = keys;
    row.seletedKey = selectedKey;
    
    return row;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cellStyle = UITableViewCellStyleValue1;
        self.fixedSize = CGSizeZero;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)cell {
    MJSegmentedTableViewCell *cell = [[MJSegmentedTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
        
    return cell;
}

@end
