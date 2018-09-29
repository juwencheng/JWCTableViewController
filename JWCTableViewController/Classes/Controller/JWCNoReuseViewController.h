//
//  JWCNoReuseViewController.h
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//  不使用复用机制，常用与菜单的tableView

#import <UIKit/UIKit.h>
#import "UITableView+JWC.h"

@interface JWCNoReuseViewController : UIViewController

+ (instancetype)tableViewControllerWithStyle:(UITableViewStyle)style;

- (void)configureTableView;

- (void)addTableViewConstraints;

@property(nonatomic, strong, readonly) UITableView *tableView;
@end
