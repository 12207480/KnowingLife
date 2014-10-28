//
//  KLWeatherView.m
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLWeatherView.h"
#import "KLWeatherInfo.h"

@implementation KLWeatherView

+ (KLWeatherView *)createView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"KLWeatherView" owner:self options:nil];
    KLWeatherView *weatherView = [nib objectAtIndex:0];
    return weatherView;
}

- (void)setWeatherInfo:(KLWeatherInfo *)weatherInfo
{
    KLWeatherData *weatherData = weatherInfo.weather_data[0];
    
    self.cityLable.text = weatherInfo.currentCity;
    self.dateLabel.text = weatherInfo.date;
    self.windLable.text = weatherData.wind;
    self.temperatureLable.text = weatherData.temperature;
    self.PM25.text = [NSString stringWithFormat:@"PM25: %@",weatherInfo.pm25];
    self.weatherImageView.image = [UIImage imageWithName:weatherData.weather];
    self.weatherLable.text = weatherData.weather;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
