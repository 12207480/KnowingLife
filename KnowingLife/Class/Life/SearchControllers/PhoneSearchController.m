//
//  PhoneSearchController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/30.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "PhoneSearchController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+MJ.h"
#import "KLSearchHttpTool.h"

@interface PhoneSearchController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *phoneItem;
@property (nonatomic, strong) RETableViewSection *resultSection;
@end

@implementation PhoneSearchController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手机归属地查询";
    
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
    UIImage *image = [UIImage imageNamed:@"a1"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
    headerSection.footerTitle = @"手机号码归属地查询，可查询中国移动，中国联通，中国电信手机号段归属地信息.";
    [self.manager addSection:headerSection];
    
    RETextItem *phoneItem = [RETextItem itemWithTitle:@"手机号码:" value:nil placeholder:@"请输入待查询的手机号码"];
    phoneItem.keyboardType = UIKeyboardTypeNumberPad;
    [headerSection addItem:phoneItem];
    self.phoneItem = phoneItem;
}

// 添加第二个组 结果
- (void)addSectionResult
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"查询结果:"];
    [self.manager addSection:section];
    self.resultSection = section;
}

// 添加第三组 查询按钮
- (void)addSectionButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    // 消除强引用
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"查询" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        //item.title = @"Pressed!";
     
        if (weakSelf.phoneItem.value) {
            // 查询数据
            [weakSelf getPhoneData:weakSelf.phoneItem.value];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

- (void)getPhoneData:(NSString *)phone
{
    __typeof (self) __weak weakSelf = self;
    [KLSearchHttpTool getPhoneData:phone success:^(id json) {
        KLLog(@"%@",json);
        NSDictionary *dic = json;
        NSNumber *error = dic[@"error"];
        
        // 清除所有items
        [weakSelf.resultSection removeAllItems];
        
        // 是否成功
        if (error.integerValue == 0) {
            // 添加item
            // 手机号码
            NSString *phoneNum = weakSelf.phoneItem.value;
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"号码:" rightSubtitle:phoneNum]];
            
            // 卡号类型
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"卡类型:" rightSubtitle:dic[@"type"]]];
            
            // 区号
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"区号:" rightSubtitle:dic[@"code"]]];
            
            // 归属地
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"归属地:" rightSubtitle:dic[@"city"]]];
        } else {
            // 查询失败
            [weakSelf.resultSection addItem:[RETableViewItem itemWithTitle:@"查询失败，手机号码输入错误！"]];
        }
        
        // 重新加载section
        [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

/*{返回数据
 city = "\U5e7f\U4e1c \U6df1\U5733";
 code = 0755;
 error = 0;
 type = "\U5e7f\U4e1c\U79fb\U52a8\U5168\U7403\U901a\U5361";
 }*/

- (void)dealloc
{
    KLLog(@"PhoneSearchController dealloc");
}

@end
