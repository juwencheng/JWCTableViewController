//
//  JWCTableViewSectionCell.m
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import "JWCTableViewSectionCell.h"
#import "JWCTableViewCell.h"

@interface JWCTableViewSectionCell ()

@property (nonatomic, strong) NSMutableArray *cellHeights;
@end

@implementation JWCTableViewSectionCell
- (CGFloat)cellHeightWithIndex:(NSInteger)index {
    if (self.itemHeight > 0) return self.itemHeight;
    if (index < self.cellHeights.count) return [self.cellHeights[(NSUInteger) index] floatValue];
    else return UITableViewAutomaticDimension;
}

- (void)setChildren:(NSArray<JWCTableViewCell *> *)children {
    _children = children;
    [_cellHeights removeAllObjects];
    for (JWCTableViewCell *cell in children) {
        [_cellHeights addObject:@(cell.frame.size.height)];
    }
}

- (UIView *)headerView {
    if (!_headerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        NSString *text = self.header.length == 0 ? @"" : [NSString stringWithFormat:@"  %@", self.header];
        label.text = text;
        label.backgroundColor = [UIColor whiteColor];
        _headerView = label;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        NSString *text = self.footer.length == 0 ? @"" : [NSString stringWithFormat:@"  %@", self.footer];
        label.text = text;
        label.backgroundColor = [UIColor whiteColor];
        _footerView = label;
    }
    return _footerView;
}

- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}

@end
