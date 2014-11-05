//
//  DreamAnalysisController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/30.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "DreamAnalysisController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+MJ.h"
#import "KLSearchHttpTool.h"

@interface DreamAnalysisController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *dreamItem;
@property (nonatomic, strong) RETableViewSection *resultSection;
@end

@implementation DreamAnalysisController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"各国货币汇率查询";
    
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
    UIImage *image = [UIImage imageNamed:@"a6"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
    [self.manager addSection:headerSection];
    headerSection.footerTitle = @"目前最完善的周公解梦数据！大约收录梦境关键词数据4500多条，并且结合现代梦境的解释含义，权威精准又富有娱乐性！";
    
    RETextItem *dreamItem = [RETextItem itemWithTitle:@"梦境:" value:nil placeholder:@"请输入梦境关键字"];
    [headerSection addItem:dreamItem];
    self.dreamItem = dreamItem;
    
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
        
        if (weakSelf.dreamItem.value) {
            // 查询数据
            [weakSelf getDreamDataWithKey:weakSelf.dreamItem.value];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

- (void)getDreamDataWithKey:(NSString *)dreamKey
{
    __typeof (self) __weak weakSelf = self;
    [KLSearchHttpTool getDreamDataWithKey:dreamKey success:^(id json) {
        KLLog(@"%@",json);
        //NSDictionary *dic = json;
        
        // 清除所有items
        [weakSelf.resultSection removeAllItems];
        
        if ([json isKindOfClass:[NSArray class]]) {
            // 没有错误
            NSArray *array = json;
            for (NSString *result in array) {
                
                // 去掉换行
                NSString *newResult = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                newResult = [newResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                // 添加结果
                [weakSelf.resultSection addItem:[MultilineTextItem itemWithTitle:newResult fontSzie:14]];
            }
            
        } else {
            // 查询失败
            [weakSelf.resultSection addItem:@"查询失败，只支持中文查找"];
        }
        
        
        // 重新加载section
        [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)dealloc
{
    KLLog(@"DreamAnalysisController dealloc");
}

@end
