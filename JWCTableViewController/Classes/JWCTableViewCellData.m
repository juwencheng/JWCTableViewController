//
//  JWCTableViewCellData.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewCellData.h"
#import "JWCTableViewCell.h"

@implementation JWCTableViewCellData

- (CGFloat)cellHeight {
    return UITableViewAutomaticDimension;
}

- (void)preLayout {
    // 子类实现，计算高度
}

+ (Class)cellClass {
    return [JWCTableViewCell class];
}

@end
