//
//  MJTextImageTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-3-5.
//  Copyright (c) 2013年 Dany. All rights reserved.
//

#import "MJTableRow.h"

typedef NS_ENUM(NSInteger, TextImageAlignment) {
    
    TextImageAlignmentImageLeft,
    TextImageAlignmentImageRight
    
} NS_ENUM_AVAILABLE_IOS(5_0);

@interface MJTextImageTableRow : MJTableRow

+ (MJTextImageTableRow *)row;
+ (MJTextImageTableRow *)rowWithText:(NSString *)text detailText:(NSString *)detailText detailImage:(UIView *)imageView;

@property (nonatomic, strong) NSString *stringValue;
@property (nonatomic, strong) UIView *imageView;

@property (nonatomic, assign) TextImageAlignment alignment;

@end
