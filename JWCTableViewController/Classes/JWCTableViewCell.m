//
//  JWCSettingCell.m
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import "JWCTableViewCell.h"
#import "JWCTableViewCellData.h"

@interface JWCTableViewCell ()
@property(nonatomic, strong, readwrite) JWCTableViewCellData *data;
@end

@implementation JWCTableViewCell

+ (instancetype)cellWithData:(JWCTableViewCellData *)data style:(UITableViewCellStyle)style {
    JWCTableViewCell *cell = [[self alloc] initWithStyle:style reuseIdentifier:nil];
    [cell configureData:data];
    return cell;
}

+ (instancetype)cellWithData:(JWCTableViewCellData *)data {
    return [self cellWithData:data style:UITableViewCellStyleDefault];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

}

- (void)configureData:(JWCTableViewCellData *)data {
    _data = data;
}

@end
