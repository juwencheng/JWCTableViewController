//
//  JWCSettingViewController.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCSettingViewController.h"
#import "JWCSettingCellItem.h"
#import "JWCTableViewSectionData.h"
#import "JWCSettingCell.h"
#import "JWCSettingSectionData.h"
#import "JWCNoReuseDemoVC.h"

@interface JWCSettingViewController ()<JWCTableViewControllerDelegate>

@end

@implementation JWCSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送";

    JWCSettingCellItem *item1 = [[JWCSettingCellItem alloc] init];
    item1.title = @"开奖号码推送";
    item1.style = JWCSettingCellItemStyleArraw;
    item1.operation = ^(NSIndexPath *indexPath) {
        NSLog(@"点击 开奖号码推送");
        [self.navigationController pushViewController:[JWCNoReuseDemoVC tableViewControllerWithStyle:UITableViewStylePlain] animated:YES];
    };


    JWCSettingCellItem *item2 = [[JWCSettingCellItem alloc] init];
    item2.title = @"中奖动画";
    item2.style = JWCSettingCellItemStyleNone;

    JWCSettingCellItem *item3 = [[JWCSettingCellItem alloc] init];
    item3.title = @"购彩票定时提醒";
    item3.style = JWCSettingCellItemStyleSwitch;

    JWCSettingSectionData *group = [[JWCSettingSectionData alloc] init];
    group.children = @[item1, item2, item3];
    group.itemHeight = 50;

//    group.header = @"测试title";
    [self reloadData:@[group]];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JWCSettingCellItem *item4 = [[JWCSettingCellItem alloc] init];
        item4.title = @"购彩票定时提醒-2";
        item4.style = JWCSettingCellItemStyleSwitch;
        [self appendData:@[item4] toSection:0];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeData:@[item4] fromSection:0];
        });
    });

}

- (void)customizeTableViewStyle:(UITableView *)tableView {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)registerReuseCells {
    [self.tableView registReuseCellClass:[JWCSettingCell class] withCellDataClass:[JWCSettingCellItem class]];
}

@end
