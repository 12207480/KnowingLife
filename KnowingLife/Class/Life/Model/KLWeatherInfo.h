//
//  KLWeatherInfo.h
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KLIndexDetail;
@class KLWeatherData;
@interface KLWeatherInfo : NSObject
// 当前城市
@property (nonatomic, copy) NSString *currentCity;
// 当前日期
@property (nonatomic, copy) NSString *date;
// pm25
@property (nonatomic, copy) NSString *pm25;
// 细节信息
@property (nonatomic, strong) NSArray *index;
// 天气详情
@property (nonatomic, strong) NSArray *weather_data;
@end

// 细节信息
@interface KLIndexDetail : NSObject
// 标题
@property (nonatomic, copy) NSString *title;
// 内容
@property (nonatomic, copy) NSString *zs;
// 指数
@property (nonatomic, copy) NSString *tipt;
// 细节
@property (nonatomic, copy) NSString *des;

@end

// 天气详情
@interface KLWeatherData : NSObject
// 日期
@property (nonatomic, copy) NSString *date;
// 天气
@property (nonatomic, copy) NSString *weather;
// 风力
@property (nonatomic, copy) NSString *wind;
// 温度
@property (nonatomic, copy) NSString *temperature;
@end




