//
//  KLDealViewCell.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLDealViewCell.h"
#import "KLDeal.h"
#import "UIImageView+WebCache.h"
#import "KLLineLabel.h"

@implementation KLDealViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDeal:(KLDeal *)deal
{
    _deal = deal;
    
    // 标题
    self.titleLable.text = deal.title;
    
    // 描述
    self.descLable.text = deal.desc;
    
    // 图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    // 价格
    self.priceLable.text = deal.current_price_text;
    
    // 原价
    self.originalPriceLable.text = [NSString stringWithFormat:@"%@元",deal.list_price_text];
    
    // 销售
    self.buycountLable.text = [NSString stringWithFormat:@"已销售:%d",deal.purchase_count];
    
}

- (void)layoutSubviews
{
    CGSize PriceSize = [self.priceLable.text sizeWithAttributes:@{NSFontAttributeName: self.priceLable.font}];
    CGRect PriceRect = self.priceLable.frame;
    PriceRect.size = PriceSize;
    self.priceLable.frame = PriceRect;
    
    CGRect YuanRect = self.yuanLable.frame;
    YuanRect.origin.x = CGRectGetMaxX(PriceRect);
    YuanRect.origin.y = PriceRect.origin.y;
    self.yuanLable.frame = YuanRect;
    
    CGRect originalPriceRect = self.originalPriceLable.frame;
    originalPriceRect.origin.x = CGRectGetMaxX(YuanRect) + 2;
    self.originalPriceLable.frame = originalPriceRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
