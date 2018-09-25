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
#import "JWCNoReuseTableView.h"

@interface JWCNoReuseViewController ()<JWCTableViewControllerDelegate>

@property(nonatomic, strong, readwrite) JWCNoReuseTableView *tableView;
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
    _tableView = [[JWCNoReuseTableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:self.tableView];
    self.delegate = self;
    [self addTableViewConstraints];
    [self configureTableView];
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

- (void)configureTableView {
    if ([self.delegate respondsToSelector:@selector(customizeTableViewStyle:)]) {
        [self.delegate customizeTableViewStyle:self.tableView];
    }else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)reloadData:(NSArray<JWCTableViewSectionCell *> *)data {
    [self.tableView reloadData:data];
}

- (void)appendData:(NSArray<JWCTableViewCell *> *)data toSection:(NSInteger)section {
    [self.tableView appendData:data toSection:section];
}

- (void)removeSection:(NSInteger)section {
    [self.tableView removeSection:section];
}

- (void)removeData:(NSArray<JWCTableViewCell *> *)data fromSection:(NSInteger)section {
    [self.tableView removeData:data fromSection:section];
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionCell *> *)moreData {
    [self.tableView loadMoreData:moreData];
}

@end
