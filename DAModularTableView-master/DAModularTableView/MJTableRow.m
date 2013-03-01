//
//  MJTableRow.m
//  DAModularTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MJTableRow.h"
#import "MJTableViewCell.h"

@implementation MJTableRow

#pragma mark - Public Methods

// override this method for your custom MJTableRow.
+ (MJTableRow *)row
{
    return [[MJTableRow alloc] init];
}

// override this method for your custom init.
- (id)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.cellStyle = UITableViewCellStyleDefault;
        self.rowAnimation = UITableViewRowAnimationAutomatic;
    }
    return self;
}

#pragma mark - Create cell
// override this method for your custom cell.
- (UITableViewCell *)cell
{
    MJTableViewCell *cell = [[MJTableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:self.reuseIdentifier];
    
    [cell prepareForRow:self];
    
    return cell;
}

@end
