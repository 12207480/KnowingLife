//
//  SimpleWeatherView.m
//  KnowingLife
//
//  Created by tanyang on 14/10/28.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "SimpleWeatherView.h"

@implementation SimpleWeatherView

+ (instancetype)createView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleWeatherView" owner:self options:nil];
    SimpleWeatherView *weatherView = [nib objectAtIndex:0];
    return weatherView;
    
    // 简单写法
    // return [[NSBundle mainBundle] loadNibNamed:@"SimpleWeatherView" owner:self options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
