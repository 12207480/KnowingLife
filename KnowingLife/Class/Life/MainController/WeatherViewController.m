//
//  WeatherViewController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WeatherViewController.h"
#import "SimpleWeatherView.h"
#import "KLWeatherInfo.h"
#import "UIBarButtonItem+WB.h"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *weakLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;

@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UIImageView *wetherImageView;

@property (nonatomic, strong) NSArray *simapleweathers;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"天气预报";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"ios7_top_navigation_back" target:self action:@selector(Canccel)];
    
    // 添加simapleweather
    [self setupSimapleWeathers];
    
    // 设置天气数据
    [self setupWeatherInfo];
    
}

- (void)Canccel
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setupSimapleWeathers
{
    
    CGFloat simapleWeatherX = 0;
    CGFloat simapleX = 12;
    CGFloat simapleWeatherY = CGRectGetMaxY(self.detailLable.frame);
    if (is4Inch) {
        simapleWeatherY +=10;
    }
    CGFloat simapleWeatherH = 200;
    CGFloat simapleWeatherW = (self.view.frame.size.width - 2 * simapleX)/3;
    
    NSMutableArray *simapleWeathers = [NSMutableArray array];
    for (int i = 0; i < 3; ++i) {
        SimpleWeatherView *simapleWeather = [SimpleWeatherView createView];
        [self.view addSubview:simapleWeather];
        [simapleWeathers addObject:simapleWeather];
        
        simapleWeatherX = simapleX + simapleWeatherW * i;
        simapleWeather.frame = CGRectMake(simapleWeatherX, simapleWeatherY, simapleWeatherW, simapleWeatherH);
    }
    self.simapleweathers = simapleWeathers;
}

- (void)setupWeatherInfo
{
    KLWeatherData *weatherData = self.weatherInfo.weather_data[0];
    KLIndexDetail *detail = self.weatherInfo.index[0];
    
    self.cityLable.text = self.weatherInfo.currentCity;
    self.dateLable.text = self.weatherInfo.date;
    self.weakLable.text = [weatherData.date substringToIndex:3];
    self.temperatureLable.text = weatherData.temperature;
    NSString *weather = weatherData.weather;
    NSUInteger strLocation = [weather rangeOfString:@"转"].location;
    if (strLocation != NSNotFound) {
        weather = [weather substringToIndex:strLocation];
    }
    self.wetherImageView.image = [UIImage imageWithName:weather];
    self.windLable.text = weatherData.wind;
    self.weatherLable.text = weatherData.weather;
    self.detailLable.text = [NSString stringWithFormat:@"%@: %@",detail.tipt,detail.des];
    
    for (int i = 1; i < 4; ++i) {
        weatherData = self.weatherInfo.weather_data[i];
        SimpleWeatherView *simpleView = self.simapleweathers[i-1];
        simpleView.weekLable.text = weatherData.date;
        NSString *weather = weatherData.weather;
        NSUInteger strLocation = [weather rangeOfString:@"转"].location;
        if (strLocation != NSNotFound) {
            weather = [weather substringToIndex:strLocation];
        }
        simpleView.weatherImageView.image = [UIImage imageWithName:weather];
        simpleView.weatherLable.text = weatherData.weather;
        simpleView.windLable.text = weatherData.wind;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
