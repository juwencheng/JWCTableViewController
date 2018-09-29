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

@implementation JWCTableViewSectionData {
    CGFloat _headerViewHeight;
    CGFloat _footerViewHeight;
    NSString *_headerTitle;
    UIView *_headerView;
    NSString *_footerTitle;
    UIView *_footerView;
    UIView *_rowHeight;
    NSArray<id <JWCTableViewCellDataProtocol>> *_children;
}
@synthesize headerView;
@synthesize footerView;
@synthesize headerTitle;
@synthesize headerViewHeight;
@synthesize footerTitle;
@synthesize footerViewHeight;
@synthesize rowHeight;
@synthesize children;

+ (instancetype)sectionDataWithHeader:(NSString *)header footer:(NSString *)footer children:(NSArray<JWCTableViewCellData *> *)children {
    JWCTableViewSectionData *data = [[JWCTableViewSectionData alloc] init];
    data.headerTitle = header;
    data.footerTitle = footer;
    data.children = children;
    return data;
}

+ (instancetype)sectionDataWithChildren:(NSArray<JWCTableViewCellData *> *)children {
    JWCTableViewSectionData *data = [[JWCTableViewSectionData alloc] init];
    data.children = children;
    return data;
}

- (UIView *)headerView {
    if (!_headerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        NSString *text = self.headerTitle.length == 0 ? @"" : [NSString stringWithFormat:@"  %@", self.headerTitle];
        label.text = text;
        _headerView = label;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        NSString *text = self.footerTitle.length == 0 ? @"" : [NSString stringWithFormat:@"  %@", self.footerTitle];
        label.text = text;
        _footerView = label;
    }
    return _footerView;
}

- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    CGFloat rowHeight = self.children[(NSUInteger) index].rowHeight;
    return rowHeight == 0 ? self.rowHeight : rowHeight;

}

@end
