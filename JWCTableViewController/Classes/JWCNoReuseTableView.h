//
//  JWCNoReuseTableView.h
//  JWCTableViewController
//
//  Created by 鞠汶成 on 2018/9/25.
//

#import <UIKit/UIKit.h>

@class JWCTableViewSectionCell;
@class JWCTableViewCell;
@class JWCTableViewCellData;

@interface JWCNoReuseTableView : UITableView

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

- (NSArray<JWCTableViewCell *> *)cellsWithCellClass:(JWCTableViewCell *)cell data:(NSArray<JWCTableViewCellData *> *)data;

@end
