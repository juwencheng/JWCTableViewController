//
//  JWCTableViewCellData.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewCellData.h"
#import "JWCTableViewCell.h"

@interface JWCTableViewCellData ()
@property(nonatomic, readwrite) Class cellClass;
@end

@implementation JWCTableViewCellData {
    JWCTableViewCellTapOperation _operation;
    CGFloat _rowHeight;
}
@synthesize operation = _operation;
@synthesize rowHeight = _rowHeight;

- (void)preLayout {
    // 子类实现，计算高度
}

@end
