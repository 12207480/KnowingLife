//
//  KLDealViewCell.h
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLDeal, KLLineLabel;
@interface KLDealViewCell : UITableViewCell
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
// 细节
@property (weak, nonatomic) IBOutlet UILabel *descLable;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
// 销售
@property (weak, nonatomic) IBOutlet UILabel *buycountLable;
@property (weak, nonatomic) IBOutlet UILabel *yuanLable;
// 原价
@property (weak, nonatomic) IBOutlet KLLineLabel *originalPriceLable;

// 数据
@property (nonatomic, strong) KLDeal *deal;
@end
