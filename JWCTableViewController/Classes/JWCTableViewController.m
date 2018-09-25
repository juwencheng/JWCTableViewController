//
//  JWCTableViewController.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewController.h"
#import "JWCTableViewCellData.h"
#import "JWCTableViewControllerDelegate.h"

@interface JWCTableViewController ()<JWCTableViewControllerDelegate>
@property(nonatomic, strong, readwrite) JWCTableView *tableView;
@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionData *> *data;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;
@property(nonatomic, strong) NSMutableDictionary *dataClass2CellClass;
@end

@implementation JWCTableViewController

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
    _tableView = [[JWCTableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:self.tableView];
    self.delegate = self;
    [self addTableViewConstraints];
    [self configureTableView];
    
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(registerReuseCells)]) {
        @throw [NSException exceptionWithName:@"JWCTableViewController初始化错误" reason:@"请实现registerReuseCells方法" userInfo:nil];
    }

    [self.delegate registerReuseCells];
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

#pragma mark tableview delegate & datasource

- (void)reloadData:(NSArray<JWCTableViewSectionData *> *)data {
    [self.tableView reloadData:data];
}

- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section {
    [self.tableView appendData:data toSection:section];
}

- (void)removeSection:(NSInteger)section {
    [self.tableView removeSection:section];
}

- (void)removeData:(NSArray<JWCTableViewCellData *> *)data fromSection:(NSInteger)section {
    [self.tableView removeData:data fromSection:section];
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData {
    [self.tableView loadMoreData:moreData];
}

@end
