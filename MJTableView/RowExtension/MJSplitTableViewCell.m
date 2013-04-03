//
//  MJSplitTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-1.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJSplitTableViewCell.h"
#import "MJSplitTableRow.h"

@implementation MJSplitTableViewCell
{

}


#pragma mark - Custom layout

- (void)layoutSubviews {
	[super layoutSubviews];

    MJSplitTableRow *row = (MJSplitTableRow *)self.row;

    // remove all subview
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // add split line.
    if (row.titles.count > 1) {
        for (NSUInteger i = 1; i < row.titles.count; i++) {
            UIView *splitLine = [self splitLineAtIndex:i total:row.titles.count];
            
            [self.contentView addSubview:splitLine];
        }
    }
    
    // add labels
    for (NSUInteger i = 0; i < row.titles.count; i++) {
        UILabel *title = [self titleLabelAtIndex:i total:row.titles.count alignment:row.alignment];
        UILabel *value = [self valueLabelAtIndex:i total:row.titles.count alignment:row.alignment];
        
        title.text = row.titles[i];
        value.text = row.values[i];
        
        [self.contentView addSubview:title];
        [self.contentView addSubview:value];
    }
}

#pragma mark - Private

#pragma mark - Frame

- (CGRect)frameForSplitLineAtIndex:(NSUInteger)index total:(NSUInteger)total {
    CGRect frame = CGRectMake(0, 0, 1, self.contentView.frame.size.height);
    frame.origin.x = (self.contentView.frame.size.width / total) * index;
    
    return frame;
}

- (CGRect)frameForTitleAtIndex:(NSUInteger)index total:(NSUInteger)total alignment:(SplitTextAlignment)alignment {
    CGRect frame = CGRectZero;
    MJSplitTableRow *row = (MJSplitTableRow *)self.row;
    
    if (alignment == SplitTextAlignmentVertical) {
        
        frame.origin.x = (self.contentView.frame.size.width / total) * index;
        frame.origin.y = self.contentView.frame.size.height * row.valueLayoutAreaPercent;
        frame.size.width = (self.contentView.frame.size.width / total);
        frame.size.height = self.contentView.frame.size.height * (1 - row.valueLayoutAreaPercent);
        
    }else if (alignment == SplitTextAlignmentHorizontal) {
        frame.origin.x = (self.contentView.frame.size.width / total) * index;
        frame.origin.y = 0;
        frame.size.width = (self.contentView.frame.size.width / total) * (1 - row.valueLayoutAreaPercent) - 4;
        frame.size.height = self.contentView.frame.size.height;
    }
    
    
    return frame;
}

- (CGRect)frameForValueAtIndex:(NSUInteger)index total:(NSUInteger)total alignment:(SplitTextAlignment)alignment {
    CGRect frame = CGRectZero;
    MJSplitTableRow *row = (MJSplitTableRow *)self.row;

    if (alignment == SplitTextAlignmentVertical) {
        
        frame.origin.x = (self.contentView.frame.size.width / total) * index;
        frame.origin.y = 0;
        frame.size.width = (self.contentView.frame.size.width / total);
        frame.size.height = self.contentView.frame.size.height * row.valueLayoutAreaPercent;
        
    }else if (alignment == SplitTextAlignmentHorizontal) {
        
        frame.origin.x = (self.contentView.frame.size.width / total) * index
                        + (self.contentView.frame.size.width / total) * (1 - row.valueLayoutAreaPercent);
        frame.origin.y = 0;
        frame.size.width = (self.contentView.frame.size.width / total) * row.valueLayoutAreaPercent;
        frame.size.height = self.contentView.frame.size.height;
        
    }
    
    return frame;
}

#pragma mark - View (Splitline & Title & Value)

- (UIView *)splitLineAtIndex:(NSUInteger)index total:(NSUInteger)total {
    CGRect frame = [self frameForSplitLineAtIndex:index total:total];
    UIView *line = [[UIView alloc] initWithFrame:frame];
    
    line.backgroundColor = self.tableView.separatorColor;
    
    return line;
}

- (UILabel *)titleLabelAtIndex:(NSUInteger)index total:(NSUInteger)total alignment:(SplitTextAlignment)alignment {
    CGRect frame = [self frameForTitleAtIndex:index total:total alignment:alignment];
    UILabel *title = [[UILabel alloc] initWithFrame:frame];
    title.textColor = self.row.textColor;
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = self.row.textAlignment;
    if (alignment == SplitTextAlignmentVertical) {
        title.font = self.row.textFont ? self.row.textFont : [UIFont boldSystemFontOfSize:12];
    }else {
        title.font = self.row.textFont ? self.row.textFont : [UIFont boldSystemFontOfSize:14];
    }
    return title;
}

- (UILabel *)valueLabelAtIndex:(NSUInteger)index total:(NSUInteger)total alignment:(SplitTextAlignment)alignment {
    CGRect frame = [self frameForValueAtIndex:index total:total alignment:alignment];
    UILabel *value = [[UILabel alloc] initWithFrame:frame];
    value.textColor = self.row.detailTextColor;
    value.backgroundColor = [UIColor clearColor];
    value.textAlignment = self.row.detailTextAlignment;
    if (alignment == SplitTextAlignmentVertical) {
        value.font = self.row.detailTextFont ? self.row.detailTextFont : [UIFont boldSystemFontOfSize:18];
    }else {
        value.font = self.row.detailTextFont ? self.row.detailTextFont : [UIFont boldSystemFontOfSize:14];
    }

    return value;
}


@end







