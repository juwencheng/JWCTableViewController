//
//  JWCTableViewDelegateProxy.h
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JWCTableViewSectionDataProtocol;

@interface JWCTableViewDelegateProxy : NSObject <UITableViewDelegate>

+ (instancetype)proxyWithDelegate:(id <UITableViewDelegate>)delegate;

/**
 * 宿主 tableView
 */
@property(nonatomic, weak) UITableView *tableView;

/**
 * 宿主 delegate
 */
@property(nonatomic, weak) id <UITableViewDelegate> delegate;

/**
 * 数据
 */
@property(nonatomic, weak) NSArray<id <JWCTableViewSectionDataProtocol>> *jwc_data;

@end
