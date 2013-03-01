//
//  MJTableViewCell.m
//  MJTableViewExample
//
//  Created by xudong on 13-1-26.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJTableViewCell.h"

@implementation MJTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// override this method for set your custom cell with the row.
- (void)prepareForRow:(MJTableRow *)row
{
    self.row = row;
    
    self.textLabel.text = self.row.text;
    self.detailTextLabel.text = self.row.detailText;
    if (self.row.textFont) {
        self.textLabel.font = self.row.textFont;
    }
    if (self.row.detailTextFont) {
        self.detailTextLabel.font = self.row.detailTextFont;
    }
    self.imageView.image = self.row.image;
    self.accessoryView = self.row.accessoryView;
    
    self.selectionStyle = self.row.selectionStyle;
    self.accessoryType = self.row.accessoryType;
}

#pragma mark - Global Tool Method
- (UITableView *)tableView {
    return (UITableView *)self.superview;
}

@end
