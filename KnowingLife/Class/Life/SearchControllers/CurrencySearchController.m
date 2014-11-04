//
//  CurrencySearchController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/30.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "CurrencySearchController.h"
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "MBProgressHUD+MJ.h"
#import "KLSearchHttpTool.h"
#import "NSString+TG.h"

@interface CurrencySearchController ()
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) NSArray *currencyArray;
@property (nonatomic, strong) RETextItem *numberItem;
@property (nonatomic, strong) RERadioItem *swapOut;
@property (nonatomic, strong) RERadioItem *swapIn;
@property (nonatomic, strong) RETableViewSection *resultSection;

@end

@implementation CurrencySearchController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (NSArray *)currencyArray
{
    if (_currencyArray == nil) {
        _currencyArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Currency.plist" ofType:nil]];
        KLLog(@"排序前 %@",_currencyArray);
        _currencyArray = [_currencyArray sortedArrayUsingSelector:@selector(compare:)];
        KLLog(@"排序后 %@",_currencyArray);
    }
    return _currencyArray;
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
    UIImage *image = [UIImage imageNamed:@"a7"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, 100);
    imageView.contentMode = UIViewContentModeCenter;
    
    // 添加头部视图
    RETableViewSection *headerSection = [RETableViewSection sectionWithHeaderView:imageView];
   [self.manager addSection:headerSection];
    headerSection.footerTitle = @"强大的货币汇率!包括人民币汇率、美元汇率、欧元汇率、港币汇率、英镑汇率等多个国家和地区货币汇率换算。实时汇率换算查询，货币汇率自动按国际换汇牌价进行调整。";
    __typeof (self) __weak weakSelf = self;
    // 兑换货币
    RERadioItem *swapOut = [weakSelf createSwapOutInItemWithTitle:@"兑换货币:" value:@"CNY - 人民币"];
    [headerSection addItem:swapOut];
    self.swapOut = swapOut;
    
    // 换入货币
    RERadioItem *swapIn = [weakSelf createSwapOutInItemWithTitle:@"换入货币:" value:@"USD - 美元"];
    [headerSection addItem:swapIn];
    self.swapIn = swapIn;
    
    RETextItem * numberItem = [RETextItem itemWithTitle:@"兑换金额:" value:nil placeholder:@"请输入兑换金额"];
    numberItem.keyboardType = UIKeyboardTypeDecimalPad;
    [headerSection addItem:numberItem];
    self.numberItem = numberItem;
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
        
        if (weakSelf.numberItem.value) {
            // 查询数据
           [weakSelf getCurrencyDataWithFrom:[weakSelf.swapOut.value substringToIndex:3] to:[weakSelf.swapIn.value substringToIndex:3]];
            [MBProgressHUD showMessage:@"查询中..."];
        }
        
        // item取消选择
        [item deselectRowAnimated:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
}

- (void)getCurrencyDataWithFrom:(NSString *)from to:(NSString *)to
{
    __typeof (self) __weak weakSelf = self;
    [KLSearchHttpTool getCurrencyDataWithFrom:from to:to success:^(id json) {
        KLLog(@"%@",json);
        NSDictionary *dic = json;
        NSNumber *error = dic[@"error"];
        
        // 清除所有items
        [weakSelf.resultSection removeAllItems];
        
        // 是否成功
        if (error.integerValue == 0) {
            // 添加item
            // from货币
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:dic[@"from_cn"] rightSubtitle:weakSelf.numberItem.value]];
            // 当前汇率
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"当前兑换汇率" rightSubtitle:dic[@"now"]]];
            
            // to货币
            double toNumber = [weakSelf.numberItem.value doubleValue] * [dic[@"now"] doubleValue];
            //NSString *money = [NSString stringWithFormat:@"%.4f",toNumber];[weakSelf changeFloat:money]
            
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:dic[@"to_cn"] rightSubtitle:[NSString stringWithDouble:toNumber fractionCount:3]]];
            
            // 当前汇率更新日期
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"汇率更新日期" rightSubtitle:dic[@"date"]]];
            
            // 买入汇率
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"买入" rightSubtitle:dic[@"buy"]]];
            // 卖出
            [weakSelf.resultSection addItem:[WBSubtitleItem itemWithTitle:@"卖出" rightSubtitle:dic[@"sale"]]];
            
        } else {
            // 查询失败
            [weakSelf.resultSection addItem:[RETableViewItem itemWithTitle:@"查询失败,输入是否正确"]];
        }
        
        // 重新加载section
        [weakSelf.resultSection reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
}

/*{返回数据
 buy = "0.1635";
 date = "10-30-2014";
 "from_cn" = "\U4eba\U6c11\U5e01";
 now = "0.1635";
 sale = "0.1635";
 time = "5:13am";
 "to_cn" = "\U7f8e\U5143";
 }
*/

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

// 创建radioitem
- (RERadioItem *)createSwapOutInItemWithTitle:(NSString *)title value:(NSString *)value
{
     __typeof (self) __weak weakSelf = self;
    
    RERadioItem *swapOutIn = [RERadioItem itemWithTitle:title value:value selectionHandler:^(RERadioItem *item) {
        //[item deselectRowAnimated:YES];
        
        // options controller
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:weakSelf.currencyArray multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    return swapOutIn;
}

- (void)dealloc
{
    KLLog(@"CurrencySearchController dealloc");
}

@end
