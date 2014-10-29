//
//  TopHeaderViewCell.h
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLWeatherInfo;
@interface TopHeaderViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *PM25;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;

@property (nonatomic, strong) KLWeatherInfo *weatherInfo;
@end
