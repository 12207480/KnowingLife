//
//  KLTGHttpTool.h
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class KLDeal;
// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

// deal里面装的都是模型数据
typedef void (^DealSuccessBlock)(KLDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);


typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface KLTGHttpTool : NSObject
singleton_interface(KLTGHttpTool)

// 基本封装
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params block:(RequestBlock)block;

// 获得第page页的团购数据
- (void)dealsWithPage:(int)page district:(NSString *)district category:(NSString *)category orderIndext:(NSInteger)orderIndext success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

// 获得指定团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

// 获得周边团购数据
- (void)dealsWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
