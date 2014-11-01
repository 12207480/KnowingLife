//
//  KLCityDataTool.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLCityDataTool.h"
#import "KLCitySection.h"
#import "KLCity.h"
#import "MJExtension.h"

@interface KLCityDataTool()
{
    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    
    KLCitySection *_visitedSection; // 最近访问的城市组数组
}
@end

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]
@implementation KLCityDataTool
singleton_implementation(KLCityDataTool)

- (id)init
{
    if (self = [super init]) {
        // 初始化项目中的所有元数据
        
        // 1.初始化城市数据
        [self loadCityData];
        
    }
    return self;
}

- (void)loadCityData
{
    // 存放所有的城市
    _totalCities = [NSMutableDictionary dictionary];
    // 存放所有的城市组
    NSMutableArray *tempSections = [NSMutableArray array];
    
    // 1.添加热门城市组
    KLCitySection *hotSection = [[KLCitySection alloc] init];
    hotSection.name = @"热门";
    hotSection.cities = [NSMutableArray array];
    [tempSections addObject:hotSection];
    
    // 2.添加A-Z组
    // 加载plist数据
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    for (NSDictionary *azDict in azArray) {
        // 创建城市组
        KLCitySection *section = [KLCitySection objectWithKeyValues:azDict];
        [tempSections addObject:section];
        
        // 遍历这组的所有城市
        for (KLCity *city in section.cities) {
            if (city.hot) { // 添加热门城市
                [hotSection.cities addObject:city];
            }
            
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    // 3.从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 4.添加最近访问城市组
    KLCitySection *visitedSection = [[KLCitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        KLCity *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedCityNames.count) {
        [tempSections insertObject:visitedSection atIndex:0];
    }
    
    _totalCitySections = tempSections;
}

- (void)setCurrentCity:(KLCity *)currentCity
{
    _currentCity = currentCity;
    
    // 修改当前选中的区域
    //_currentDistrict = kAllDistrict;
    
    // 1.移除之前的城市名
    [_visitedCityNames removeObject:currentCity.name];
    
    // 2.将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    // 3.将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    // 肯定添加“最近访问城市”
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

@end
