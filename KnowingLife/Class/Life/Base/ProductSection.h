//
//  ProductSection.h
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSection : NSObject

// 头部标题
@property (nonatomic, copy) NSString *headerTitle;
// 尾部标题
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIView *footerView;

// 存放item的数组
@property (nonatomic, copy) NSMutableArray *items;

+(instancetype)section;

@end
