//
//  DAModularTableViewController.m
//  DAModularTableView
//
//  Created by Daniel Amitay on 8/5/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "MJTableViewController.h"

@interface MJTableViewController ()

@property (nonatomic) UITableViewStyle style;

@end

@implementation MJTableViewController
@synthesize style = _style;
@synthesize tableView = _tableView;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self)
    {
        self.style = style;
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[MJTableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]
                                                         style:self.style];
    self.view = self.tableView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
