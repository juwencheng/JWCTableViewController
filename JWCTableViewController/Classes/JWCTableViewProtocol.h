//
//  JWCTableViewControllerDelegate.h
//  JWCTableViewController
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void (^JWCTableViewCellTapOperation)(NSIndexPath *indexPath);

@protocol JWCTableViewCellDataProtocol<NSObject>
@required
/**
 * cell 的高度，可以重写后在get方法中计算，
 */
@property(nonatomic, assign) CGFloat rowHeight;

/**
 * 处理点击事件
 */
@property(nonatomic, copy) JWCTableViewCellTapOperation operation;

@optional
/**
 * 预渲染，计算cell高度
 */
- (void)preLayout;
@end


@protocol JWCTableViewSectionDataProtocol<NSObject>

- (NSArray<id<JWCTableViewSectionDataProtocol>> *)convertChildrenToSectionData;

/**
 * 获取 cellHeight
 * @param index cellHeight
 * @return CGFLoat
 */
- (CGFloat)heightForRowAtIndex:(NSInteger)index;

/**
 * section header高度
 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/**
 * section footer 高度
 * @return CGFloat
 */
@property (nonatomic, assign) CGFloat footerViewHeight;

/**
 * header 标题
 */
@property(nonatomic, copy) NSString *headerTitle;

/**
 * headerView
 */
@property(nonatomic, strong) UIView *headerView;

/**
 * footer 标题
 */
@property(nonatomic, copy) NSString *footerTitle;

/**
 * footerView
 */
@property(nonatomic, strong) UIView *footerView;

/**
 * rowHeight 使用时需注意，如果设置了 rowHeight，会优先使用itemHeight的高度
 */
@property(nonatomic, assign) CGFloat rowHeight;

/**
 * section 下面的数据
 */
@property(nonatomic, strong) NSArray<id<JWCTableViewCellDataProtocol>> *children;


@end
