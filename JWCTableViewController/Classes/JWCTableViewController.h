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


@interface JWCTableViewConfigure : NSObject
/**
 * 是否是group样式
 */
@property(nonatomic, assign) BOOL groupStyle;
/**
 * 是否自动计算高度
 */
@property(nonatomic, assign) BOOL isAutolayoutHeight;


@end


@interface JWCTableViewController : UIViewController
/**
 * 刷新列表数据
 * @param data NSArray<JWCTableViewSectionData *>
 */
- (void)reloadData:(NSArray<JWCTableViewSectionData *> *)data;

/**
 * 添加数据 data 到某个 section，并刷新
 * @param data NSArray<JWCTableViewCellData *>
 * @param section section number
 */
- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section;

/**
 * 追加更多数据并刷新列表
 * @param moreData NSArray<JWCTableViewSectionData *>
 */
- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData;

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
- (void)removeData:(NSArray <JWCTableViewCellData *> *)data fromSection:(NSInteger)section;

/**
 * 应用配置
 * @param configure JWCTableViewConfigure
 */
- (void)applyConfigure:(JWCTableViewConfigure *)configure;

/**
 * 配置tableView，子类继承
 */
- (void)configureTableView;

- (void)registReuserCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;

/**
 * 快捷方法生成 JWCTableViewController
 * @param configure JWCTableViewConfigure
 * @return JWCTableViewController
 */
+ (instancetype)tableViewControllerWithConfigure:(JWCTableViewConfigure *)configure;

@property(nonatomic, strong, readonly) UITableView *tableView;


@end
