//
//  KLRestrictItem.h
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "RETableViewItem.h"

@class KLDeal;
@interface KLRestrictItem : RETableViewItem

@property (nonatomic, strong) KLDeal *deal;
// 是否支持过期退款
@property (nonatomic, assign) BOOL isOutTimeRefund;
// 是否支持随时退款
@property (nonatomic, assign) BOOL isAnyTimeRefund;
// 销售
@property (nonatomic, copy) NSString *buyCount;
// 剩余时间
@property (nonatomic, copy) NSString *LeaveTime;
@end
