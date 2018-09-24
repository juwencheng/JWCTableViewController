//
//  JWCCellItem.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWCTableViewController/JWCTableViewCellData.h>

typedef enum : NSUInteger {
    JWCSettingCellItemStyleNone,
    JWCSettingCellItemStyleArraw,
    JWCSettingCellItemStyleSwitch,
} JWCSettingCellItemStyle;

@interface JWCSettingCellItem : JWCTableViewCellData

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, assign) Class willShowClass;
@property(nonatomic, assign) JWCSettingCellItemStyle style;


@end
