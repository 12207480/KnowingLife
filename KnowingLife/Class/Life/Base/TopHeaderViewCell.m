//
//  TopHeaderViewCell.m
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "TopHeaderViewCell.h"
#import "KLWeatherInfo.h"

@implementation TopHeaderViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userInteractionEnabled = YES;
}

- (void)setWeatherInfo:(KLWeatherInfo *)weatherInfo
{
    KLWeatherData *weatherData = weatherInfo.weather_data[0];
    
    self.cityLabel.text = weatherInfo.currentCity;
    self.dateLable.text = weatherInfo.date;
    self.windLable.text = weatherData.wind;
    self.temperatureLable.text = weatherData.temperature;
    self.PM25.text = [NSString stringWithFormat:@"PM25: %@",weatherInfo.pm25];
    self.weatherImageView.image = [UIImage imageWithName:weatherData.weather];
    self.weatherLable.text = weatherData.weather;
}


@end
