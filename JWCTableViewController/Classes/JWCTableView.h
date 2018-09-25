//
// Created by 鞠汶成 on 2018/9/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JWCTableViewSectionData;
@class JWCTableViewCellData;


@interface JWCTableView : UITableView

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

- (void)registReuserCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass;

@end
