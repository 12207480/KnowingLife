//
//  KLWeatherHttpTool.m
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLSearchHttpTool.h"
#import "KLHttpTool.h"
#define baidukey @"Q0qFFiynCewS75iBPQ9TkChH"
@implementation KLSearchHttpTool


+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = city;
    params[@"ak"] = baidukey;
    params[@"output"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://api.map.baidu.com/telematics/v3/weather?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
}

+ (void)getIDCardData:(NSString *)IDcard success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"idnumber"] = IDcard;
    params[@"format"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://api.uihoo.com/idcard/idcard.http.php?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
}

+ (void)getPhoneData:(NSString *)phone success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = phone;
    params[@"format"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://api.uihoo.com/mobile/mobile.http.php?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];

}

+ (void)getCurrencyDataWithFrom:(NSString *)from to:(NSString *)to success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"from"] = from;
    params[@"to"] = to;
    params[@"format"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://api.uihoo.com/currency/currency.http.php?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];

}

+ (void)getDreamDataWithKey:(NSString *)dreamKey success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = dreamKey;
    params[@"format"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://api.uihoo.com/dream/dream.http.php?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
}

+ (void)getIPDataWithIP:(NSString *)IP success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ip"] = IP;
    params[@"f"] = @"json";
    
    // 发送请求
    [KLHttpTool getWithURL:@"http://ipapi.sinaapp.com/api.php?" params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"%@",error);
        }
    }];
}

@end
