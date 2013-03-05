//
//  MJTableSection.m
//  MJTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MJTableSection.h"

@implementation MJTableSection

#pragma mark - Public Methods

+ (MJTableSection *)section {
    return [[MJTableSection alloc] init];
}

- (id)init {
    self = [super init];
    if (self)
    {
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
        self.rowAnimation = UITableViewRowAnimationAutomatic;
    }
    return self;
}

- (MJTableRow *)rowAtIndex:(NSInteger)index {
    return ([self rows])[index];
}

#pragma mark - Property Methods

- (NSMutableArray *)rows {
    if (!_rows) {
        _rows = @[].mutableCopy;
    }
    return _rows;
}

@end
