//
//  JWCTableViewDataSourceProxy.m
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import "JWCTableViewDataSourceProxy.h"
#import "JWCTableViewProtocol.h"
#import "UITableViewCell+JWC.h"

@interface JWCTableViewDataSourceProxy ()

@property(nonatomic, strong) NSMutableDictionary *dataClass2CellClass;
@property(nonatomic, strong) NSMutableSet<NSString *> *forwardSelectorStrings;

@end

@implementation JWCTableViewDataSourceProxy

+ (instancetype)proxyWithDataSource:(id <UITableViewDataSource>)dataSource {
    JWCTableViewDataSourceProxy *proxy = [[self alloc] init];
    proxy.dataSource = dataSource;
    return proxy;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    if (!result) {
        result = [self.dataSource respondsToSelector:aSelector];
        if (result) {
            [self.forwardSelectorStrings addObject:NSStringFromSelector(aSelector)];
        }
    }
    //NSLog(@"selector: %@ result: %d", NSStringFromSelector(aSelector), result);
    return result;
}

// 可以在这里控制允许哪些方法能够让delegate实现
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [self.forwardSelectorStrings containsObject:NSStringFromSelector(aSelector)] ? self.dataSource : [super forwardingTargetForSelector:aSelector];
}

- (UITableViewCell *)dequeueCellWithClassStr:(NSString *)cellClassStr {
    return [self.tableView dequeueReusableCellWithIdentifier:cellClassStr];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.jwc_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_data[(NSUInteger) section];
    return sectionData.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_data[(NSUInteger) indexPath.section];
    id <JWCTableViewCellDataProtocol> item = sectionData.children[(NSUInteger) indexPath.row];
    NSString *cellClassStr = self.dataClass2CellClass[NSStringFromClass([item class])];
    UITableViewCell *cell = [self dequeueCellWithClassStr:cellClassStr];
    [cell configureData:item];
    return cell;
}

- (void)registerReuseCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    self.dataClass2CellClass[NSStringFromClass(cellDataClass)] = NSStringFromClass(cellClass);
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerReuseNibCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    self.dataClass2CellClass[NSStringFromClass(cellDataClass)] = NSStringFromClass(cellClass);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)dealloc {
#ifdef DEBUG
//    NSLog(@"proxy 被释放了");
#endif
}

- (NSMutableDictionary *)dataClass2CellClass {
    if (!_dataClass2CellClass) {
        _dataClass2CellClass = [NSMutableDictionary dictionary];
    }
    return _dataClass2CellClass;
}

- (NSMutableSet<NSString *> *)forwardSelectorStrings {
    if (!_forwardSelectorStrings) {
        _forwardSelectorStrings = [NSMutableSet set];
    }
    return _forwardSelectorStrings;
}

@end
