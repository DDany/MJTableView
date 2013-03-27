//
//  MJTableViewCell.h
//  MJTableViewExample
//
//  Created by xudong on 13-1-26.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableRow.h"

@interface MJTableViewCell : UITableViewCell

@property (nonatomic, weak) MJTableRow *row;

- (void)configForRow:(MJTableRow *)row;

- (UITableView *)tableView;
@end
