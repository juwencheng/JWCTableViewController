//
//  JWCSettingCell.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWCTableViewCellData;

// 如果支持范型就好了
@interface JWCTableViewCell : UITableViewCell
/**
 * 快捷生成 cell 的方法，cell 样式默认为 UITableViewCellStyleDefault
 * @param data JWCTableViewCellData
 * @return JWCTableViewCell
 */
+ (instancetype)cellWithData:(JWCTableViewCellData *)data;

/**
 * 快捷生成 cell 的方法，可以指定 cell 的样式
 * @param data JWCTableViewCellData
 * @param style UITableViewCellStyle
 * @return JWCTableViewCell
 */
+ (instancetype)cellWithData:(JWCTableViewCellData *)data style:(UITableViewCellStyle)style;

/**
 * 配置 cell 的数据
 * @param data JWCTableViewCellData
 */
- (void)configureData:(JWCTableViewCellData *)data;

- (void)commonInit;

@property(nonatomic, strong, readonly) JWCTableViewCellData *data;

@end
