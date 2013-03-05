//
//  MJSegmentedTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-2-22.
//  Copyright (c) 2013年 Shout Messenger. All rights reserved.
//

#import "MJSegmentedTableViewCell.h"
#import "MJSegmentedTableRow.h"

@interface MJSegmentedTableViewCell ()
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation MJSegmentedTableViewCell

- (void)initialize {
	// Initialization code
	_segment = [[UISegmentedControl alloc] initWithFrame:CGRectZero];
    [self.segment addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segment];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
		[self initialize];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark
- (void)prepareForRow:(MJSegmentedTableRow *)row {
    [super prepareForRow:row];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.accessoryType = UITableViewCellAccessoryNone;
    
    // clear
    [self.segment removeAllSegments];
    
    // set up segment.
    [row.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.segment insertSegmentWithTitle:obj atIndex:idx animated:NO];
    }];
    
    if (row.seletedKey && [row.keys containsObject:row.seletedKey]) {
        NSUInteger index = [row.keys indexOfObject:row.seletedKey];
        if (index < row.titles.count) {
            self.segment.selectedSegmentIndex = index;
        }
    }
}

#pragma mark
- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect editFrame = CGRectInset(self.contentView.frame, 10, 0);
	
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
        
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.size.width -= textSize.width + 10;
        editFrame.origin.x += textSize.width + 10;
        
        // adjust frame with fixed size.
        CGSize fixedSize = ((MJSegmentedTableRow *)self.row).fixedSize;
        if (fixedSize.width != 0) {
            if (fixedSize.width > editFrame.size.width) {
                fixedSize.width = editFrame.size.width;
            }
            editFrame.origin.x += (editFrame.size.width - fixedSize.width);
            editFrame.size.width = fixedSize.width;
        }
        
        if (fixedSize.height != 0) {
            if (fixedSize.height > editFrame.size.height) {
                fixedSize.height = editFrame.size.height;
            }
            editFrame.origin.y = (editFrame.size.height - fixedSize.height)/2;
            editFrame.size.height = fixedSize.height;
        }else {
            editFrame.size.height = editFrame.size.height - 16;
            editFrame.origin.y = 8;
        }
	}
    
    if (editFrame.origin.y < 0) {
        editFrame.origin.y = 0;
    }
	self.segment.frame = editFrame;
}

#pragma mark
- (void)valueChanged:(id)sender {
    MJSegmentedTableRow *row = (MJSegmentedTableRow *)self.row;
    row.seletedKey = row.keys[((UISegmentedControl *)sender).selectedSegmentIndex];
    if (row.onValueChanged) {
        row.onValueChanged(row.seletedKey);
    }
}

@end
