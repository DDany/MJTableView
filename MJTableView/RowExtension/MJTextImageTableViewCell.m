//
//  MJTextImageTableViewCell.m
//  MJTableViewExample
//
//  Created by Dany on 13-3-5.
//  Copyright (c) 2013年 Dany. All rights reserved.
//

#import "MJTextImageTableViewCell.h"
#import "MJTextImageTableRow.h"

@interface MJTextImageTableViewCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *image;

@end

@implementation MJTextImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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

- (void)initialize {
	// Initialization code
	self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textAlignment = NSTextAlignmentRight;
}

#pragma mark - Custom cell
- (void)configForRow:(MJTextImageTableRow *)row {
    [super configForRow:row];
    
    self.label.text = row.stringValue;
    self.label.font = row.detailTextFont;
    self.label.textColor = row.detailTextColor;
    
    self.image = row.imageView;
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.image];
}

#pragma mark - Layout subView
- (void)layoutSubviews {
	[super layoutSubviews];
    
    // left content view frame
	CGRect editFrame = CGRectInset(self.contentView.frame, 10, 0);
    
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.origin.x += textSize.width + 10;
		editFrame.size.width -= textSize.width + 20;
	}
    
    // label and image frame
    CGRect labelFrame = CGRectZero;
    CGRect imageFrame = CGRectZero;
    CGSize imageSize = CGSizeMake(44, editFrame.size.height - 10);
    CGFloat itemSpace = 5;
    if (((MJTextImageTableRow *)(self.row)).alignment == TextImageAlignmentImageLeft) {
        CGSize labelSize = [self.label sizeThatFits:CGSizeZero];
        labelFrame = CGRectMake(editFrame.origin.x + editFrame.size.width - labelSize.width,
                                editFrame.origin.y,
                                labelSize.width,
                                editFrame.size.height);
        imageFrame = CGRectMake(editFrame.origin.x + editFrame.size.width
                                - labelSize.width - imageSize.width - itemSpace,
                                (editFrame.size.height - imageSize.height)/2,
                                imageSize.width,
                                imageSize.height);
    }else {
        imageFrame = CGRectMake(editFrame.origin.x + editFrame.size.width - imageSize.width,
                                editFrame.origin.y + (editFrame.size.height - imageSize.height)/2,
                                imageSize.width,
                                imageSize.height);
        labelFrame = CGRectMake(editFrame.origin.x,
                                editFrame.origin.y,
                                editFrame.size.width - imageSize.width - itemSpace,
                                editFrame.size.height);
    }
    
	self.label.frame = labelFrame;
    self.image.frame = imageFrame;
}
@end
