//
//  UITableView+JWC.m
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import "UITableView+JWC.h"
#import <objc/runtime.h>
#import "UITableViewCell+JWC.h"
#import "JWCTableViewDelegateProxy.h"
#import "JWCTableViewDataSourceProxy.h"

static const void *jwc_innerDataKey = &jwc_innerDataKey;
static const void *jwc_delegateProxyKey = &jwc_delegateProxyKey;
static const void *jwc_datasourceProxyKey = &jwc_datasourceProxyKey;

@implementation UITableView (JWC)


- (void)setProxyDataSource:(JWCTableViewDataSourceProxy *)proxyDataSource {
    if (proxyDataSource == nil) return;
    if ([proxyDataSource isKindOfClass:[JWCTableViewDataSourceProxy class]]) {
        proxyDataSource.tableView = self;
        proxyDataSource.jwc_data = [self jwc_innerData];
        objc_setAssociatedObject(self, &jwc_datasourceProxyKey, proxyDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setDataSource:proxyDataSource];
    }
}

- (void)setProxyDelegate:(JWCTableViewDelegateProxy *)proxyDelegate {
    if (proxyDelegate == nil) return;
    if ([proxyDelegate isKindOfClass:[JWCTableViewDelegateProxy class]]) {
        proxyDelegate.tableView = self;
        proxyDelegate.jwc_data = [self jwc_innerData];
        objc_setAssociatedObject(self, &jwc_delegateProxyKey, proxyDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setDelegate:proxyDelegate];
    }
}

- (JWCTableViewDelegateProxy *)proxyDelegate {
    return objc_getAssociatedObject(self, &jwc_delegateProxyKey);
}

- (JWCTableViewDataSourceProxy *)proxyDataSource {
    return objc_getAssociatedObject(self, &jwc_datasourceProxyKey);
}

- (void)reloadData:(NSArray<id <JWCTableViewSectionDataProtocol>> *)data {
    [self.jwc_innerData removeAllObjects];
    [self.jwc_innerData addObjectsFromArray:data];
    [self reloadData];
}

- (void)appendData:(NSArray<id <JWCTableViewCellDataProtocol>> *)data toSection:(NSInteger)section {
    if (self.jwc_innerData.count > section) {
        id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_innerData[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren addObjectsFromArray:data];
        sectionData.children = [sectionChildren copy];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeSection:(NSInteger)section {
    if (self.jwc_innerData.count > section) {
        [self.jwc_innerData removeObjectAtIndex:(NSUInteger) section];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeData:(NSArray<id <JWCTableViewCellDataProtocol>> *)data fromSection:(NSInteger)section {
    if (self.jwc_innerData.count > section) {
        id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_innerData[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren removeObjectsInArray:data];
        sectionData.children = [sectionChildren copy];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)loadMoreData:(NSArray<id <JWCTableViewSectionDataProtocol>> *)moreData {
    [self.jwc_innerData addObjectsFromArray:moreData];
    [self reloadData];
}


- (void)registerReuseCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    [[self jwc_datasourceProxy] registerReuseCellClass:cellClass withCellDataClass:cellDataClass];
}

- (void)registerReuseNibCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    [[self jwc_datasourceProxy] registerReuseNibCellClass:cellClass withCellDataClass:cellDataClass];
}

#pragma mark - property

- (NSArray<id <JWCTableViewSectionDataProtocol>> *)jwc_data {
    return [[self jwc_innerData] copy];
}

- (NSMutableArray<id <JWCTableViewSectionDataProtocol>> *)jwc_innerData {
    NSMutableArray *data = objc_getAssociatedObject(self, &jwc_innerDataKey);
    if (!data) {
        data = [NSMutableArray array];
        objc_setAssociatedObject(self, &jwc_innerDataKey, data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return data;
}

- (JWCTableViewDelegateProxy *)jwc_delegateProxy {
    JWCTableViewDelegateProxy *proxy = objc_getAssociatedObject(self, &jwc_delegateProxyKey);
    return proxy;
}

- (JWCTableViewDataSourceProxy *)jwc_datasourceProxy {
    JWCTableViewDataSourceProxy *proxy = objc_getAssociatedObject(self, &jwc_datasourceProxyKey);
    return proxy;
}
@end


