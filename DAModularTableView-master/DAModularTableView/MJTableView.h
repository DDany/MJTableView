//
//  DAModularTableView.h
//  DAModularTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableSection.h"

@interface MJTableView : UITableView

@property (nonatomic, strong) NSMutableArray *sections;

#pragma mark - Accessing Rows, Sections, Cells and Index Paths

- (MJTableSection *)sectionAtIndex:(NSInteger)index;
- (MJTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)cellForRow:(MJTableRow *)row;
- (NSIndexPath *)indexPathForRow:(MJTableRow *)row;
- (NSInteger)indexForSection:(MJTableSection *)section;

- (MJTableRow *)rowForCell:(UITableViewCell *)cell;

#pragma mark - Inserting, Removing, Reloading Sections

- (void)insertSection:(MJTableSection *)section;
- (void)insertSection:(MJTableSection *)section
             animated:(BOOL)animated;
- (void)insertSection:(MJTableSection *)section
              atIndex:(NSInteger)index
             animated:(BOOL)animated;

- (void)removeSection:(MJTableSection *)section
             animated:(BOOL)animated;

- (void)reloadSection:(MJTableSection *)section
             animated:(BOOL)animated;

#pragma mark - Inserting, Removing, Reloading Rows

- (void)insertRow:(MJTableRow *)row;
- (void)insertRow:(MJTableRow *)row
         animated:(BOOL)animated;
- (void)insertRow:(MJTableRow *)row
      atIndexPath:(NSIndexPath *)indexPath
         animated:(BOOL)animated;

- (void)removeRow:(MJTableRow *)row
         animated:(BOOL)animated;

- (void)reloadRow:(MJTableRow *)row
         animated:(BOOL)animated;

@end
