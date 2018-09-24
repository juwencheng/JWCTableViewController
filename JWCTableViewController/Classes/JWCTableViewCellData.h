//
//  JWCTableViewCellData.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JWCTableViewCellTapOperation)(NSIndexPath *indexPath);

@interface JWCTableViewCellData : NSObject
/**
 * cell 的高度，可以重写后在get方法中计算，
 */
@property(nonatomic, assign) CGFloat cellHeight;

/**
 * 处理点击事件
 */
@property(nonatomic, copy) JWCTableViewCellTapOperation operation;

/**
 * 预渲染，计算cell高度
 */
- (void)preLayout;

+ (Class)cellClass;

@end
