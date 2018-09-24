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

- (void)configureData:(JWCTableViewCellData *)data;

@property(nonatomic, strong, readonly) JWCTableViewCellData *data;

@end
