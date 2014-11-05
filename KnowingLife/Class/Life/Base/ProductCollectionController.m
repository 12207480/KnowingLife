//
//  ProductCollectionController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "ProductCollectionController.h"
#import "ProductItem.h"
#import "ProductSection.h"
#import "ProductCell.h"
#import "HeaderViewCell.h"
#import "CSStickyHeaderFlowLayout.h"
#import "TopHeaderViewCell.h"
#import "UIBarButtonItem+WB.h"
#import "KLSearchHttpTool.h"
#import "KLWeatherInfo.h"
#import "MJExtension.h"
#import "CitysViewController.h"
#import "WeatherViewController.h"
#import "IDCardsSearchController.h"
#import "PhoneSearchController.h"
#import "CurrencySearchController.h"
#import "DreamAnalysisController.h"
#import "IPSearchController.h"
#import "FangDaiViewController.h"
#import "RevenueController.h"
#import "KLLotteryViewController.h"
#import "KLLocationTool.h"

@interface ProductCollectionController ()<CitysViewdelegate>
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, weak) TopHeaderViewCell *weatherCell;
@end

@implementation ProductCollectionController

static NSString * const reuseIdentifier = @"ProductCell";
static NSString * const reuseHeaderIdentifier = @"HeaderViewCell";
static NSString * const reuseTopHeaderIdentifier = @"TopHeaderViewCell";

- (NSMutableArray *)sections
{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 注册cell
    [self registerCells];
    
    self.collectionView.backgroundColor = KLCollectionBkgCollor;//KLColor(231, 231, 231);
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ios7_top_navigation_locationicon" target:self action:@selector(selectCity)];
    
    // 定位
    [KLLocationTool sharedKLLocationTool];
    
    // 监听定位城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationCity) name:LocationCityNote object:nil];
    
    // 读取当前城市
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *city = [defaults objectForKey:@"currentCity"];
    if (city == nil) {
        city = @"深圳";
    }
    // 加载天气
    [self loadWeatherData:city];
    
    // Do any additional setup after loading the view.
    // 添加第一组
    [self addSectionSearch];
    
    // 添加第二组
    [self addSectionCaculate];
    
    // 彩票开奖
    [self addSectionTicket];
    
}

#pragma mark 注册Cells
- (void)registerCells
{
    // 注册内容cell
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    // 注册headercell
    nib = [UINib nibWithNibName:reuseHeaderIdentifier bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    
    // 注册TopheaderCell
    nib = [UINib nibWithNibName:reuseTopHeaderIdentifier bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:reuseTopHeaderIdentifier];
}

#pragma mark 收到定位城市通知
- (void)locationCity
{
    if ([KLLocationTool sharedKLLocationTool].locationCity.city) {
        [self loadWeatherData:[KLLocationTool sharedKLLocationTool].locationCity.city];
    }
}

#pragma mark 获取城市天气数据
- (void)loadWeatherData:(NSString *)city
{
    [KLSearchHttpTool getWeatherDataWithCity:city success:^(id json) {
        
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
        self.weatherCell.weatherInfo = _weatherInfo;
    } failure:^(NSError *error) {
        NSLog(@"加载天气失败!");
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:city forKey:@"currentCity"];
}

#pragma mark 选择城市
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

- (void)addSectionSearch
{
    // 添加section
    ProductSection *section = [ProductSection section];
    section.headerTitle = @"生活查询";
    
    // 添加items
    ProductItem *IDCardItem = [ProductItem itemWithTitle:@"身份证查询" icon:@"s3" destVcClass:[IDCardsSearchController class]];
    ProductItem *phoneItem = [ProductItem itemWithTitle:@"手机归属地" icon:@"a1" destVcClass:[PhoneSearchController class]];
    ProductItem *currencyItem = [ProductItem itemWithTitle:@"货币汇率" icon:@"a7" destVcClass:[CurrencySearchController class]];
    ProductItem *dreamItem = [ProductItem itemWithTitle:@"周公解梦" icon:@"a6" destVcClass:[DreamAnalysisController class]];
    
    ProductItem *IPItem = [ProductItem itemWithTitle:@"IP地址查询" icon:@"a5" destVcClass:[IPSearchController class]];
    
    [section.items addObjectsFromArray:@[IDCardItem,phoneItem,currencyItem,dreamItem,IPItem]];
    [self.sections addObject:section];
}

- (void)addSectionCaculate
{
    ProductSection *section = [ProductSection section];
    section.headerTitle = @"贷款计算";
    ProductItem *item0 = [ProductItem itemWithTitle:@"房贷计算" icon:@"a8" destVcClass:[FangDaiViewController class]];
    
    ProductItem *item1 = [ProductItem itemWithTitle:@"税收计算" icon:@"s7" destVcClass:[RevenueController class]];
    
    [section.items addObjectsFromArray:@[item0,item1]];
    [self.sections addObject:section];
}

- (void)addSectionTicket
{
    ProductSection *section = [ProductSection section];
    section.headerTitle = @"彩票开奖";
    ProductItem *item0 = [ProductItem itemWithTitle:@"网易彩票" icon:@"a2" destVcClass:[KLLotteryViewController class]];
    
    [section.items addObjectsFromArray:@[item0]];
    [self.sections addObject:section];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ProductSection *productSection = self.sections[section];
    return productSection.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获得cell
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 传递模型
    ProductSection *productSection = self.sections[indexPath.section];
    cell.item = productSection.items[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ProductSection *section = self.sections[indexPath.section];
        
        HeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        cell.titleLable.text = section.headerTitle;
        
        return cell;
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        TopHeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseTopHeaderIdentifier forIndexPath:indexPath];
        // 添加点击事件
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWeatherView)]];
        self.weatherCell = cell;
        if (self.weatherInfo == nil) {
        } else {
            cell.weatherInfo = self.weatherInfo;
        }
        return cell;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%@",indexPath);
    ProductSection *section = self.sections[indexPath.section];
    ProductItem *item = section.items[indexPath.row];
    
    // 运行block
    if (item.selectionHandler) {
        item.selectionHandler();
    }
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc]init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 点击WeatherView
- (void)tapWeatherView
{
    WeatherViewController *weatherCtr = [[WeatherViewController alloc]init];
    weatherCtr.weatherInfo = self.weatherInfo;
    [self.navigationController pushViewController:weatherCtr animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
