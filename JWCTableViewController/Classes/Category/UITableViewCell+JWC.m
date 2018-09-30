//
//  UITableViewCell+JWC.m
//  JWCTableView-Protocol
//
//  Created by 鞠汶成 on 2018/9/29.
//  Copyright © 2018年 鞠汶成. All rights reserved.
//

#import "UITableViewCell+JWC.h"

@implementation UITableViewCell (JWC)
@dynamic data;

+ (instancetype)cellWithData:(id <JWCTableViewCellDataProtocol>)data {
    return [self cellWithData:data style:UITableViewCellStyleDefault];
}

+ (instancetype)cellWithData:(id <JWCTableViewCellDataProtocol>)data style:(UITableViewCellStyle)style {
    UITableViewCell *cell = [[self alloc] initWithStyle:style reuseIdentifier:nil];
    [cell configureData:data];
    return cell;
}

- (void)configureData:(id <JWCTableViewCellDataProtocol>)cellData {

}

@end
