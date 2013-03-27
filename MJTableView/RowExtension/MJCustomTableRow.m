//
//  MJCustomTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-4.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJCustomTableRow.h"

@implementation MJCustomTableRow
#pragma mark - Public Methods

+ (MJCustomTableRow *)row {
    return [[MJCustomTableRow alloc] init];
}

+ (MJCustomTableRow *)rowWithHeight:(CGFloat)height
                    cellForRowBlock:(void(^)(UITableViewCell *cell, NSIndexPath *indexPath))cellForRowBlock {
    MJCustomTableRow *row = [self row];
    
    row.rowHeight = height;
    row.cellForRowBlock = cellForRowBlock;
    
    return row;
}

#pragma mark - Init
- (id)init {
    self = [super init];
    if (self) {
        // do nothing.
        self.cellForRowBlock = ^(UITableViewCell *cell, NSIndexPath *indexPath){
            // you must add below code to your custom cellForRowBlock, because of the reuse case.
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        };
    }
    return self;
}

@end
