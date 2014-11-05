//
//  KLGroupBuyController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLGroupBuyController.h"
#import "UIBarButtonItem+WB.h"
#import "KLCitiesViewController.h"
#import "KLMetaDataTool.h"
#import "KLCity.h"
#import "KLCItyDistrict.h"
#import "DOPDropDownMenu.h"
#import "KLCategory.h"
#import "KLOrder.h"
#import "ProductCell.h"
#import "ProductItem.h"
#import "ProductSection.h"
#import "HeaderViewCell.h"
#import "KLTGDealListController.h"
#import "KLMapViewController.h"
#import "KLLocationTool.h"

@interface KLGroupBuyController ()
@property (nonatomic, strong) NSMutableArray *sections;
@end

static NSString * const reuseIdentifier = @"ProductCell";
static NSString * const reuseHeaderIdentifier = @"HeaderViewCell";
@implementation KLGroupBuyController

- (id)init
{
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 设置水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置垂直间距
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(0, 60);
    if (self = [super initWithCollectionViewLayout:layout]) {
        
    }
    return self;
}

- (NSMutableArray *)sections
{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ios7_top_navigation_locationicon" target:self action:@selector(openMapView)];
    
    // 当前城市
     KLCity *currentcity = [KLMetaDataTool sharedKLMetaDataTool].currentCity;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:currentcity.name style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
    
    // 监听选择城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    // 监听定位城市改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationCity) name:LocationCityNote object:nil];
    
    [self locationCity];
    
    self.collectionView.backgroundColor = KLCollectionBkgCollor;
    // 注册内容cell
    [self registerCells];
    
    // 添加第一组 购物
    [self addSectionBuy];
    
    // 添加第二组 娱乐
    [self addSectionEntertainment];
}

#pragma mark 选择城市
- (void)selectCity
{
    KLCitiesViewController *cities = [[KLCitiesViewController alloc]init];
    cities.title = [NSString stringWithFormat:@"当前城市:%@",self.navigationItem.leftBarButtonItem.title];
    [self.navigationController pushViewController:cities animated:YES];
}

- (void)openMapView
{
    KLMapViewController *mapctrl = [[KLMapViewController alloc]init];
    [self.navigationController pushViewController:mapctrl animated:YES];
}

#pragma mark 城市改变
- (void)cityChange
{
    self.navigationItem.leftBarButtonItem.title = [KLMetaDataTool sharedKLMetaDataTool].currentCity.name;
}

- (void)locationCity
{
    NSString *cityName = [KLLocationTool sharedKLLocationTool].locationCity.city;
     //取出城市模型
    if (cityName) {
        // 更新城市
        KLCity *city = [KLMetaDataTool sharedKLMetaDataTool].totalCities[cityName];
        [KLMetaDataTool sharedKLMetaDataTool].currentCity = city;

    }
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
}

#pragma mark 添加购物组
- (void)addSectionBuy
{
    ProductSection *section = [ProductSection section];
    section.headerTitle = @"购物";
    
    for (int i = 0; i < 5; ++i) {
        KLCategory *category = [KLMetaDataTool sharedKLMetaDataTool].totalCategories[i];
        [section.items addObject:[ProductItem itemWithTitle:category.category_name icon:category.icon destVcClass:[KLTGDealListController class]]];
    }
    [self.sections addObject:section];
}

#pragma mark 添加娱乐组
- (void)addSectionEntertainment
{
    ProductSection *section = [ProductSection section];
    section.headerTitle = @"娱乐";
    
    for (int i = 5; i < [KLMetaDataTool sharedKLMetaDataTool].totalCategories.count; ++i) {
        KLCategory *category = [KLMetaDataTool sharedKLMetaDataTool].totalCategories[i];
        [section.items addObject:[ProductItem itemWithTitle:category.category_name icon:category.icon destVcClass:[KLTGDealListController class]]];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
