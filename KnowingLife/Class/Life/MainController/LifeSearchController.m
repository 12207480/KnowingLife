//
//  LifeSearchController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "LifeSearchController.h"
#import "KLWeatherView.h"
#import "KLWeatherHttpTool.h"
#import "KLWeatherInfo.h"
#import "MJExtension.h"
#import "UIBarButtonItem+WB.h"
#import "CitysViewController.h"
#import "WeatherViewController.h"

@interface LifeSearchController ()<CitysViewdelegate>
@property (nonatomic ,weak) KLWeatherView *weatherView;

@end

@implementation LifeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ios7_top_navigation_locationicon" target:self action:@selector(selectCity)];
    // 创建weatherview
    [self setupWeatherView];
    
    // 读取当前城市
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *city = [defaults objectForKey:@"currentCity"];
    if (city == nil) {
        city = @"深圳";
    }
    // 加载天气
    [self loadWeatherData:city];
}

- (void)loadWeatherData:(NSString *)city
{
    [KLWeatherHttpTool getWeatherDataWithCity:city success:^(id json) {
        
        NSArray *weatherInfo = [KLWeatherInfo objectArrayWithKeyValuesArray:json[@"results"]];
        //NSLog(@"%@",weatherInfo);
        _weatherInfo = weatherInfo[0];
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        _weatherInfo.date = currentDateStr;
        
        // 设置weatherView
        self.weatherView.weatherInfo = _weatherInfo;
    } failure:^(NSError *error) {
        NSLog(@"加载天气失败!");
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:@"currentCity"];
}

- (void)selectCity
{
    //NSLog(@"selectCity");
    CitysViewController *citys = [[CitysViewController alloc]initWithStyle:UITableViewStylePlain];
    citys.citysDelegate = self;
    [self.navigationController pushViewController:citys animated:YES];
    
}

- (void)citysViewDidSetectedCity:(NSString *)city
{
    //NSLog(@"%@",city);
    // 加载天气
    [self loadWeatherData:city];
}

- (void)setupWeatherView
{
    // 创建weatherview
    KLWeatherView *weatherView = [KLWeatherView createView];
    weatherView.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
    [self.view addSubview:weatherView];
    self.weatherView = weatherView;
    
    self.weatherView.userInteractionEnabled = YES;
    // 添加点击事件
    [self.weatherView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWeatherView)]];
    
    
}

// 点击WeatherView
- (void)tapWeatherView
{
    WeatherViewController *weatherCtr = [[WeatherViewController alloc]init];
    weatherCtr.weatherInfo = self.weatherInfo;
    [self.navigationController pushViewController:weatherCtr animated:YES];
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
