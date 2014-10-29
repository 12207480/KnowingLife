//
//  IDCardsSearchController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "IDCardsSearchController.h"
#import "RETableViewManager.h"
#import "KLSearchHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface IDCardsSearchController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETableViewSection *resultSection;
@property (nonatomic, strong) RETableViewSection *IDCardsection;

@end

@implementation IDCardsSearchController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"国内身份证查询验证";
    
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
    UIImage *image = [UIImage imageNamed:@"s3"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *IDCardsection = [RETableViewSection sectionWithHeaderView:imageView];
    IDCardsection.footerTitle = @"身份证验证查询系统,请勿用于非法途径!";
    
    [self.manager addSection:IDCardsection];
    self.IDCardsection = IDCardsection;
    
    RETextItem *IDCardItem = [RETextItem itemWithTitle:@"身份证号码:" value:nil placeholder:@"请输入身份证号码"];
    // 发现身边的有缘人，有趣事
    WBSubtitleItem *near = [WBSubtitleItem itemWithTitle:@"周边" subtitle:@"发现身边"];
    near.subtitleFont = [UIFont systemFontOfSize:14];
    near.subtitleAlignment = NSTextAlignmentRight;
    [IDCardsection addItem:IDCardItem];
    [IDCardsection addItem:near];
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
        
        // 读取item数据
        RETextItem *IDCarditem = weakSelf.IDCardsection.items[0];
        
        if (IDCarditem.value) {
            // 查询数据
            [weakSelf getIDCardData:IDCarditem.value];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
        [MBProgressHUD showMessage:@"查询中..."];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];

}

// 查询数据
- (void)getIDCardData:(NSString *)IDCard
{
    __typeof (self) __weak weakSelf = self;
    [KLSearchHttpTool getIDCardData:IDCard success:^(id json) {
        NSLog(@"%@",json);
        NSDictionary *dic = json;
        NSNumber *error = dic[@"error"];
        
        // 清除所有items
        [weakSelf.resultSection removeAllItems];
        
        // 是否成功
        if (error.integerValue == 0) {
            // 生日
            WBSubtitleItem *item = [WBSubtitleItem itemWithTitle:@"生日:" subtitle:dic[@"birthday"]];
            item.subtitleFont = [UIFont systemFontOfSize:16];
            item.subtitleAlignment = NSTextAlignmentRight;
            [weakSelf.resultSection addItem:item];
            
            // 性别
            NSNumber *sex = dic[@"sex"];
            NSString *sexstr = sex.integerValue ? @"男":@"女";
            item = [WBSubtitleItem itemWithTitle:@"性别:" subtitle:sexstr];
            item.subtitleFont = [UIFont systemFontOfSize:16];
            item.subtitleAlignment = NSTextAlignmentRight;
            [weakSelf.resultSection addItem:item];
            
            // 地区
            item = [WBSubtitleItem itemWithTitle:@"地区:" subtitle:dic[@"region"]];
            item.subtitleFont = [UIFont systemFontOfSize:16];
            item.subtitleAlignment = NSTextAlignmentRight;
            [weakSelf.resultSection addItem:item];
        } else {
            [weakSelf.resultSection addItem:[RETableViewItem itemWithTitle:@"查询失败，身份证号码输入错误！"]];
        }
        
        // 重新加载section
        [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

/*  
 birthday = "1991-10-02";
 error = 0;
 region = "\U6e56\U5357\U7701 \U6e58\U6f6d\U5e02 \U6e58\U6f6d\U53bf";
 sex = 1;
 */

@end
