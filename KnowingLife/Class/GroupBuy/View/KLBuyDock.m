//
//  KLBuyDock.m
//  KnowingLife
//
//  Created by tanyang on 14/11/4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLBuyDock.h"
#import "KLLineLabel.h"
#import "UIImage+WB.h"

@interface KLBuyDock ()
// 点击buy调用block
@property (nonatomic, copy) void (^clickedHander)(void);
@end
@implementation KLBuyDock

- (void)awakeFromNib
{
    // 设置按钮背景颜色
    [self.buyButton setBackgroundImage:[UIImage resizedImageWithName:@"bg_deal_purchaseButton"] forState:UIControlStateNormal];
    [self.buyButton setBackgroundImage:[UIImage resizedImageWithName:@"bg_deal_purchaseButton_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置透明度
    self.alpha = 0.8;
}

+ (instancetype)createBuyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"KLBuyDock" owner:self options:nil][0];
}

+ (instancetype)buyDockWithNowPrice:(NSString *)nowPrice originalPrice:(NSString *)originalPrice clickedHander:(void(^)(void))clicked
{
    // 创建
    KLBuyDock *buyDock = [KLBuyDock createBuyDock];
    
    // 赋值
    buyDock.priceLable.text = nowPrice;
    buyDock.originalPriceLable.text = [NSString stringWithFormat:@"%@元",originalPrice];
    
    [buyDock.buyButton addTarget:buyDock action:@selector(clickedBuy) forControlEvents:UIControlEventTouchUpInside];
    
    buyDock.clickedHander = clicked;
    return buyDock;
}

- (void)clickedBuy
{
    if (self.clickedHander) {
        self.clickedHander();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize PriceSize = [self.priceLable.text sizeWithAttributes:@{NSFontAttributeName: self.priceLable.font}];
    CGRect PriceRect = self.priceLable.frame;
    PriceRect.size = PriceSize;
    self.priceLable.frame = PriceRect;
    
    CGRect YuanRect = self.yuanLable.frame;
    YuanRect.origin.x = CGRectGetMaxX(PriceRect)+1;
    //YuanRect.origin.y = PriceRect.origin.y;
    self.yuanLable.frame = YuanRect;
    
    CGRect originalPriceRect = self.originalPriceLable.frame;
    originalPriceRect.origin.x = CGRectGetMaxX(YuanRect) ;
    self.originalPriceLable.frame = originalPriceRect;
}

@end
