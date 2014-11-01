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

// 获得手机号数据
+ (void)getPhoneData:(NSString *)phone success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

// 获得货币汇率数据 from 兑换货币  to 换入货币
+ (void)getCurrencyDataWithFrom:(NSString *)from to:(NSString *)to success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

// 获得梦境信息
+ (void)getDreamDataWithKey:(NSString *)dreamKey success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

// 获得IP地址数据
+ (void)getIPDataWithIP:(NSString *)IP success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end