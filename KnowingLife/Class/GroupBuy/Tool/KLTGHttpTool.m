//
//  KLTGHttpTool.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLTGHttpTool.h"
#import "DPAPI.h"
#import "KLMetaDataTool.h"
#import "KLCity.h"
#import "KLOrder.h"
#import "KLDeal.h"
#import "KLCategory.h"
#import "MJExtension.h"

typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface KLTGHttpTool() <DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}
@end

@implementation KLTGHttpTool
singleton_implementation(KLTGHttpTool)

- (id)init
{
    if (self = [super init]) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获得大批量团购
- (void)getDealsWithParams:(NSMutableDictionary *)params success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {
        if (errorObj) { // 请求失败
            if (error) {
                error(errorObj);
            }
        } else if (success) { // 请求成功
            if ([result[@"status"] isEqualToString:@"OK"]) {
                NSArray *array = result[@"deals"];
                NSMutableArray *deals = [NSMutableArray array];
                
                for (NSDictionary *dict in array) {
                    KLDeal *deal = [KLDeal objectWithKeyValues:dict];
                    deal.desc = [dict objectForKey:@"description"];
                    [deals addObject:deal];
                }
                
                success(deals, [result[@"total_count"] intValue]);
            } else {
                if (error) {
                    error(errorObj);
                }
            }
        }
    }];
}

#pragma mark 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(16) forKey:@"limit"];
    // 1.1.添加城市参数
    NSString *city = [KLMetaDataTool sharedKLMetaDataTool].currentCity.name;
    if (city) {
        [params setObject:city forKey:@"city"];
    } else {
        [params setObject:@"全国" forKey:@"city"];
    }
    
    // 1.2.添加区域参数
    NSString *district = [KLMetaDataTool sharedKLMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:@"全城"]) {
        [params setObject:district forKey:@"region"];
    }
    
    // 1.3.添加分类参数
    NSString *category = [KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie;
    if (!category ||(category && [category isEqualToString:@"全部"])) {
        category = [KLMetaDataTool sharedKLMetaDataTool].currentCategory.category_name;
        [params setObject:category forKey:@"category"];
    } else if ([KLMetaDataTool sharedKLMetaDataTool].currentCategory.category_name) {
        [params setObject:category forKey:@"category"];
    }
    
    // 1.4.添加排序参数
    KLOrder *order = [KLMetaDataTool sharedKLMetaDataTool].currentOrder;
    if (order == nil) {
        [params setObject:@(1) forKey:@"sort"];
    } else {
        [params setObject:@(order.index) forKey:@"sort"];
    }

    
    // 1.5.添加页码参数
    [params setObject:@(page) forKey:@"page"];
    
    // 2.发送请求
    [self getDealsWithParams:params success:success error:error];
}

#pragma mark 封装了点评的任何请求
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    /*
     1.请求成功会调用self的下面方法
     - (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
     
     2.请求失败会调用self的下面方法
     - (void)request:(DPRequest *)request didFailWithError:(NSError *)error
     */
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    // 一次请求 对应 一个block
    // 不直接用request的原因是：字典的key必须遵守NSCopying协议
    // request.description返回的是一个格式为“<类名：内存地址>”的字符串，能代表唯一的一个request对象
    [_blocks setObject:block forKey:request.description];
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
    [_blocks removeObjectForKey:request.description];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
    [_blocks removeObjectForKey:request.description];
}


@end
