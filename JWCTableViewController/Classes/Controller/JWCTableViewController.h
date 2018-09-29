//
//  JWCTableViewController.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCTableViewSectionData.h"
#import "JWCTableViewCell.h"
#import "UITableView+JWC.h"

@protocol JWCTableViewControllerDelegate;

@interface JWCTableViewController : UIViewController

+ (instancetype)tableViewControllerWithStyle:(UITableViewStyle)style;

- (void)configureTableView;

- (void)addTableViewConstraints;

@property(nonatomic, strong, readonly) UITableView *tableView;


@end
