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
+ (MJSplitTableRow *)rowWithTitles:(NSArray *)titles values:(NSArray *)values alignment:(SplitTextAlignment)alignment;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *values;

@property (nonatomic, assign) CGFloat valueLayoutAreaPercent;   // value text frame percent, default is 1/2.

@property (nonatomic, assign) SplitTextAlignment alignment;     // default is SplitTextAlignmentHorizontal.

@end
