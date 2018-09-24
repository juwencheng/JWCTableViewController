//
//  JWCSectionGroup.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JWCTableViewCellData;

@interface JWCTableViewSectionData : NSObject

+ (instancetype)sectionDataWithHeader:(NSString *)header footer:(NSString *)footer children:(NSArray<JWCTableViewCellData *> *)children;

+ (instancetype)sectionDataWithChildren:(NSArray<JWCTableViewCellData *> *)children;

/**
 * 获取 cellHeight
 * @param index cellHeight
 * @return CGFLoat
 */
- (CGFloat)cellHeightWithIndex:(NSInteger)index;

/**
 * section header高度
 */
- (CGFloat)sectionHeaderHeight;

/**
 * section footer 高度
 * @return CGFloat
 */
- (CGFloat)sectionFooterHeight;

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
@property(nonatomic, strong) NSArray<JWCTableViewCellData *> *children;

@end
