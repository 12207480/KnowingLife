//
//  KLTGDetailController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLTGDealListController.h"
#import "DOPDropDownMenu.h"
#import "KLCategory.h"
#import "KLMetaDataTool.h"
#import "KLCity.h"
#import "KLCItyDistrict.h"
#import "KLSubCategorie.h"
#import "KLOrder.h"
#import "KLTGHttpTool.h"
#import "KLDeal.h"
#import "KLDealViewCell.h"
#import "MJRefresh.h"
#import "UIBarButtonItem+WB.h"

@interface KLTGDealListController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDataSource, UITableViewDelegate>
// 分类
@property (nonatomic, strong) NSArray *subcategories;
// 地区
@property (nonatomic, strong) NSArray *districs;
// 排序
@property (nonatomic, strong) NSArray *orders;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *deals;

// 当前选中的类别
@property (nonatomic, strong) NSString *currentSubcategorie;
// 当前选中的区域
@property (nonatomic, strong) NSString *currentDistrict;
// 当前选中的排序
@property (nonatomic, strong) KLOrder *currentOrder;

@property (nonatomic, assign) int page;
@end

typedef enum : NSUInteger {
    kCategorys,
    kDistrics,
    kOrders,
} kTGDtailMenu;

// 菜单高度
#define KMenuHeight 32

static NSString *reuseIdDealCell = @"DealCell";

@implementation KLTGDealListController

- (NSMutableArray *)deals
{
    if (_deals == nil) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // fram不包括导航栏
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back_os7" target:self action:@selector(cancel)];
    
    // 保存当前分类
    [self saveCurrentCategory];
    
    // 添加topmenu
    [self addTopMenu];
    
    // 添加tableView
    [self addTableView];
    
    // 注册nib
    UINib *nib = [UINib nibWithNibName:@"KLDealViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdDealCell];
    
    _page = 1;
    
    // 添加下拉刷新控件
    [self addRefreshView];
    
    // 获取团购数据 刷新数据
    [self.tableView headerBeginRefreshing];
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveCurrentCategory
{
    // 保存选择的分类
    for (KLCategory *category in [KLMetaDataTool sharedKLMetaDataTool].totalCategories) {
        if ([category.category_name isEqualToString:self.title]) {
            [KLMetaDataTool sharedKLMetaDataTool].currentCategory = category;
            break;
        }
    }
    
    //[KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie = self.title;
    
    // 保存需要数据
    NSMutableArray *tmp = nil;
    KLSubCategorie *subCategorie = [[KLSubCategorie alloc]init];
    subCategorie.category_name = @"全部";
    if ([KLMetaDataTool sharedKLMetaDataTool].currentCategory.subcategories == nil) {
        tmp = [NSMutableArray array];
        [tmp addObject:subCategorie];
    } else {
        tmp = [NSMutableArray arrayWithArray:[KLMetaDataTool sharedKLMetaDataTool].currentCategory.subcategories];
        [tmp insertObject:subCategorie atIndex:0];
    }
    self.subcategories = tmp;
    if ([[KLMetaDataTool sharedKLMetaDataTool].currentCategory.category_name isEqualToString: @"结婚"]) {
        [tmp removeObjectAtIndex:0];
        KLSubCategorie *subCategorie = tmp[0];
        self.currentSubcategorie = subCategorie.category_name;
    } else {
        self.currentSubcategorie = nil;
    }
    
    // 保存全部地区
    KLCItyDistrict *distrc = [[KLCItyDistrict alloc]init];
    distrc.name = @"全城";
    if ([KLMetaDataTool sharedKLMetaDataTool].currentCity.districts == nil) {
        tmp = [NSMutableArray array];
        [tmp addObject:distrc];
    } else {
        tmp = [NSMutableArray arrayWithArray:[KLMetaDataTool sharedKLMetaDataTool].currentCity.districts];
        [tmp insertObject:distrc atIndex:0];
    }
    self.districs = tmp;
    
    // 保存排序
    self.orders = [KLMetaDataTool sharedKLMetaDataTool].totalOrders;
}

- (void)addTopMenu
{
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:KMenuHeight];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, KMenuHeight, self.view.frame.size.width, self.view.frame.size.height - KMenuHeight-66);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 获得新团购数据
- (void)getNewTGDetailData
{
    if (!self.currentDistrict || [self.currentDistrict isEqualToString:@"全城"]) {
        self.currentDistrict = nil;
    }
    
    if (!self.currentSubcategorie || [self.currentSubcategorie isEqualToString:@"全部"]) {
        self.currentSubcategorie = [KLMetaDataTool sharedKLMetaDataTool].currentCategory.category_name;
    }
    
    NSInteger orderIndex = 1;
    if (self.currentOrder ) {
        orderIndex = self.currentOrder.index;
    }
    
    __typeof (self) __weak weakSelf = self;
    
    // 页面为1最新一页
    _page = 1;
    
    // 发送请求
    [[KLTGHttpTool sharedKLTGHttpTool] dealsWithPage:_page district:self.currentDistrict category:self.currentSubcategorie orderIndext:orderIndex success:^(NSArray *deals, int totalCount) {
        //KLLog(@"%@,%d",deals,totalCount);
        
        // 添加数据
        weakSelf.deals = [NSMutableArray arrayWithArray:deals];
        
        // 重新加载
        [weakSelf.tableView reloadData];
        
        // 停止刷新
        [weakSelf.tableView headerEndRefreshing];
    } error:^(NSError *error) {
        // 停止刷新
        [weakSelf.tableView headerEndRefreshing];
    }];

    
}

// 获得更多团购数据
- (void)getMoreTGDetailData
{
    if (!self.currentDistrict || [self.currentDistrict isEqualToString:@"全城"]) {
        self.currentDistrict = nil;
    }
    
    if (!self.currentSubcategorie || [self.currentSubcategorie isEqualToString:@"全部"]) {
        self.currentSubcategorie = [KLMetaDataTool sharedKLMetaDataTool].currentCategory.category_name;
    }
    
    NSInteger orderIndex = 1;
    if (self.currentOrder ) {
        orderIndex = self.currentOrder.index;
    }
    
    __typeof (self) __weak weakSelf = self;
    
    // 加载页面+1
    ++_page;
    
    // 发送请求
    [[KLTGHttpTool sharedKLTGHttpTool] dealsWithPage:_page district:self.currentDistrict category:self.currentSubcategorie orderIndext:orderIndex success:^(NSArray *deals, int totalCount) {
        //KLLog(@"%@,%d",deals,totalCount);
        
        // 添加数据
        [weakSelf.deals addObjectsFromArray:deals];
        
        // 停止刷新
        [weakSelf.tableView reloadData];
        
        // 恢复刷新状态
        [weakSelf.tableView footerEndRefreshing];
    } error:^(NSError *error) {
        // 停止刷新
        [weakSelf.tableView headerEndRefreshing];
    }];
}

// 添加上下拉刷新
- (void)addRefreshView
{
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(getNewTGDetailData)];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(getMoreTGDetailData)];
    
}

#pragma mark DOPDropDownMenuDataSource

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    switch (column) {
        case kCategorys:
            return self.subcategories.count;
            break;
        case kDistrics:
            return self.districs.count;
            break;
        case kOrders:
            return self.orders.count;
            break;
        default:
            return 0;
            break;
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == kCategorys) {
        KLSubCategorie *subCategorie = self.subcategories[indexPath.row];
        return subCategorie.category_name;
    } else if (indexPath.column == kDistrics) {
        KLCItyDistrict *distric = self.districs[indexPath.row];
        return distric.name;
    } else if (indexPath.column == kOrders) {
        KLOrder *order = self.orders[indexPath.row];
        return order.name;
    } else {
        return nil;
    }

}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

#pragma mark DOPDropDownMenuDelegate

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    //KLLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
    if (indexPath.column == kCategorys) {
        // 记录当前分类
        KLSubCategorie *subCategorie = self.subcategories[indexPath.row];
        self.currentSubcategorie= subCategorie.category_name;
    } else if (indexPath.column == kDistrics) {
        // 记录当前分区
        KLCItyDistrict *distric = self.districs[indexPath.row];
        self.currentDistrict = distric.name;
    } else if (indexPath.column == kOrders) {
        // 记录当前排序
        self.currentOrder =self.orders[indexPath.row];
    } else {
    }
    
    KLLog(@"%@ - %@ - %@",self.currentSubcategorie,self.currentDistrict,self.currentOrder);
    __typeof (self) __weak weakSelf = self;
    [weakSelf.tableView headerBeginRefreshing];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdDealCell];
    if (cell == nil) {
        cell = [[KLDealViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdDealCell];
    }
    
    KLDeal *deal = self.deals[indexPath.row];
    
    cell.deal = deal;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLDeal *deal = self.deals[indexPath.row];
    
    [[KLTGHttpTool sharedKLTGHttpTool] dealWithID:deal.deal_id success:^(KLDeal *deal) {
        KLLog(@"%@",deal);
    } error:^(NSError *error) {
        KLLog(@"%@",error);
    }];
}

- (void)dealloc
{
    KLLog(@"KLTGDetailController dealloc");
}

@end
