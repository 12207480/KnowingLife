//
//  KLTGHttpTool.h
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface KLTGHttpTool : NSObject
singleton_interface(KLTGHttpTool)

// 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params block:(RequestBlock)block;
@end
