//
//  KLBuyDock.h
//  KnowingLife
//
//  Created by tanyang on 14/11/4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLLineLabel;
@interface KLBuyDock : UIView
// 价格
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (weak, nonatomic) IBOutlet UILabel *yuanLable;
// 原价
@property (weak, nonatomic) IBOutlet KLLineLabel *originalPriceLable;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

+ (instancetype)buyDockWithNowPrice:(NSString *)nowPrice originalPrice:(NSString *)originalPrice clickedHander:(void(^)(void))clicked;

@end
