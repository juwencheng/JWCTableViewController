//
//  JWCTableViewDelegateProxy.m
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import "JWCTableViewDelegateProxy.h"
#import "JWCTableViewControllerDelegate.h"
#import "UITableViewCell+JWC.h"

@interface JWCTableViewDelegateProxy ()

@property(nonatomic, strong) NSMutableSet<NSString*> *forwardSelectorStrings;

@end

@implementation JWCTableViewDelegateProxy
@synthesize jwc_data = _jwc_data;
+ (instancetype)proxyWithDelegate:(id<UITableViewDelegate>)delegate {
    JWCTableViewDelegateProxy *proxy = [[JWCTableViewDelegateProxy alloc] init];
    proxy.delegate = delegate;
    return proxy;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    if (!result) {
        result = [self.delegate respondsToSelector:aSelector];
        if (result) {
            [self.forwardSelectorStrings addObject:NSStringFromSelector(aSelector)];
        }
    }
    //NSLog(@"selector: %@ result: %d", NSStringFromSelector(aSelector), result);
    return result;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [self.forwardSelectorStrings containsObject:NSStringFromSelector(aSelector)] ? self.delegate : self;
}

//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    // 顺序到底应该如何？在考虑下
//    if ([self respondsToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:self];
//    }else {
//        [anInvocation invokeWithTarget:self.delegate];
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_data[(NSUInteger) indexPath.section];
    id <JWCTableViewCellDataProtocol> item = sectionData.children[(NSUInteger) indexPath.row];
    // 这里再将事件传递给 delegate ，二选一
    if (item.operation) {
        item.operation(indexPath);
    } else {
        if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_data[(NSUInteger) indexPath.section];
    return [sectionData heightForRowAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.tableView.sectionHeaderHeight > 0 ? self.tableView.sectionHeaderHeight :self.jwc_data[(NSUInteger) section].headerViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.tableView.sectionFooterHeight > 0 ? self.tableView.sectionFooterHeight : self.jwc_data[(NSUInteger) section].footerViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.jwc_data[(NSUInteger) section].headerViewHeight <= 0.1) {
        return nil;
    }

    return self.jwc_data[(NSUInteger) section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.jwc_data[(NSUInteger) section].footerView;
}

- (NSMutableSet<NSString *> *)forwardSelectorStrings {
    if (!_forwardSelectorStrings){
        _forwardSelectorStrings = [NSMutableSet set];
    }
    return _forwardSelectorStrings;
}
@end
