//
//  KLCitiesViewController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLCitiesViewController.h"
#import "KLCityDataTool.h"
#import "KLCitySection.h"
#import "KLCity.h"

@interface KLCitiesViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *citySections;
@end

#define kSearchH 36
@implementation KLCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 添加搜索框
    [self addSearchBar];
    
    // 添加tableView
    [self addTableView];
    
    // 加载数据
    [self loadCitiesData];
}

- (void)addSearchBar
{
    // 添加seachBar
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchH);
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入城市名或拼音";
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat h = self.view.frame.size.height - kSearchH;
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, h);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;

}

- (void)loadCitiesData
{
    self.citySections = [NSMutableArray array];
    
    [self.citySections addObjectsFromArray:[KLCityDataTool sharedKLCityDataTool].totalCitySections];
    
}

#pragma mark - 搜索框代理方法
#pragma mark 监听搜索框的文字改变
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

#pragma mark - tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.citySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    KLCitySection *citySection = self.citySections[section];
    return citySection.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    KLCitySection *citySection = self.citySections[indexPath.section];
    KLCity *city = citySection.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    KLCitySection *sectionCity = self.citySections[section];
    return sectionCity.name;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.citySections valueForKeyPath:@"name"];
}

#pragma mark - tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLCitySection *section = self.citySections[indexPath.section];
    KLCity *city = section.cities[indexPath.row];
    
    [KLCityDataTool sharedKLCityDataTool].currentCity = city;
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
