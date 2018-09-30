//
//  UITableView+JWC.h
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCTableViewProtocol.h"

@class JWCTableViewDataSourceProxy;
@class JWCTableViewDelegateProxy;

@interface UITableView (JWC)
/**
 * 刷新列表数据
 * @param data NSArray<JWCTableViewSectionCell *>
 */
- (void)reloadData:(NSArray<id <JWCTableViewSectionDataProtocol>> *)data;

/**
 * 添加数据 data 到某个 section，并刷新
 * @param data NSArray<JWCTableViewCell *>
 * @param section section number
 */
- (void)appendData:(NSArray<id <JWCTableViewCellDataProtocol> > *)data toSection:(NSInteger)section;

/**
 * 追加更多数据并刷新列表
 * @param moreData NSArray<JWCTableViewSectionCell *>
 */
- (void)loadMoreData:(NSArray<id <JWCTableViewSectionDataProtocol>> *)moreData;

/**
 * 删除某个 section 并刷新列表
 * @param section NSInteger
 */
- (void)removeSection:(NSInteger)section;

/**
 * 删除某个 section 的中的 data 数据，并刷新列表
 * @param data NSArray <JWCTableViewCellDataProtocol *>
 * @param section NSInteger
 */
- (void)removeData:(NSArray <id <JWCTableViewCellDataProtocol>> *)data fromSection:(NSInteger)section;


- (void)registerReuseCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;


- (void)registerReuseNibCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;

/**
 * proxyDelete，避免和 delegate 冲突，传入类型为 JWCTableViewDelegateProxy，其他类型会忽略
 */
@property(nonatomic, strong) JWCTableViewDelegateProxy *proxyDelegate;

/**
 * proxyDataSource，避免和 datasource 冲突，传入类型为 JWCTableViewDataSourceProxy，其他类型会忽略
 */
@property(nonatomic, strong) JWCTableViewDataSourceProxy *proxyDataSource;

@property(nonatomic, strong, readonly) NSArray<id <JWCTableViewSectionDataProtocol>> *jwc_data;

@end
