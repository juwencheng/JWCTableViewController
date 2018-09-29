//
//  JWCSectionGroup.h
//  TableView封装
//
//  Created by Ju on 14-8-20.
//  Copyright (c) 2014年 dono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWCTableViewProtocol.h"

@class JWCTableViewCellData;

@interface JWCTableViewSectionData : NSObject <JWCTableViewSectionDataProtocol>

+ (instancetype)sectionDataWithHeader:(NSString *)header footer:(NSString *)footer children:(NSArray<JWCTableViewCellData *> *)children;

+ (instancetype)sectionDataWithChildren:(NSArray<JWCTableViewCellData *> *)children;

@end
