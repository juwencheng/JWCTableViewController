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
#import "UITableView+JWC.h"

@interface JWCTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong, readwrite) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionData *> *data;
@property(nonatomic, assign) UITableViewStyle tableViewStyle;
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_tableViewStyle];
    }
    return _tableView;
}

@end
