//
//  SimpleWeatherView.h
//  KnowingLife
//
//  Created by tanyang on 14/10/28.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleWeatherView : UIView
@property (weak, nonatomic) IBOutlet UILabel *weekLable;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
+ (instancetype)createView;
@end
