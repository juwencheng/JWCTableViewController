//
//  JWCNoReuseViewController.m
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import "JWCNoReuseViewController.h"
#import "JWCTableViewSectionCell.h"
#import "JWCTableViewCell.h"
#import "JWCTableViewCellData.h"

@interface JWCNoReuseViewController ()<JWCTableViewControllerDelegate>
@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionCell *> *data;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;
@end

@implementation JWCNoReuseViewController

+ (instancetype)tableViewControllerWithStyle:(UITableViewStyle)style {
    return [[self alloc] initWithStyle:style];
}

- (instancetype) initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jwc_setupSubViews];
}

- (void)jwc_setupSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:self.tableView];
    self.delegate = self;
    [self addTableViewConstraints];
    [self configureTableView];
    [self assignTableViewDelegateAndDataSource];
}

- (void)addTableViewConstraints {
    if ([self.delegate respondsToSelector:@selector(customizeTableViewConstraints:)]) {
        [self.delegate customizeTableViewConstraints:self.tableView];
    }else {
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }
}

- (void)assignTableViewDelegateAndDataSource {
    if ([self.delegate respondsToSelector:@selector(customizeTableViewDelegateAndDataSource:)]) {
        [self.delegate customizeTableViewDelegateAndDataSource:self.tableView];
    }else {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
}

- (void)configureTableView {
    if ([self.delegate respondsToSelector:@selector(customizeTableViewStyle:)]) {
        [self.delegate customizeTableViewStyle:self.tableView];
    }else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [self.tableView reloadData];
}

- (void)appendData:(NSArray<JWCTableViewCell *> *)data toSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) section];
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

- (void)removeData:(NSArray<JWCTableViewCell *> *)data fromSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionCell *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren removeObjectsInArray:data];
        sectionData.children = [sectionChildren copy];
        [self.tableView reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionCell *> *)moreData {
    [self.data addObjectsFromArray:moreData];
    [self.tableView reloadData];
}

- (NSMutableArray<JWCTableViewSectionCell *> *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}


@end
