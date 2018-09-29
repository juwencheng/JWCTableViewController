//
//  JWCSettingCell.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewCell.h"
//#import "JWCTableViewCellData.h"

@interface JWCTableViewCell ()
@property(nonatomic, strong, readwrite) id <JWCTableViewCellDataProtocol> data;
@end

@implementation JWCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

}

- (void)configureData:(id <JWCTableViewCellDataProtocol>)cellData {
    _data = cellData;
}

- (id <JWCTableViewCellDataProtocol>)data {
    return _data;
}
@end
