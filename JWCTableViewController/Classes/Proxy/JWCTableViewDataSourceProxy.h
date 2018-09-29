//
//  JWCTableViewDataSourceProxy.h
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JWCTableViewSectionDataProtocol;

@interface JWCTableViewDataSourceProxy : NSObject <UITableViewDataSource>

+ (instancetype)proxyWithDataSource:(id <UITableViewDataSource>)dataSource;

- (void)registerReuseCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;

- (void)registerReuseNibCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;

/**
 * 宿主 tableView
 */
@property(nonatomic, weak) UITableView *tableView;

/**
 * 宿主 dataSource
 */
@property(nonatomic, weak) id <UITableViewDataSource> dataSource;

/**
 * 数据
 */
@property(nonatomic, weak) NSArray<id <JWCTableViewSectionDataProtocol>> *jwc_data;

@end
