//
//  KLRestriction.h
//  KnowingLife
//
//  Created by tanyang on 14/11/4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLRestriction : NSObject
// 是否需要预约，0：不是，1：是
@property (nonatomic, assign) BOOL is_reservation_required;
// 是否支持随时退款，0：不是，1：是
@property (nonatomic, assign) BOOL is_refundable;
// （购买须知）附加信息
@property (nonatomic, copy) NSString * special_tips;
@end
