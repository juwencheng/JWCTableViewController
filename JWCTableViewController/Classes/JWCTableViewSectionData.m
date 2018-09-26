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
    if (self.itemHeight == UITableViewAutomaticDimension) return UITableViewAutomaticDimension;
    else if (self.itemHeight > 0) return self.itemHeight;
    else if (index < self.children.count) return self.children[(NSUInteger) index].cellHeight;
    else return UITableViewAutomaticDimension;
}

- (UIView *)headerView {
    if (!_headerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        NSString *text = self.header.length == 0 ? @"" : [NSString stringWithFormat:@"  %@", self.header];
        label.text = text;
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
        _footerView = label;
    }
    return _footerView;
}

@end
