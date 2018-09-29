//
//  JWCTableViewNoReuseDataSourceProxy.m
//  JWCTableViewController
//
//  Created by 鞠汶成 on 2018/9/29.
//

#import "JWCTableViewNoReuseDataSourceProxy.h"

@implementation JWCTableViewNoReuseDataSourceProxy

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <JWCTableViewSectionDataProtocol> sectionData = self.jwc_data[(NSUInteger) indexPath.section];
    id<JWCTableViewCellDataProtocol> item = sectionData.children[(NSUInteger) indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)item;
    return cell;
}

@end
