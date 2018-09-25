//
//  JWCNoReuseDemoVC.m
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import "JWCNoReuseDemoVC.h"
#import "JWCSettingCellItem.h"
#import <JWCTableViewController/JWCTableViewCell.h>
#import <JWCTableViewController/JWCTableViewSectionCell.h>
#import "JWCSettingCell.h"
@interface JWCNoReuseDemoVC ()

@end

@implementation JWCNoReuseDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}

- (void)setupData {
    JWCSettingCellItem *item1 = [[JWCSettingCellItem alloc] init];
    item1.title = @"开奖号码推送-noreuse";
    item1.style = JWCSettingCellItemStyleArraw;
    item1.operation = ^(NSIndexPath *indexPath) {
        NSLog(@"点击 开奖号码推送");
    };
    
    
    JWCSettingCellItem *item2 = [[JWCSettingCellItem alloc] init];
    item2.title = @"中奖动画-noreuse";
    item2.style = JWCSettingCellItemStyleNone;
    
    JWCSettingCellItem *item3 = [[JWCSettingCellItem alloc] init];
    item3.title = @"购彩票定时提醒-noreuse";
    item3.style = JWCSettingCellItemStyleSwitch;
    
    JWCTableViewSectionCell *section = [[JWCTableViewSectionCell alloc] init];
    section.sectionHeaderHeight = 30;
    section.children = @[
            [JWCSettingCell cellWithData:item1],
            [JWCSettingCell cellWithData:item2],
            [JWCSettingCell cellWithData:item3]
            ];
        //    group.header = @"测试title";
    [self reloadData:@[section]];
}

@end
