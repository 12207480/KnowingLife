//
//  KLCityDataTool.h
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class KLCity;
@interface KLCityDataTool : NSObject
singleton_interface(KLCityDataTool)

// 所有的城市
@property (nonatomic, strong, readonly) NSDictionary *totalCities;
// 所有的城市组数据
@property (nonatomic, strong, readonly) NSArray *totalCitySections;

// 当前选中的城市
@property (nonatomic, strong) KLCity *currentCity;

@end
