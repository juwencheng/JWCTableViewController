# JWCTableViewController

[![CI Status](https://img.shields.io/travis/Juwencheng/JWCTableViewController.svg?style=flat)](https://travis-ci.org/Juwencheng/JWCTableViewController)
[![Version](https://img.shields.io/cocoapods/v/JWCTableViewController.svg?style=flat)](https://cocoapods.org/pods/JWCTableViewController)
[![License](https://img.shields.io/cocoapods/l/JWCTableViewController.svg?style=flat)](https://cocoapods.org/pods/JWCTableViewController)
[![Platform](https://img.shields.io/cocoapods/p/JWCTableViewController.svg?style=flat)](https://cocoapods.org/pods/JWCTableViewController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage
### 类简介
|类名|作用|
|-|-|
|JWCTableViewController|含有UITableView的封装类，快速集成时，继承自此类。此类继承自UIViewController。|
|JWCTableViewCell|继承自UITableViewCell，集成时cell类集成自此类。|
|JWCTableViewCellData|数据模型，表示单项数据|
|JWCTableViewSectionData|数据模型，表示一个section的数据|

### 使用方法
1. 集成自 `JWCTableViewController`
2. 重写 `configureTableView` 方法。可以加入对 `tableView` 属性的配置。

```oc
- (void)configureTableView {
    [super configureTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [JWCTableViewCell registTableView:self.tableView reuseCellClass:[JWCSettingCell class] identifier:@"JWCSettingCell"];
}
```
3. 构造数据类型
实现时将`grouped` 和 `plain` 两种情况统一处理，因此至少需要一个 `JWCTableViewSectionData` 数据，在不需要 `section` 的时候也需要创建一个 `section`。
```oc
JWCSettingCellItem *item1 = [[JWCSettingCellItem alloc] init];
    item1.title = @"开奖号码推送";
    item1.style = JWCSettingCellItemStyleArraw;
    item1.operation = ^(NSIndexPath *indexPath) {
        NSLog(@"点击 开奖号码推送");
    };


    JWCSettingCellItem *item2 = [[JWCSettingCellItem alloc] init];
    item2.title = @"中奖动画";
    item2.style = JWCSettingCellItemStyleNone;

    JWCSettingCellItem *item3 = [[JWCSettingCellItem alloc] init];
    item3.title = @"购彩票定时提醒";
    item3.style = JWCSettingCellItemStyleSwitch;

    JWCSettingSectionData *group = [[JWCSettingSectionData alloc] init];
    group.children = @[item1, item2, item3];

    group.header = @"测试title";
    [self reloadData:@[group]];
```
注意 `JWCSettingCellItem` 是继承自 `JWCTableViewCellData`。

4. 刷新列表，提供了以下几个方法刷新列表数据

```oc
/**
 * 刷新列表数据
 * @param data
 */
- (void)reloadData:(NSArray<JWCTableViewSectionData *> *)data;

/**
 * 添加数据 data 到某个 section，并刷新
 * @param data NSArray<JWCTableViewCellData *>
 * @param section section number
 */
- (void)appendData:(NSArray<JWCTableViewCellData *> *)data toSection:(NSInteger)section;

/**
 * 追加更多数据并刷新列表
 * @param moreData
 */
- (void)loadMoreData:(NSArray<JWCTableViewSectionData *> *)moreData;

/**
 * 删除某个 section 并刷新列表
 * @param section
 */
- (void)removeSection:(NSInteger)section;

/**
 * 删除某个 section 的中的 data 数据，并刷新列表
 * @param data
 * @param section
 */
- (void)removeData:(NSArray <JWCTableViewCellData *> *)data fromSection:(NSInteger)section;
```


## Requirements

## Installation

JWCTableViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JWCTableViewController'
```

## Author

Juwencheng, juwenz@icloud.com

## License

JWCTableViewController is available under the MIT license. See the LICENSE file for more info.
