//
//  KLCityDataTool.h
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class KLCity, KLOrder, KLCategory;
@interface KLMetaDataTool : NSObject
singleton_interface(KLMetaDataTool)

// 所有的城市
@property (nonatomic, strong, readonly) NSDictionary *totalCities;
// 所有的城市组数据
@property (nonatomic, strong, readonly) NSArray *totalCitySections;

// 所有的分类数据
@property (nonatomic, strong, readonly) NSArray *totalCategories;
// 所有的排序数据
@property (nonatomic, strong, readonly) NSArray *totalOrders;

- (KLOrder *)orderWithName:(NSString *)name;

// 当前选中的城市
@property (nonatomic, strong) KLCity *currentCity;
// 当前选中的类别
@property (nonatomic, strong) NSString *currentSubcategorie;
// 当前选中的区域
@property (nonatomic, strong) NSString *currentDistrict;
// 当前选中的排序
@property (nonatomic, strong) KLOrder *currentOrder;
@property (nonatomic, strong) KLCategory *currentCategory;

@end
