//
//  UITableViewCell+JWC.h
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCTableViewControllerDelegate.h"

@interface UITableViewCell (JWC)
/**
 * 快捷生成 cell 的方法，cell 样式默认为 UITableViewCellStyleDefault
 * @param data JWCTableViewCellDataProtocol
 * @return JWCTableViewCell
 */
+ (instancetype)cellWithData:(id <JWCTableViewCellDataProtocol>)data;

/**
 * 快捷生成 cell 的方法，可以指定 cell 的样式
 * @param data JWCTableViewCellDataProtocol
 * @param style UITableViewCellStyle
 * @return JWCTableViewCell
 */
+ (instancetype)cellWithData:(id <JWCTableViewCellDataProtocol>)data style:(UITableViewCellStyle)style;

/**
 * 配置 cell 的数据
 * @param cellData JWCTableViewCellDataProtocol
 */
- (void)configureData:(id <JWCTableViewCellDataProtocol>)cellData;

@property(nonatomic, strong, readonly) id <JWCTableViewCellDataProtocol> data;
@end
