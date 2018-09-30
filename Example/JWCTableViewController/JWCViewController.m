//
//  JWCViewController.m
//  JWCTableViewController
//
//  Created by Juwencheng on 09/24/2018.
//  Copyright (c) 2018 Juwencheng. All rights reserved.
//

#import "JWCViewController.h"

@interface JWCViewController ()

@end

@implementation JWCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

@end
