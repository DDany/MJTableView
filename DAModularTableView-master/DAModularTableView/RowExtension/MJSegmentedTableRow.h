//
//  MJSegmentedTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-2-22.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableRow.h"

@interface MJSegmentedTableRow : MJTableRow

+ (MJSegmentedTableRow *)row;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) id seletedKey;

@property(nonatomic, copy) void (^onValueChanged)(id newKey);

@end
