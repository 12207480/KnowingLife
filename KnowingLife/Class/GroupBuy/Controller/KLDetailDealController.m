//
//  KLDetailDealController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLDetailDealController.h"
#import "RETableViewManager.h"
#import "KLImageItem.h"
#import "KLDeal.h"
#import "KLTGHttpTool.h"
#import "KLBuyDock.h"

@interface KLDetailDealController ()
@property (nonatomic, strong) RETableViewManager *manager;
@end

@implementation KLDetailDealController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"团购详情";
    
    // 创建tableViewManager
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    
    //注册自定义cell
    self.manager[@"KLImageItem"] = @"KLImageCell";
    
    // 获取详细数据
    [self getDetailData];
    
    // 添加第一组 商品图片
    [self addImageSection];
    
    // 添加第二组 购买
    [self addBuySection];
}

- (void)getDetailData
{
    __typeof (self) __weak weakSelf = self;
    [[KLTGHttpTool sharedKLTGHttpTool] dealWithID:self.deal.deal_id success:^(KLDeal *deal){
        weakSelf.deal = deal;
        [weakSelf.tableView reloadData];
    } error:^(NSError *error) {
        KLLog(@"%@",error);
    }];
}

- (void)addImageSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    
    // 添加item
    [section addItem:[KLImageItem itemWithImageUrl:self.deal.image_url]];
    
    [self.manager addSection:section];
}

- (void)addBuySection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerView = [KLBuyDock buyDockWithNowPrice:self.deal.current_price_text originalPrice:self.deal.list_price_text clickedHander:nil];
    
    
    
    [self.manager addSection:section];
}

@end
