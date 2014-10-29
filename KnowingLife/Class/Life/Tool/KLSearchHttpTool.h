//
//  KLWeatherHttpTool.h
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLSearchHttpTool : NSObject

// 获得天气数据
+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

// 获得身份证数据
+ (void)getIDCardData:(NSString *)IDcard success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end