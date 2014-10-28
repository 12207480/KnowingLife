//
//  KLWeatherHttpTool.m
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLWeatherHttpTool.h"
#import "KLHttpTool.h"
#define baidukey @"Q0qFFiynCewS75iBPQ9TkChH"
@implementation KLWeatherHttpTool


+ (void)getWeatherDataWithCity:(NSString *)city success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = city;
    params[@"ak"] = baidukey;
    params[@"output"] = @"json";
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

@end
