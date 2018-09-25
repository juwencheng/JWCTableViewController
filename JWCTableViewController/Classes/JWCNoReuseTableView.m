//
//  JWCNoReuseTableView.m
//  JWCTableViewController
//
//  Created by 鞠汶成 on 2018/9/25.
//

#import "JWCNoReuseTableView.h"
#import "JWCTableViewSectionCell.h"
#import "JWCTableViewCell.h"
#import "JWCTableViewCellData.h"

@interface JWCNoReuseTableView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionCell *> *data;

@end

@implementation JWCNoReuseTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if ((self = [super initWithFrame:frame style:style])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
}

#pragma mark tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) section];
    return sectionData.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) indexPath.section];
    JWCTableViewCell *cell = sectionData.children[(NSUInteger) indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
    JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) indexPath.section];
    JWCTableViewCell *cell = sectionData.children[(NSUInteger) indexPath.row];
    if (cell.data.operation) {
        cell.data.operation(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) indexPath.section];
    return [sectionData cellHeightWithIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.data[(NSUInteger) section].sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.data[(NSUInteger) section].sectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.data[(NSUInteger) section].sectionHeaderHeight <= 0.1) {
        return nil;
    }
    
    return self.data[(NSUInteger) section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.data[(NSUInteger) section].footerView;
}

- (void)reloadData:(NSArray<JWCTableViewSectionCell *> *)data {
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:data];
    [self reloadData];
}

- (void)appendData:(NSArray<JWCTableViewCell *> *)data toSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren addObjectsFromArray:data];
        sectionData.children = [sectionChildren copy];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeSection:(NSInteger)section {
    if (self.data.count > section) {
        [self.data removeObjectAtIndex:(NSUInteger) section];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeData:(NSArray<JWCTableViewCell *> *)data fromSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren removeObjectsInArray:data];
        sectionData.children = [sectionChildren copy];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionCell *> *)moreData {
    [self.data addObjectsFromArray:moreData];
    [self reloadData];
}

- (NSMutableArray<JWCTableViewSectionCell *> *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
