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
#import "UIBarButtonItem+WB.h"
#import "KLRestriction.h"
#import "KLRestrictItem.h"
#import "KLDetailWebInfoController.h"
#import "MBProgressHUD+MJ.h"
#import "LXActivity.h"
#import "KLLineLabel.h"

@interface KLDetailDealController ()<RETableViewManagerDelegate,LXActivityDelegate>
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, weak) KLBuyDock *buyDock;
@property (nonatomic, strong) KLDeal *deal;
@end

// 标题字体大小
#define kTitleFontSize 15
#define kFooterHeight 0.5
#define kHearderHeight 8

@implementation KLDetailDealController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"团购详情";
    
    // 导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back_os7" target:self action:@selector(cancel)];
    
    // 分享按钮
    UIBarButtonItem *rightShare = [UIBarButtonItem itemWithIcon:@"icon_merchant_share_normal" highlightIcon:@"icon_merchant_share_highlighted" imageScale:0.5 target:self action:@selector(share)];
    
    // 收藏按钮
    UIBarButtonItem *rightCollect = [UIBarButtonItem itemWithIcon:@"icon_collect" highlightIcon:@"icon_collect_highlighted" imageScale:0.5 target:self action:@selector(collect)];
    self.navigationItem.rightBarButtonItems = @[rightShare, rightCollect];
    
    // 创建tableViewManager
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    self.manager.delegate = self;
    //注册自定义cell
    self.manager[@"KLImageItem"] = @"KLImageCell";
    self.manager[@"KLRestrictItem"] = @"KLTGRestrictCell";
    
    self.manager.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
    
    // 设置tableView边框
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0,0,self.buyDock.frame.size.height+8,0);
    
    // 添加加载中
    [MBProgressHUD showMessage:@"加载中..." toView:self.tableView];
    
    // 获取详细数据
    [self getDetailData];
    
}

// 退出
- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 分享
- (void)share
{
    NSArray *shareButtonTitleArray = @[@"短信",@"邮件",@"新浪微博",@"微信",@"微信朋友圈"];;
    NSArray *shareButtonImageNameArray = @[@"sns_icon_19",@"sns_icon_18",@"sns_icon_1",@"sns_icon_22",@"sns_icon_23"];
    
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];

}

#pragma mark 分享delegate
- (void)didClickOnImageIndex:(NSInteger)imageIndex
{
    KLLog(@"%ld",(long)imageIndex);
}


// 收藏
- (void)collect
{
    
}

#pragma mark 添加BuyDock
- (void)addBuyDockView
{
    if (self.buyDock) {
        [self.buyDock removeFromSuperview];
    }
    
    __typeof (self) __weak weakSelf = self;
    self.buyDock = [KLBuyDock buyDockWithNowPrice:self.deal.current_price_text originalPrice:self.deal.list_price_text clickedHander:^{
        KLLog(@"点击了购买");
        KLDetailWebInfoController *webInfo = [[KLDetailWebInfoController alloc]init];
        webInfo.deal = weakSelf.deal;
        [weakSelf.navigationController pushViewController:webInfo animated:YES];
    }];
    
    // 设置frame
    CGFloat toolbarY = self.view.frame.size.height - self.buyDock.frame.size.height;
    
    self.buyDock.frame = CGRectMake(self.buyDock.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.buyDock.frame.size.width, self.buyDock.frame.size.height);
    [self.view addSubview:self.buyDock];
}

#pragma mark 获取数据
- (void)getDetailData
{
    __typeof (self) __weak weakSelf = self;
    [[KLTGHttpTool sharedKLTGHttpTool] dealWithID:self.deal_id success:^(KLDeal *deal){
        weakSelf.deal = deal;
        
        // 删除所有组
        [weakSelf.manager removeAllSections];
        // 添加每个组
        [weakSelf addSections];
        
        // 添加dack
        [weakSelf addBuyDockView];
        
        [self.view addSubview:self.buyDock];
        
        [weakSelf.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:weakSelf.tableView];
        
    } error:^(NSError *error) {
        KLLog(@"%@",error);
    }];
}

#pragma mark 添加所有组
- (void)addSections
{
    // 添加第一组 商品图片
    [self addImageSection];
    
    // 添加第二组 购买信息
    [self addBuySection];
    
    // 添加第三组 团购详情
    [self addDetailSection];
    
    // 添加第四组 购买须知
    [self addRemindSection];
    
    // 添加第四组 重要通知
    [self addNoticeSection];

}

#pragma mark 第一组 图片展示
- (void)addImageSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0.5;
    section.footerHeight = kFooterHeight;
    
    // 添加item
    [section addItem:[KLImageItem itemWithImageUrl:self.deal.image_url isReservation:self.deal.restrictions.is_reservation_required]];
    
    [self.manager addSection:section];
}

#pragma mark 第二组 购买信息
- (void)addBuySection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    //section.headerView = self.buyDock;
    
    // 添加标题item
    RETableViewItem *itemTitle = [RETableViewItem itemWithTitle:self.deal.title fontSzie:kTitleFontSize + 2];
    section.headerHeight = 0.5;
    section.footerHeight = kFooterHeight;
    itemTitle.cellHeight = 38;
    [section addItem:itemTitle];
    
    // 添加详情item
    MultilineTextItem *itemDes = [MultilineTextItem itemWithTitle:self.deal.desc fontSzie:12];
    itemDes.titleColor = [UIColor darkGrayColor];
    [section addItem:itemDes];
    
    // 添加购买条件信息
    KLRestrictItem *restrictItem = [KLRestrictItem item];
    restrictItem.deal = self.deal;
    [section addItem:restrictItem];
    
    [self.manager addSection:section];
}

#pragma mark 第三组 团购详情
- (void)addDetailSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"团购详情" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_package"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:self.deal.details fontSzie:13];
    
    // 查看图文详细情况
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *detailItem = [RETableViewItem itemWithTitle:@"查看图文详情" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        KLLog(@"查看图文详情");
        KLDetailWebInfoController *webInfo = [[KLDetailWebInfoController alloc]init];
        webInfo.deal = weakSelf.deal;
        [weakSelf.navigationController pushViewController:webInfo animated:YES];
    }];
    detailItem.cellHeight = 30;
    detailItem.titleFontSize = 13;
    detailItem.titleColor = KLColor(63, 176, 141);
    
    [section addItemsFromArray:@[titleItem,contentItem,detailItem]];
    
    [self.manager addSection:section];
}

#pragma mark 第四组 购买须知
- (void)addRemindSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"购买须知" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_notice"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:self.deal.restrictions.special_tips fontSzie:13];
    
    [section addItemsFromArray:@[titleItem,contentItem]];
    
    [self.manager addSection:section];
}

#pragma mark 第四组 重要通知
- (void)addNoticeSection
{
    // 创建组
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = kHearderHeight;
    section.footerHeight = kFooterHeight;
    
    // 标题
    RETableViewItem *titleItem = [RETableViewItem itemWithTitle:@"重要通知" fontSzie:kTitleFontSize];
    titleItem.image = [UIImage imageNamed:@"icon_deal_recommed"];
    titleItem.imageScale = 0.4;
    titleItem.cellHeight = 32;
    
    //内容
    NSString *content = (self.deal.notice == nil || [self.deal.notice isEqualToString:@""]) ? @"无" : self.deal.notice;
    MultilineTextItem *contentItem = [MultilineTextItem itemWithTitle:content fontSzie:13];
    
    [section addItemsFromArray:@[titleItem,contentItem]];
    
    [self.manager addSection:section];
}

#pragma mark scrollViewDelegate
// 滚动保持dock在最下面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置toolbar不随tableview移动
    CGFloat toolbarY = self.view.frame.size.height - self.buyDock.frame.size.height;
    
    self.buyDock.frame = CGRectMake(self.buyDock.frame.origin.x, toolbarY +self.tableView.contentOffset.y , self.buyDock.frame.size.width, self.buyDock.frame.size.height);
    //[self.view bringSubviewToFront:self.toolBar];
}

- (void)dealloc
{
    KLLog(@"KLDetailDealController dealloc");
}

@end
