//
//  MJTableSection.h
//  MJTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJTableRow.h"

@interface MJTableSection : NSObject

@property (nonatomic, strong) NSMutableArray *rows;

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;

@property (nonatomic) UITableViewRowAnimation rowAnimation;

+ (MJTableSection *)section;

#pragma mark - Accessing Rows

- (MJTableRow *)rowAtIndex:(NSInteger)index;

@end
