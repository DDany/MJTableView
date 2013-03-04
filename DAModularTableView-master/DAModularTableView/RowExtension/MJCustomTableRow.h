//
//  MJCustomTableRow.h
//  MJTableViewExample
//
//  Created by Dany on 13-3-4.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableRow.h"

@interface MJCustomTableRow : MJTableRow

+ (MJCustomTableRow *)row;
+ (MJCustomTableRow *)rowWithHeight:(CGFloat)height
                    cellForRowBlock:(void(^)(UITableViewCell *cell, NSIndexPath *indexPath))cellForRowBlock;

@end
