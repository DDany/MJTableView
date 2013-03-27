//
//  MJTableView.m
//  MJTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MJTableView.h"
#import "MJTableViewCell.h"

@interface MJTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MJTableView

#pragma mark - Init Methods

- (id)init {
    self = [super init];
    if (self) {
        super.delegate = self;
        super.dataSource = self;
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        super.delegate = self;
        super.dataSource = self;
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        super.delegate = self;
        super.dataSource = self;
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        super.delegate = self;
        super.dataSource = self;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - Accessing Rows, Sections, Cells and Index Paths

- (MJTableSection *)sectionAtIndex:(NSInteger)index {
    return ([self sections])[index];
}

- (MJTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    MJTableSection *section = [self sectionAtIndex:indexPath.section];
    return [section rowAtIndex:indexPath.row];
}

- (UITableViewCell *)cellForRow:(MJTableRow *)row {
    NSIndexPath *indexPathForRow = [self indexPathForRow:row];
    return [self cellForRowAtIndexPath:indexPathForRow];
}

- (NSIndexPath *)indexPathForRow:(MJTableRow *)row {
    MJTableSection *rowSection;
    for (MJTableSection *section in [self sections]) {
        if ([section.rows containsObject:row]) {
            rowSection = section;
        }
    }
    
    NSInteger rowIndex = [rowSection.rows indexOfObject:row];
    NSInteger sectionIndex = [self indexForSection:rowSection];
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

- (NSInteger)indexForSection:(MJTableSection *)section {
    return [self.sections indexOfObject:section];
}

- (MJTableRow *)rowForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    return [self rowAtIndexPath:indexPath];
}

#pragma mark - Inserting, Removing, Reloading Sections

- (void)insertSection:(MJTableSection *)section {
    [self insertSection:section
               animated:NO];
}

- (void)insertSection:(MJTableSection *)section
             animated:(BOOL)animated {
    [self insertSection:section
                atIndex:[[self sections] count]
               animated:animated];
}

- (void)insertSection:(MJTableSection *)section
              atIndex:(NSInteger)index
             animated:(BOOL)animated {
    [self insertSection:section
                atIndex:index
          withAnimation:(animated ? section.rowAnimation : UITableViewRowAnimationNone)];
}

- (void)insertSection:(MJTableSection *)section
              atIndex:(NSInteger)index
        withAnimation:(UITableViewRowAnimation)animation {
    [[self sections] insertObject:section atIndex:index];
    [self insertSections:[NSIndexSet indexSetWithIndex:index]
        withRowAnimation:animation];
}

- (void)moveSection:(NSInteger)section
          toSection:(NSInteger)newSection {
    [[self sections] exchangeObjectAtIndex:section
                         withObjectAtIndex:newSection];
    [super moveSection:section
             toSection:newSection];
}

- (void)removeSection:(MJTableSection *)section
             animated:(BOOL)animated {
    [self removeSection:section
          withAnimation:(animated ? section.rowAnimation : UITableViewRowAnimationNone)];
}

- (void)removeSection:(MJTableSection *)section
        withAnimation:(UITableViewRowAnimation)animation {
    NSInteger index = [self indexForSection:section];
    [[self sections] removeObject:section];
    [self beginUpdates];
    [self deleteSections:[NSIndexSet indexSetWithIndex:index]
        withRowAnimation:animation];
    [self endUpdates];
}

- (void)reloadSection:(MJTableSection *)section
             animated:(BOOL)animated {
    NSInteger index = [self indexForSection:section];
    [self reloadSections:[NSIndexSet indexSetWithIndex:index]
        withRowAnimation:(animated ? section.rowAnimation : UITableViewRowAnimationNone)];
}

#pragma mark - Inserting, Removing, Reloading Rows

- (void)insertRow:(MJTableRow *)row {
    [self insertRow:row
           animated:NO];
}

- (void)insertRow:(MJTableRow *)row
         animated:(BOOL)animated {
    MJTableSection *lastSection = [[self sections] lastObject];
    if (!lastSection) {
        lastSection = [MJTableSection section];
        [self insertSection:lastSection];
    }
    [self insertRow:row
        atIndexPath:[NSIndexPath indexPathForRow:([lastSection.rows count])
                                       inSection:([[self sections] count] - 1)]
           animated:animated];
}

- (void)insertRow:(MJTableRow *)row
      atIndexPath:(NSIndexPath *)indexPath
         animated:(BOOL)animated {
    [self insertRow:row
        atIndexPath:indexPath
      withAnimation:(animated ? row.rowAnimation : UITableViewRowAnimationNone)];
}

- (void)insertRow:(MJTableRow *)row
      atIndexPath:(NSIndexPath *)indexPath
    withAnimation:(UITableViewRowAnimation)animation {
    MJTableSection *section = [self sectionAtIndex:indexPath.section];
    if (!section) {
        section = [MJTableSection section];
        [self insertSection:section];
    }
    [[section rows] insertObject:row atIndex:indexPath.row];
    [self insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                withRowAnimation:animation];
}

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    MJTableRow *row = [self rowAtIndexPath:indexPath];
    [self insertRow:row
        atIndexPath:indexPath
           animated:NO];
    [super moveRowAtIndexPath:indexPath
                  toIndexPath:newIndexPath];
}

- (void)removeRow:(MJTableRow *)row
         animated:(BOOL)animated {
    [self removeRow:row
      withAnimation:(animated ? row.rowAnimation : UITableViewRowAnimationNone)];
}

- (void)removeRow:(MJTableRow *)row
    withAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self indexPathForRow:row];
    MJTableSection *section = [self sectionAtIndex:indexPath.section];
    [[section rows] removeObject:row];
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                withRowAnimation:animation];
    [self endUpdates];
}

- (void)reloadRow:(MJTableRow *)row
         animated:(BOOL)animated {
    NSIndexPath *indexPath = [self indexPathForRow:row];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                withRowAnimation:(animated ? row.rowAnimation : UITableViewRowAnimationNone)];
}

#pragma mark - Property Methods

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = @[].mutableCopy;
    }
    return _sections;
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    // For now, discard
    // Possible todo: add proxy dataSource for selective handling
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    // For now, discard
    // Possible todo: add proxy delegate for selective handling
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MJTableSection *tableSection = [self sectionAtIndex:section];
    return [[tableSection rows] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJTableRow *tableRow = [self rowAtIndexPath:indexPath];
    
    NSString *cellIdentifier = tableRow.reuseIdentifier;
    MJTableViewCell *cell = (MJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = (MJTableViewCell *)[tableRow createCell];
    }
    
    [cell configForRow:tableRow];
    
    if (tableRow.cellForRowBlock) {
        tableRow.cellForRowBlock(cell, indexPath);
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	MJTableSection *tableSection = [self sectionAtIndex:section];
	return [tableSection headerTitle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    MJTableSection *tableSection = [self sectionAtIndex:section];
	return [tableSection footerTitle];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	MJTableSection *tableSection = [self sectionAtIndex:section];
	return [tableSection headerView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MJTableSection *tableSection = [self sectionAtIndex:section];
	return [tableSection footerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MJTableSection *tableSection = [self sectionAtIndex:section];
    return [tableSection headerHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    MJTableSection *tableSection = [self sectionAtIndex:section];
    return [tableSection footerHeight];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MJTableRow *tableRow = [self rowAtIndexPath:indexPath];
    if (tableRow.didSelectBlock) {
        tableRow.didSelectBlock(indexPath);
    }
    
    if (tableRow.shouldDeselectAfterSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (tableRow.didSelectAction) {
        [self performSelector:tableRow.didSelectAction];
    }
    #pragma clang diagnostic pop
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJTableRow *tableRow = [self rowAtIndexPath:indexPath];
    CGFloat height = [tableRow rowHeightForTableView:tableView];
    if (height) {
        return height;
    }else {
        return tableView.rowHeight;
    }
}

@end
