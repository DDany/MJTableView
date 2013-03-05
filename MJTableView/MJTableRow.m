//
//  MJTableRow.m
//  MJTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MJTableRow.h"
#import "MJTableViewCell.h"

@implementation MJTableRow

#pragma mark - Public Methods

// override this method for your custom MJTableRow.
+ (MJTableRow *)row {
    return [[MJTableRow alloc] init];
}

+ (MJTableRow *)rowWithText:(NSString *)text detailText:(NSString *)detailText {
    MJTableRow *row = [self row];
    row.text = text;
    row.detailText = detailText;
    return row;
}

// override this method for your custom init.
- (id)init {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.cellStyle = UITableViewCellStyleValue1;
        self.rowAnimation = UITableViewRowAnimationAutomatic;
        
        self.textFont = [UIFont boldSystemFontOfSize:16.0f];
        self.textColor = [UIColor blackColor];
        self.detailTextFont = [UIFont systemFontOfSize:14.0f];
        self.detailTextColor = [UIColor brownColor];
        
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.shouldDeselectAfterSelect = YES;
        
        // you should set rowHeight > 20.0f.
        self.rowHeight = 33.0f;
    }
    return self;
}

#pragma mark - Create cell
// override this method for your custom cell.
- (UITableViewCell *)cell {
    MJTableViewCell *cell = [[MJTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
        
    return cell;
}

#pragma mark - Row height
- (CGFloat)rowHeightForTableView:(UITableView *)tableView {
    if (self.isDetailTextMultiLine) {
        
        CGSize textSize = CGSizeZero;
        
        // Dynamic adjust rowHeight.
        if (self.text && self.text.length > 0) {
            // text and detailText.
            textSize = [self.text sizeWithFont:self.textFont
                             constrainedToSize:CGSizeMake(100, 44)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        }else {
            // only detailText.
            // do nothing.
        }
        
        CGFloat offset = tableView.bounds.size.width - 320;
        CGFloat contentViewWidth = self.accessoryType == UITableViewCellAccessoryNone ? 280 : (240);
        CGFloat contentViewWidhtForDetail = contentViewWidth - offset - textSize.width - 10;
        
        CGSize detailSize = [self.detailText sizeWithFont:self.detailTextFont
                                        constrainedToSize:CGSizeMake(contentViewWidhtForDetail, 300)
                                            lineBreakMode:NSLineBreakByWordWrapping];
        
        [self setRowHeight:detailSize.height+10];
        
    }
    
    return self.rowHeight;
}

@end
