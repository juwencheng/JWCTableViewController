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

+ (void)load {
    // 交换 setDelegate 方法
    Method method = class_getInstanceMethod([self class], @selector(setDelegate:));
    Method exchangedMethod = class_getInstanceMethod([self class], @selector(setJWCDelegate:));
    method_exchangeImplementations(method, exchangedMethod);

    Method dataSourceMethod = class_getInstanceMethod([self class], @selector(setDataSource:));
    Method exchangedDataSourceMethod = class_getInstanceMethod([self class], @selector(setJWCDataSource:));
    method_exchangeImplementations(dataSourceMethod, exchangedDataSourceMethod);
}

- (void)setJWCDelegate:(id <UITableViewDelegate>)delegate {
    if (delegate == nil) return;
    JWCTableViewDelegateProxy *proxy;
    if ([delegate isKindOfClass:[JWCTableViewDelegateProxy class]]) {
        proxy = delegate;
    }else {
        proxy = [JWCTableViewDelegateProxy proxyWithDelegate:delegate];
    }
    proxy.tableView = self;
    proxy.jwc_data = [self jwc_innerData];
    objc_setAssociatedObject(self, &jwc_delegateProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setJWCDelegate:proxy];
}

- (void)setJWCDataSource:(id <UITableViewDataSource>)dataSource {
    if (dataSource == nil) return;
    JWCTableViewDataSourceProxy *proxy;
    if ([dataSource isKindOfClass:[JWCTableViewDataSourceProxy class]]) {
        proxy = dataSource;
    }else {
        proxy = [JWCTableViewDataSourceProxy proxyWithDataSource:dataSource];
    }
    proxy.tableView = self;
    proxy.jwc_data = [self jwc_innerData];
    objc_setAssociatedObject(self, &jwc_datasourceProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setJWCDataSource:proxy];
}

- (id <UITableViewDataSource>)dataSource {
    return [self jwc_datasourceProxy];
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


