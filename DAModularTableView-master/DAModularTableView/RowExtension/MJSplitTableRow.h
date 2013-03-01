//
//  MJSplitTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-3-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableRow.h"

typedef NS_ENUM(NSInteger, SplitTextAlignment) {
    
    SplitTextAlignmentHorizontal,
    SplitTextAlignmentVertical
    
} NS_ENUM_AVAILABLE_IOS(5_0);

@interface MJSplitTableRow : MJTableRow

+ (MJSplitTableRow *)row;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *values;

@property (nonatomic, assign) SplitTextAlignment alignment;

@end
