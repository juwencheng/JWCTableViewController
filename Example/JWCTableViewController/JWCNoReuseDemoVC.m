//
//  JWCNoReuseDemoVC.m
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import "JWCNoReuseDemoVC.h"
#import "JWCSettingCellData.h"
#import <JWCTableViewController/JWCTableViewCell.h>
#import <JWCTableViewController/JWCTableViewSectionData.h>
#import <JWCTableViewController/JWCTableViewNoReuseDataSourceProxy.h>

#import "JWCSettingCell.h"

@interface JWCNoReuseDemoVC ()

@end

@implementation JWCNoReuseDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}

- (void)setupData {
    
    JWCSettingCellData *data1 = [[JWCSettingCellData alloc] init];
    data1.title = @"菜单1-noreuse";
    data1.style = JWCSettingCellItemStyleArraw;
    data1.operation = ^(NSIndexPath *indexPath) {
        NSLog(@"点击 开奖号码推送");
    };

    JWCSettingCellData *data2 = [[JWCSettingCellData alloc] init];
    data2.title = @"中奖动画-noreuse";
    data2.style = JWCSettingCellItemStyleNone;
    
    JWCSettingCellData *data3 = [[JWCSettingCellData alloc] init];
    data3.title = @"购彩票定时提醒-noreuse";
    data3.style = JWCSettingCellItemStyleSwitch;
    
    JWCTableViewSectionData *section = [[JWCTableViewSectionData alloc] init];
    section.rowHeight = 50;
    section.children = @[
            [JWCSettingCell cellWithData:data1],
            [JWCSettingCell cellWithData:data2],
            [JWCSettingCell cellWithData:data3]
            ];
    [self.tableView reloadData:@[section]];
}

- (void)dealloc {
    NSLog(@"JWCNoReuseDemoVC 被释放了");
}

@end
