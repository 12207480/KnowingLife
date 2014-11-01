//
//  IPSearchController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/30.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "IPSearchController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+MJ.h"
#import "KLSearchHttpTool.h"

@interface IPSearchController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *IPItem;
@property (nonatomic, strong) RETableViewSection *resultSection;
@end

@implementation IPSearchController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"IP地址查询";
    
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView];
    self.manager.style.cellHeight = 36;
    
    // 添加第一个组 查询
    [self addSectionSearch];
    
    // 添加第二个组 结果
    [self addSectionResult];
    
    // 添加第三组 查询按钮
    [self addSectionButton];
}

// 添加第一个组 查询
- (void)addSectionSearch
{
    UIImage *image = [UIImage imageNamed:@"a5"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
    [self.manager addSection:headerSection];
    headerSection.footerTitle = @"可以查询指定IP的物理地址或域名服务器的IP和物理地址，及所在国家或城市，甚至精确到某个网吧，机房或学校等";
    
    RETextItem *IPItem = [RETextItem itemWithTitle:@"IP地址:" value:nil placeholder:@"请输入要查询的IP地址"];
    IPItem.keyboardType = UIKeyboardTypeDecimalPad;
    [headerSection addItem:IPItem];
    self.IPItem = IPItem;
    
}

// 添加第二个组 结果
- (void)addSectionResult
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果:"];
    [self.manager addSection:section];
    self.resultSection = section;
}

- (void)addSectionButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    // 消除强引用
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
        
        if (weakSelf.IPItem.value) {
            // 查询数据
            [weakSelf getIPDataWithIP:weakSelf.IPItem.value];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

- (void)getIPDataWithIP:(NSString *)IP
{
    __typeof (self) __weak weakSelf = self;
    [KLSearchHttpTool getIPDataWithIP:IP success:^(id json) {
        KLLog(@"%@",json);
        NSDictionary *dic = json;
        
        // 清除所有items
        [weakSelf.resultSection removeAllItems];
        
        if ([dic[@"code"] integerValue] == 200 ) {
            // 返回成功
            // ip
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"IP地址:" rightSubtitle:dic[@"ip"]]];
            
            // 运营商
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"IP拥有商:" rightSubtitle:dic[@"area2"]]];
            
            // 详细地址
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"地理位置:" rightSubtitle:dic[@"area1"]]];
            
            // 开始地址
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"起始IP:" rightSubtitle:dic[@"startip"]]];
            
            // 结束地址
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"结束IP:" rightSubtitle:dic[@"endip"]]];
            
        } else {
            // 查询失败
            [weakSelf.resultSection addItem:@"查询失败，输入是否正确!"];
        }
        
        // 重新加载section
        [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

/*{ 返回数据
 area1 = "\U6e56\U5357\U7701\U6e58\U6f6d\U5e02";
 area2 = "\U7535\U4fe1";
 code = 200;
 endip = ;
 ip = "58.45.254.247";
 startip = "58.45.244.0";
 }*/

- (void)dealloc
{
    KLLog(@"IPSearchController dealloc");
}

@end
