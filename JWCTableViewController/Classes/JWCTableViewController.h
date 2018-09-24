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

- (void)reloadData:(NSArray<JWCTableViewSectionData *> *)data;

- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section;

- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData;

- (void)removeSection:(NSInteger)section;

- (void)removeData:(NSArray <JWCTableViewCellData *> *)data fromSection:(NSInteger)section;

- (void)applyConfigure:(JWCTableViewConfigure *)configure;

- (void)configureTableView;

+ (instancetype)tableViewControllerWithConfigure:(JWCTableViewConfigure *)configure;

@property(nonatomic, strong, readonly) UITableView *tableView;

@end
