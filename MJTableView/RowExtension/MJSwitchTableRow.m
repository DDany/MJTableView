//
//  MJSwitchTableRow.m
//  DolphinSharing
//
//  Created by Dany on 13-3-27.
//  Copyright (c) 2013年 mojo-tech. All rights reserved.
//

#import "MJSwitchTableRow.h"

@interface MJSwitchTableRow ()

@property (nonatomic, strong) UIColor *tintColor;

@end

@implementation MJSwitchTableRow
{
    UISwitch *switchView;
}

#pragma mark - Public Methods

// override this method for your custom MJTableRow.
+ (MJSwitchTableRow *)row {
    return [[MJSwitchTableRow alloc] init];
}

+ (MJSwitchTableRow *)rowWithText:(NSString *)text tintColor:(UIColor *)tintColor switchOn:(BOOL)switchOn {
    MJSwitchTableRow *row = (MJSwitchTableRow *)[self row];
    row.text = text;
    row.tintColor = tintColor;
    row.on = switchOn;
    return row;
}

#pragma mark - Init
// override this method for your custom init.
- (id)init {
    self = [super init];
    if (self) {
        self.tintColor = [UIColor lightGrayColor];
        
        switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        switchView.onTintColor = self.tintColor;
        [switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = switchView;
    }
    return self;
}

#pragma mark - Getter & Setter
- (BOOL)isOn {
    return switchView.on;
}

- (void)setOn:(BOOL)on {
    switchView.on = on;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        return [UIColor lightGrayColor];
    }
    
    return _tintColor;
}

#pragma mark - Value changed
- (void)switchValueChanged:(id)sender {
    if (self.onValueChanged) {
        self.onValueChanged(switchView.on);
    }
}

@end
