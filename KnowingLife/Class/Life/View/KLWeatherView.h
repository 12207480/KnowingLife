//
//  KLWeatherView.h
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLWeatherView;
@class KLWeatherInfo;
@interface KLWeatherView : UIView
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel * temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UILabel *PM25;

@property (nonatomic, strong) KLWeatherInfo *weatherInfo;
+ (KLWeatherView *)createView;
@end
