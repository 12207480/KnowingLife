//
//  KLTGDetailController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLTGDetailController.h"
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

@interface KLTGDetailController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDataSource, UITableViewDelegate>
// 分类
@property (nonatomic, strong) NSArray *subcategories;
// 地区
@property (nonatomic, strong) NSArray *districs;
// 排序
@property (nonatomic, strong) NSArray *orders;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *deals;

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

@implementation KLTGDetailController

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
        [KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie = subCategorie.category_name;
    } else {
        [KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie = nil;
    }
    
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

- (void)getTGDetailData
{
    [[KLTGHttpTool sharedKLTGHttpTool] dealsWithPage:1 success:^(NSArray *deals, int totalCount) {
        NSLog(@"%@,%d",deals,totalCount);
        [self.deals addObjectsFromArray:deals];
        [self.tableView reloadData];
    } error:^(NSError *error) {
    }];
}

// 添加上下拉刷新
- (void)addRefreshView
{
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

// 上拉刷新新数据
- (void)headerRereshing
{
    _page = 1;
    
    __typeof (self) __weak weakSelf = self;
    // 发送请求
    [[KLTGHttpTool sharedKLTGHttpTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
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

// 下拉刷新数据
- (void)footerRereshing
{
    // 加载页面+1
    ++_page;
    __typeof (self) __weak weakSelf = self;
    // 发送请求
    [[KLTGHttpTool sharedKLTGHttpTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
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
        [KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie= subCategorie.category_name;
    } else if (indexPath.column == kDistrics) {
        // 记录当前分区
        KLCItyDistrict *distric = self.districs[indexPath.row];
        [KLMetaDataTool sharedKLMetaDataTool].currentDistrict = distric.name;
    } else if (indexPath.column == kOrders) {
        // 记录当前排序
        [KLMetaDataTool sharedKLMetaDataTool].currentOrder =self.orders[indexPath.row];
    } else {
    }
    
    KLLog(@"%@ - %@ - %@",[KLMetaDataTool sharedKLMetaDataTool].currentSubcategorie,[KLMetaDataTool sharedKLMetaDataTool].currentDistrict,[KLMetaDataTool sharedKLMetaDataTool].currentOrder);
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

- (void)dealloc
{
    KLLog(@"KLTGDetailController dealloc");
}

@end
