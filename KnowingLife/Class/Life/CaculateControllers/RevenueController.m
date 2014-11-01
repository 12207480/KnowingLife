//
//  RevenueController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/31.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "RevenueController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+MJ.h"
#import "KLSearchHttpTool.h"

@interface RevenueController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETableViewSection *resultSection;
@property (nonatomic, strong) RETextItem *number;
@property (nonatomic, strong) REPickerItem *pickerItem;
// 应缴税收
@property (nonatomic, assign) float taxPayable;
// 税后收入
@property (nonatomic, assign) float afterTax;

@end

@implementation RevenueController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"税收计算";
    
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
    UIImage *image = [UIImage imageNamed:@"s7"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
    [self.manager addSection:headerSection];
    headerSection.footerTitle = @"可以计算个人税收和个体商户税收";
    
    RETextItem *number = [RETextItem itemWithTitle:@"收入总额:" value:nil placeholder:@"请输入收入总额"];
    number.keyboardType = UIKeyboardTypeDecimalPad;
    [headerSection addItem:number];
    self.number = number;
    
    //添加pick
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"收入类型:" value:@[@"个人税收"] placeholder:nil options:@[@[@"个人税收",@"个体商户税收"]]];
    [headerSection addItem:pickerItem];
    self.pickerItem = pickerItem;
    
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
        
        if (weakSelf.number.value) {
            // 查询数据
            //[weakSelf caculateRevenue:[weakSelf.number.value integerValue]];
            NSString *value = [weakSelf.pickerItem.value lastObject];
            if ([value isEqualToString:@"个人税收"]  ) {
                [weakSelf caculatePersonalRevenue:[weakSelf.number.value doubleValue]];
            } else {
                [weakSelf caculateBusinessRevenue:[weakSelf.number.value doubleValue]];
            }
            
            // 清除所有items
            [weakSelf.resultSection removeAllItems];
            
            // 应缴税款
            NSString *taxPayble = [NSString stringWithFormat:@"%.3f",weakSelf.taxPayable];
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"应缴税款:" rightSubtitle:[weakSelf changeFloat:taxPayble]]];
            
            // 税后收入
            NSString *afterTax = [NSString stringWithFormat:@"%.3f",weakSelf.afterTax];
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"税后收入:" rightSubtitle:[weakSelf changeFloat:afterTax]]];
            
            // 重新加载section
            [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
        
        
        
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

// 计算个人税收
- (void)caculatePersonalRevenue:(double)number
{
    int tax[] = { 0, 105, 555, 1005, 2755, 5505, 13505 };
    float percent[] = { 0.03, 0.1, 0.2, 0.25, 0.3, 0.35, 0.45 };
    
    float Money = number;
    float taxhand = 0;
    
    int i = (Money >= 1500) + (Money >= 4500) + (Money >= 9000) + (Money >= 35000) + (Money >= 55000) + (Money >= 80000);
    switch (i)
    {
        case 0:taxhand = Money * percent[i] - tax[i];
            break;
        case 1:taxhand = Money * percent[i] - tax[i];
            break;
        case 2:taxhand = Money * percent[i] - tax[i];
            break;
        case 3:taxhand = Money * percent[i] - tax[i];
            break;
        case 4:taxhand = Money * percent[i] - tax[i];
            break;
        case 5:taxhand = Money * percent[i] - tax[i];
            break;
        case 6:taxhand = Money * percent[i] - tax[i];
            break;
    }
    
    KLLog(@"%f",taxhand);
    __typeof (self) __weak weakSelf = self;
    
    weakSelf.taxPayable = taxhand;
    weakSelf.afterTax = Money - taxhand;
    
}

// 计算个体商户税收
- (void)caculateBusinessRevenue:(double)number
{
    int tax[] = { 0, 750, 3750, 9750, 14750 };
    float percent[] = { 0.05, 0.1, 0.2, 0.3, 0.35 };
    
    float Money = number;
    float taxhand = 0;
    
    int i = (Money >= 15000) + (Money >= 30000) + (Money >= 60000) + (Money >= 100000) ;
    switch (i)
    {
        case 0:taxhand = Money * percent[i] - tax[i];
            break;
        case 1:taxhand = Money * percent[i] - tax[i];
            break;
        case 2:taxhand = Money * percent[i] - tax[i];
            break;
        case 3:taxhand = Money * percent[i] - tax[i];
            break;
        case 4:taxhand = Money * percent[i] - tax[i];
            break;
    }
    
    NSLog(@"%f",taxhand);
    
    __typeof (self) __weak weakSelf = self;
    
    weakSelf.taxPayable = taxhand;
    weakSelf.afterTax = Money - taxhand;
}

- (NSString *)changeFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

-(void)dealloc
{
    KLLog(@"RevenueController dealloc");
}

@end
