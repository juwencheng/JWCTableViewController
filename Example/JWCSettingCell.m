//
//  JWCSettingCell.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCSettingCell.h"
#import "JWCSettingCellItem.h"

@implementation JWCSettingCell {
    UISwitch *_switch;
}

- (void)configureData:(JWCTableViewCellData *)cellData {
    JWCSettingCellItem *data = (JWCSettingCellItem *) cellData;
    [super configureData:data];
    if (data.icon) {
        self.imageView.image = [UIImage imageNamed:data.icon];
    }
    self.textLabel.text = data.title;
    if (data.style == JWCSettingCellItemStyleArraw) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (data.style == JWCSettingCellItemStyleNone) {
        self.accessoryType = UITableViewCellAccessoryNone;
    } else if (data.style == JWCSettingCellItemStyleSwitch) {
        if (!_switch) {
            _switch = [[UISwitch alloc] init];
        }
        self.accessoryView = _switch;
    }
}

@end
