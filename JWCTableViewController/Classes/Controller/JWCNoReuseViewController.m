//
//  JWCNoReuseViewController.m
//  JWCTableViewController_Example
//
//  Created by 鞠汶成 on 2018/9/25.
//  Copyright © 2018年 Juwencheng. All rights reserved.
//

#import "JWCNoReuseViewController.h"
#import "JWCTableViewSectionCell.h"
#import "JWCTableViewNoReuseDataSourceProxy.h"

@interface JWCNoReuseViewController ()<UITableViewDataSource, UITableViewDelegate>

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
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:self.tableView];
    [self addTableViewConstraints];
    [self configureTableView];
}

- (void)addTableViewConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"tableView": self.tableView}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void)configureTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    [self.tableView setProxyDataSource: [JWCTableViewNoReuseDataSourceProxy proxyWithDataSource:self]];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
    }
    return _tableView;
}



@end
