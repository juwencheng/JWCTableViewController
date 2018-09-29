//
//  JWCTableViewSectionCell.h
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JWCTableViewCell;

@interface JWCTableViewSectionCell : NSObject
/**
 * 获取 cellHeight
 * @param index cellHeight
 * @return CGFLoat
 */
- (CGFloat)cellHeightWithIndex:(NSInteger)index;

/**
 * section header高度
 */
@property (nonatomic, assign) CGFloat sectionHeaderHeight;

/**
 * section footer 高度
 * @return CGFloat
 */
@property (nonatomic, assign) CGFloat sectionFooterHeight;

/**
 * header 标题
 */
@property(nonatomic, copy) NSString *header;

/**
 * headerView
 */
@property(nonatomic, strong) UIView *headerView;

/**
 * footer 标题
 */
@property(nonatomic, copy) NSString *footer;

/**
 * footerView
 */
@property(nonatomic, strong) UIView *footerView;

/**
 * itemHeight 使用时需注意，如果设置了 itemHeight，会优先使用itemHeight的高度
 */
@property(nonatomic, assign) CGFloat itemHeight;

/**
 * section 下面的数据
 */
@property(nonatomic, strong) NSArray<JWCTableViewCell *> *children;

@end
