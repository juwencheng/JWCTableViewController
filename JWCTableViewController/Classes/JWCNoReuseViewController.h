//
//  JWCNoReuseViewController.h
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//  不使用复用机制，常用与菜单的tableView

#import <UIKit/UIKit.h>
#import "JWCTableViewControllerDelegate.h"

@class JWCTableViewSectionCell;
@class JWCTableViewCell;
@class JWCNoReuseTableView;

@interface JWCNoReuseViewController : UIViewController
/**
 * 刷新列表数据
 * @param data NSArray<JWCTableViewSectionCell *>
 */
- (void)reloadData:(NSArray<JWCTableViewSectionCell *> *)data;

/**
 * 添加数据 data 到某个 section，并刷新
 * @param data NSArray<JWCTableViewCell *>
 * @param section section number
 */
- (void)appendData:(NSArray<JWCTableViewCell *> *)data toSection:(NSInteger)section;

/**
 * 追加更多数据并刷新列表
 * @param moreData NSArray<JWCTableViewSectionCell *>
 */
- (void)loadMoreData:(NSArray<JWCTableViewSectionCell *> *)moreData;

/**
 * 删除某个 section 并刷新列表
 * @param section NSInteger
 */
- (void)removeSection:(NSInteger)section;

/**
 * 删除某个 section 的中的 data 数据，并刷新列表
 * @param data NSArray <JWCTableViewCellData *>
 * @param section NSInteger
 */
- (void)removeData:(NSArray <JWCTableViewCell *> *)data fromSection:(NSInteger)section;

/**
 * 快捷方法生成 JWCTableViewController
 * @param style UITableViewStyle
 * @return JWCTableViewController
 */
+ (instancetype)tableViewControllerWithStyle:(UITableViewStyle)style;

@property (nonatomic, weak) id<JWCTableViewControllerDelegate> delegate;

@property(nonatomic, strong, readonly) JWCNoReuseTableView *tableView;
@end
