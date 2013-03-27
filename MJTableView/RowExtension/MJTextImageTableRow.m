//
//  MJTextImageTableRow.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-5.
//  Copyright (c) 2013年 Dany. All rights reserved.
//

#import "MJTextImageTableRow.h"
#import "MJTextImageTableViewCell.h"

@implementation MJTextImageTableRow

+ (MJTextImageTableRow *)row {
    return [[MJTextImageTableRow alloc] init];
}

+ (MJTextImageTableRow *)rowWithText:(NSString *)text detailText:(NSString *)detailText detailImage:(UIView *)imageView {
    MJTextImageTableRow *row = [self row];
    
    row.text = text;
    row.stringValue = detailText;
    row.imageView = imageView;
    
    return row;
}

#pragma mark - Init
- (id)init {
    self = [super init];
    if (self) {
        self.alignment = TextImageAlignmentImageRight;
    }
    return self;
}

#pragma mark - Create cell
- (UITableViewCell *)createCell {
    MJTextImageTableViewCell *cell = [[MJTextImageTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
    
    return cell;
}

@end
