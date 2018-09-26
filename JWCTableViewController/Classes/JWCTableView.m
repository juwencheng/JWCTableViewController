//
// Created by 鞠汶成 on 2018/9/25.
//

#import "JWCTableView.h"
#import "JWCTableViewSectionData.h"
#import "JWCTableViewCellData.h"
#import "JWCTableViewCell.h"

@interface JWCTableView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray<JWCTableViewSectionData *> *data;
@property(nonatomic, strong) NSMutableDictionary *dataClass2CellClass;

@end

@implementation JWCTableView

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

- (JWCTableViewCell *)dequeueCellWithClassStr:(NSString *)cellClassStr {
    return [self dequeueReusableCellWithIdentifier:cellClassStr];
}

- (void)registReuseCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    self.dataClass2CellClass[NSStringFromClass(cellDataClass)] = NSStringFromClass(cellClass);
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registReuseNibCellClass:(Class)cellClass withCellDataClass:(Class)cellDataClass {
    self.dataClass2CellClass[NSStringFromClass(cellDataClass)] = NSStringFromClass(cellClass);
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
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
    NSString *cellClassStr = self.dataClass2CellClass[NSStringFromClass([item class])];
    JWCTableViewCell *cell = [self dequeueCellWithClassStr:cellClassStr];
    [cell configureData:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
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
    [self reloadData];
}

- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionData *sectionData = self.data[(NSUInteger) section];
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

- (void)removeData:(NSArray<JWCTableViewCellData *> *)data fromSection:(NSInteger)section {
    if (self.data.count > section) {
        JWCTableViewSectionData *sectionData = self.data[(NSUInteger) section];
        NSMutableArray *sectionChildren = [sectionData.children mutableCopy];
        [sectionChildren removeObjectsInArray:data];
        sectionData.children = [sectionChildren copy];
        [self reloadData];
    } else {
        NSLog(@"section 大于当前 data 的长度");
    }
}

- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData {
    [self.data addObjectsFromArray:moreData];
    [self reloadData];
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
