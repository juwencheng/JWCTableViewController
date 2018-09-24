//
//  JWCTableViewController.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewController.h"
#import "JWCTableViewCellData.h"

@interface JWCTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionData *> *data;
@property(nonatomic, strong) JWCTableViewConfigure *configure;
@property(nonatomic, strong) NSMutableDictionary *dataClass2CellClass;
@end

@implementation JWCTableViewController

+ (instancetype)tableViewControllerWithConfigure:(JWCTableViewConfigure *)configure {
    JWCTableViewController *controller = [[self alloc] initWithConfigure:configure];
    return controller;
}

- (instancetype)initWithConfigure:(JWCTableViewConfigure *)configure {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _configure = configure;
    }
    return self;
}

- (void)applyConfigure:(JWCTableViewConfigure *)configure {
    _configure = configure;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.configure.groupStyle ? UITableViewStyleGrouped : UITableViewStylePlain];
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:self.tableView];

    [self setupTableView];
    [self configureTableView];
}

- (void)setupTableView {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)configureTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)registReuserCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    self.dataClass2CellClass[NSStringFromClass(cellDataClass)] = NSStringFromClass(cellClass);
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (JWCTableViewCell *)dequeueCellWithClassStr:(NSString *)cellClassStr {
    return [self.tableView dequeueReusableCellWithIdentifier:cellClassStr];
}

#pragma mark tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JWCTableViewSectionData *sectionData = self.data[(NSUInteger) section];
    return sectionData.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWCTableViewSectionData *sectionData = self.data[(NSUInteger) indexPath.section];
    JWCTableViewCellData *item = sectionData.children[(NSUInteger) indexPath.row];
    NSString *cellClassStr = [self.dataClass2CellClass objectForKey:NSStringFromClass([item class])];
    JWCTableViewCell *cell = [self dequeueCellWithClassStr:cellClassStr];
    [cell configureData:item];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    JWCTableViewSectionData *sectionData = self.data[(NSUInteger) indexPath.section];
    JWCTableViewCellData *item = sectionData.children[(NSUInteger) indexPath.row];
    if (item.operation) {
        item.operation(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWCTableViewSectionData *sectionData = self.data[(NSUInteger) indexPath.section];
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

- (void)reloadData:(NSArray<JWCTableViewSectionData *> *)data {
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:data];
    [self.tableView reloadData];
}
/*
- (void)validSectionData:(NSArray<JWCTableViewSectionData *> *)sectionData {
    for (JWCTableViewSectionData *section in sectionData) {
        [self validData:section.children];
    }
}

- (void)validData:(NSArray<JWCTableViewCellData *> *)data {
    for (JWCTableViewCellData *element in data) {
        NSString *cellClassStr = self.dataClass2CellClass[NSStringFromClass([element class])];
        if (cellClassStr.length == 0) {
            @throw [NSException exceptionWithName:@"初始化错误" reason:@"请调用 registReuserCellClass:withCellDataClass 注册cell" userInfo:nil];
        }
        [element bindToCellClass: NSClassFromString(cellClassStr)];
    }
}*/

- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionData *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren addObjectsFromArray:data];
        sectionData.children = [sectionChildren copy];
        [self.tableView reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeSection:(NSInteger)section {
    if (self.data.count > section) {
        [self.data removeObjectAtIndex:(NSUInteger) section];
        [self.tableView reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)removeData:(NSArray<JWCTableViewCellData *> *)data fromSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionData *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren removeObjectsInArray:data];
        sectionData.children = [sectionChildren copy];
        [self.tableView reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData {
    [self.data addObjectsFromArray:moreData];
    [self.tableView reloadData];
}

- (NSMutableArray<JWCTableViewSectionData *> *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (NSMutableDictionary *)dataClass2CellClass {
    if (!_dataClass2CellClass) {
        _dataClass2CellClass = [NSMutableDictionary dictionary];
    }
    return _dataClass2CellClass;
}

@end

@implementation JWCTableViewConfigure
@end
