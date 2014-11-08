//
//  KLTGRestrictCell.m
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLTGRestrictCell.h"

@interface KLTGRestrictCell ()
// 是否支持过期退款
@property (weak, nonatomic) IBOutlet UIButton *outTimeRefundBtn;
// 是否支持随时退款
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefundBtn;
// 销售
@property (weak, nonatomic) IBOutlet UIButton *buyCountBtn;
// 剩余时间
@property (weak, nonatomic) IBOutlet UIButton *LeaveTimeBtn;

@end
@implementation KLTGRestrictCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 70;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.outTimeRefundBtn.enabled = self.item.isOutTimeRefund;
    
    self.anyTimeRefundBtn.enabled = self.item.isOutTimeRefund;
    
    [self.buyCountBtn setTitle:self.item.buyCount forState:UIControlStateDisabled];
    
    [self.LeaveTimeBtn setTitle:self.item.LeaveTime forState:UIControlStateDisabled];
}

@end
