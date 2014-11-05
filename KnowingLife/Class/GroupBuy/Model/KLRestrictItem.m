//
//  KLRestrictItem.m
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLRestrictItem.h"
#import "KLDeal.h"
#import "KLRestriction.h"
#import "NSDate+WB.h"

@implementation KLRestrictItem
- (void)setDeal:(KLDeal *)deal
{
    self.buyCount = [NSString stringWithFormat:@"已销售%d",deal.purchase_count];
    
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
    // 2013-11-17
    NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
    // 2013-11-18 00:00:00
    dealline = [dealline dateByAddingTimeInterval:24 * 3600];
    // 2013-11-17 10:50
    NSDate *now = [NSDate date];
    
    NSDateComponents *cmps = [now compare:dealline];
    
    self.LeaveTime = [NSString stringWithFormat:@"%ld天%ld小时%ld分",(long)cmps.day,(long)cmps.hour,(long)cmps.minute];
    
    KLRestriction *restriction = deal.restrictions;
    
    self.isOutTimeRefund = restriction.is_refundable;
    
    self.isAnyTimeRefund = restriction.is_refundable;
    
    
}
@end
