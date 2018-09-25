//
//  JWCTableViewControllerDelegate.h
//  JWCTableViewController
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

@protocol JWCTableViewControllerDelegate <NSObject>

@optional
- (void)registerReuseCells;

- (void)customizeTableViewConstraints:(UITableView *)tableView;

- (void)customizeTableViewStyle:(UITableView *)tableView;

@end




