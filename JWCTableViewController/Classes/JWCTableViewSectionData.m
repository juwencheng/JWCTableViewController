//
//  JWCSectionGroup.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewSectionData.h"
#import "JWCTableViewCellData.h"

@interface JWCTableViewSectionData ()

@end

@implementation JWCTableViewSectionData

+ (instancetype)sectionDataWithHeader:(NSString *)header footer:(NSString *)footer children:(NSArray<JWCTableViewCellData *> *)children {
    JWCTableViewSectionData *data = [[JWCTableViewSectionData alloc] init];
    data.header = header;
    data.footer = footer;
    data.children = children;
    return data;
}

+ (instancetype)sectionDataWithChildren:(NSArray<JWCTableViewCellData *> *)children {
    JWCTableViewSectionData *data = [[JWCTableViewSectionData alloc] init];
    data.children = children;
    return data;
}

- (CGFloat)cellHeightWithIndex:(NSInteger)index {
    if (index < self.children.count) return self.children[(NSUInteger) index].cellHeight;
    else return UITableViewAutomaticDimension;
}

- (CGFloat)sectionFooterHeight {
    return 0.1;
}

- (CGFloat)sectionHeaderHeight {
    return 0.1;
}

- (UIView *)headerView {
    if (!_headerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.text = [NSString stringWithFormat:@"  %@", self.header];
        _headerView = label;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.text = [NSString stringWithFormat:@"  %@", self.footer];
        _footerView = label;
    }
    return _footerView;
}

@end
