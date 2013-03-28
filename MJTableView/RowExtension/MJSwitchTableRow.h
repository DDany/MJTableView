//
//  MJSwitchTableRow.h
//  DolphinSharing
//
//  Created by Dany on 13-3-27.
//  Copyright (c) 2013年 mojo-tech. All rights reserved.
//

#import "MJTableRow.h"

@interface MJSwitchTableRow : MJTableRow

+ (MJSwitchTableRow *)rowWithText:(NSString *)text
                        tintColor:(UIColor *)tintColor
                         switchOn:(BOOL)switchOn;

@property (nonatomic, assign, getter = isOn) BOOL on;

@property(nonatomic, copy) void (^onValueChanged)(BOOL on);

@end
