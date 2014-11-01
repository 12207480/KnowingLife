//
//  FangDaiViewController.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-6.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "FangDaiViewController.h"
#import "FangResultViewController.h"

@interface FangDaiViewController ()

@property (nonatomic, retain) UIScrollView * userContentView;
@property (nonatomic, retain) UIButton * shangDaiBtn;//商贷按钮
@property (nonatomic, retain) UIButton * gongBtn;//公积金贷款按钮
@property (nonatomic, retain) UIButton * zuHeBtn;//组合型贷款按钮

@property (nonatomic, retain) UIView * shangDaiView;//商贷背景视图
@property (nonatomic, retain) UIView * sonShangView_one;//商贷子视图一
@property (nonatomic, retain) UIView * sonShangView_two;//商贷子视图二
@property (nonatomic, retain) UIView * gongView;//公积金背景视图
@property (nonatomic, retain) UIView * sonGongView_one;//公积金贷款子视图一
@property (nonatomic, retain) UIView * sonGongView_two;//公积金贷款子视图二
@property (nonatomic, retain) UIView * sonGongView;//公积金贷款子视图
@property (nonatomic, retain) UIView * zuHeView;//组合背景视图
@property (nonatomic, retain) UIView * sonZuView;//组合贷款子视图

@property (nonatomic, retain) UIButton * oneBtn;//等额本息
@property (nonatomic, retain) UIButton * twoBtn;//等额本金

@property (nonatomic, retain) NSString * jiSuanType;//算法类型
@property (nonatomic, retain) NSString * huanKuanType;//还款类型
@property (nonatomic, retain) NSString * suanType;//房价计算类型

@property (nonatomic, retain) UIButton * shangDanBtn;//商贷按单价计价按钮
@property (nonatomic, retain) UIButton * shangZongBtn;//商贷按总价计价按钮
@property (nonatomic, retain) UIButton * gongDanBtn;//公积金按单价计价按钮
@property (nonatomic, retain) UIButton * gongZongBtn;//公积金按总价计价按钮

#pragma mark ---------商贷页面数据----------
/*
 *  按单价计算商贷所需要的数据框
 */
@property (nonatomic, retain) UITextField * shangJiaGe;//商贷单价
@property (nonatomic, retain) UITextField * shangMianJi;//商贷面积
@property (nonatomic, retain) UILabel * shangDanCheng;//商贷按揭成数
@property (nonatomic, retain) UILabel * shangDanNian;//商贷年数
@property (nonatomic, retain) UILabel * shangDanLiLv;//商贷利率
/*
 *  按总价计算商贷所需要的数据框
 */
@property (nonatomic, retain) UITextField * shangZong;//商贷总额
@property (nonatomic, retain) UILabel * shangZongNian;//商贷总价按揭年数
@property (nonatomic, retain) UILabel * shangZongLiLv;//商贷总价利率

#pragma mark ---------公积金页面数据---------
/*
 *  按单价计算公积金所需要的数据框
 */
@property (nonatomic, retain) UITextField * gongJiaGe;//公积金单价
@property (nonatomic, retain) UITextField * gongMianJi;//公积金面积
@property (nonatomic, retain) UILabel * gongDanCheng;//公积金按揭成数
@property (nonatomic, retain) UILabel * gongDanNian;//公积金年数
@property (nonatomic, retain) UILabel * gongDanLiLv;//公积金利率
/*
 *  按总价计算公积金所需要的数据框
 */
@property (nonatomic, retain) UITextField * gongZong;//公积金总额
@property (nonatomic, retain) UILabel * gongZongNian;//公积金总价按揭年数
@property (nonatomic, retain) UILabel * gongZongLiLv;//公积金总价利率

#pragma mark ---------组合贷款页面数据---------
/*
 *  组合型贷款分类输入数据框
 */
@property (nonatomic, retain) UITextField * gongDai;//公积金贷款
@property (nonatomic, retain) UITextField * shangDai;//商业贷款
@property (nonatomic, retain) UILabel * zuHeNian;//组合贷款按揭年数
@property (nonatomic, retain) UILabel * zuHeLiLv;//组合贷款利率

//数组
@property (nonatomic, retain) NSArray * array_1;//成数数组
@property (nonatomic, retain) NSArray * array_2;//年数数组
@property (nonatomic, retain) NSArray * array_3;//按揭利率年份
@property (nonatomic, retain) NSArray * array_4;//商贷利率
@property (nonatomic, retain) NSArray * array_5;//公积金贷款利率
@property (nonatomic, retain) NSArray * array_6;//贷款年数

//弹出视图层
@property (nonatomic, retain) UIView * coverView;//黑色半透明遮盖层
@property (nonatomic, retain) UIImageView * popIMgview;//弹出列表背景
@property (nonatomic, retain) UITableView * popTableView;//弹出列表
@property (nonatomic, retain) UILabel * popLabel;//弹出视图标题
@property (nonatomic, retain) NSMutableArray * tabArray;//列表数组
@property (nonatomic, retain) NSString * popType;//弹出视图标识
@property (nonatomic, retain) NSString * xianString;//显示数据

//显示利率
@property (nonatomic, retain) UILabel * label_1;
@property (nonatomic, retain) UILabel * label_2;
@property (nonatomic, retain) UILabel * label_3;
@property (nonatomic, retain) UILabel * label_4;
@property (nonatomic, retain) UILabel * label_5;
@property (nonatomic, retain) UILabel * label_6;

@end

@implementation FangDaiViewController
@synthesize userContentView;
//@synthesize fangDaiBar;
@synthesize shangDaiBtn,gongBtn,zuHeBtn;
@synthesize shangDaiView,gongView,zuHeView,sonShangView_one,sonShangView_two,sonGongView,sonZuView,sonGongView_one,sonGongView_two;
@synthesize jiSuanType,huanKuanType,suanType;
@synthesize oneBtn,twoBtn;
@synthesize shangDanBtn,shangZongBtn,gongDanBtn,gongZongBtn;

@synthesize shangJiaGe,shangMianJi,shangZong;
@synthesize gongJiaGe,gongMianJi,gongZong;
@synthesize gongDai,shangDai;
@synthesize shangDanCheng,shangDanNian,shangDanLiLv,shangZongNian,shangZongLiLv;
@synthesize gongDanCheng,gongDanNian,gongDanLiLv,gongZongNian,gongZongLiLv;
@synthesize zuHeNian,zuHeLiLv;
@synthesize array_1,array_2,array_3,array_4,array_5,array_6;
@synthesize coverView,popIMgview,popTableView,popLabel;
@synthesize tabArray,popType,xianString;
@synthesize label_1,label_2,label_3,label_4,label_5,label_6;

-(void)dealloc
{
    [userContentView removeFromSuperview];
    
    //[fangDaiBar release];
    
    [shangDaiView removeFromSuperview];
    
    [gongView removeFromSuperview];
    
    [zuHeView removeFromSuperview];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)creatDataArray
{
    //按揭成数数组
    self.array_1 = [NSArray arrayWithObjects:@"9成",@"8成",@"7成",@"6成",@"5成",@"4成",@"3成",@"2成", nil];
    self.array_2 = [NSArray arrayWithObjects:@"1年(12期)",@"2年(24期)",@"3年(36期)",@"4年(48期)",@"5年(60期)",@"6年(72期)",@"7年(84期)",@"8年(96期)",@"9年(108期)",@"10年(120期)",@"11年(134期)",@"12年(144期)",@"13年(156期)",@"14年(168期)",@"15年(180期)",@"16年(192期)",@"17年(204期)",@"18年(216期)",@"19年(228期)",@"20年(240期)",@"25年(300期)",@"30年(360期)", nil];
    self.array_3 = [NSArray arrayWithObjects:@"12年7月6日利率下限(7折)",@"12年7月6日利率下限(85折)",@"12年7月6日利率上限(1.1倍)",@"12年7月6日基准利率",@"12年6月8日利率上限(1.1倍)",@"12年6月8日利率下限(85折)",@"12年6月8日基准利率",@"11年7月6日利率上限(1.1倍)",@"11年7月6日利率下限(85折)",@"11年7月6日基准利率",@"11年4月5日利率上限(1.1倍)",@"11年4月5日利率下限(85折)",@"11年4月5日利率下限(7折)",@"11年4月5日基准利率",@"11年2月9日利率上限(1.1倍)",@"11年2月9日利率下限(85折)",@"11年2月9日利率下限(7折)",@"11年2月9日基准利率",@"10年12月26日利率上限(1.1倍)",@"10年12月26日利率下限(85折)",@"10年12月26日利率下限(7折)",@"10年12月26日基准利率",@"10年10月20日利率上限(1.1倍)",@"10年10月20日基准利率",@"10年10月20日利率下限(85折)",@"10年10月20日利率下限(7折)",@"08年12月23日利率上限(1.1倍)",@"08年12月23日基准利率",@"08年12月23日利率下限(85折)",@"08年12月23日利率下限(7折)", nil];
    self.array_4 = [NSArray arrayWithObjects:@"4.59%", @"5.57%", @"7.21%", @"6.55%", @"7.48%",
                    @"5.78%", @"6.8%", @"7.75%", @"5.99%", @"7.05%", @"7.48%", @"5.78%",
                    @"4.76%", @"6.8%", @"7.26%", @"5.61%", @"4.62%", @"6.6%", @"7.04%",
                    @"5.44%", @"4.48%", @"6.4%", @"6.75%", @"6.14%", @"5.22%", @"4.3%",
                    @"6.53%", @"5.94%", @"5.05%", @"4.16%",nil];
    self.array_5 = [NSArray arrayWithObjects:@"4.5%", @"4.5%", @"4.5%", @"4.5%", @"4.7%",
                    @"4.7%", @"4.7%", @"4.9%", @"4.9%", @"4.9%", @"4.7%", @"4.7%", @"4.7%",
                    @"4.7%", @"4.5%", @"4.5%", @"4.5%", @"4.5%", @"4.3%", @"4.3%", @"4.3%",
                    @"4.3%", @"4.05%", @"4.05%", @"4.05%", @"4.05%", @"3.87%", @"3.87%",
                    @"3.87%", @"3.87%", nil];
    self.array_6 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"25",@"30", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //创建数组
    [self creatDataArray];
    
    userContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    userContentView.contentSize = CGSizeMake(320, 530);
    [self.view addSubview:userContentView];
    
    //商业贷款
    [self addShangyeView];
    //公积金贷款
    [self addGongjiView];
    //组合型贷款
    [self addZuheView];

    //添加类型按钮
      //商贷
    shangDaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangDaiBtn.frame = CGRectMake(10, 15, 100, 47);
    [shangDaiBtn setImage:[UIImage imageNamed:@"jsq_over_01.png"] forState:UIControlStateNormal];
    [shangDaiBtn setImage:[UIImage imageNamed:@"jsq_on_01.png"] forState:UIControlStateSelected];
    [shangDaiBtn addTarget:self action:@selector(shangAction:) forControlEvents:UIControlEventTouchUpInside];
    //商贷按钮默认选中
    shangDaiBtn.selected = YES;
    [self shangAction:shangDaiBtn];
      //公积金
    gongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gongBtn.frame = CGRectMake(110, 15, 100, 47);
    [gongBtn setImage:[UIImage imageNamed:@"jsq_over_02.png"] forState:UIControlStateNormal];
    [gongBtn setImage:[UIImage imageNamed:@"jsq_on_02.png"] forState:UIControlStateSelected];
    [gongBtn addTarget:self action:@selector(gongAction:) forControlEvents:UIControlEventTouchUpInside];
      //组合
    zuHeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zuHeBtn.frame = CGRectMake(210, 15, 100, 47);
    [zuHeBtn setImage:[UIImage imageNamed:@"jsq_over_03.png"] forState:UIControlStateNormal];
    [zuHeBtn setImage:[UIImage imageNamed:@"jsq_on_03.png"] forState:UIControlStateSelected];
    [zuHeBtn addTarget:self action:@selector(zuHeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [userContentView addSubview:shangDaiBtn];
    [userContentView addSubview:gongBtn];
    [userContentView addSubview:zuHeBtn];
    
    //添加还款类型页面
    UIImageView * topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 62, 300, 59)];
    topImgView.image = [UIImage imageNamed:@"top_01.png"];
    topImgView.userInteractionEnabled = YES;
    [userContentView addSubview:topImgView];
    //视图添加手势
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [topImgView addGestureRecognizer:singleFingerOne];
    //添加还款类型选择按钮
       //按钮一
    oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.frame = CGRectMake(100, 5, 20, 20);
    [oneBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [oneBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topImgView addSubview:oneBtn];
    oneBtn.selected = YES;
    [self oneBtnAction:oneBtn];
       //按钮二
    twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.frame = CGRectMake(200, 5, 20, 20);
    [twoBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [twoBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [twoBtn addTarget:self action:@selector(twoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [topImgView addSubview:twoBtn];
    
    //添加弹出视图层
    [self creatPopView];
}

//添加弹出视图层
-(void)creatPopView
{
    //列表所需数组
    tabArray = [[NSMutableArray alloc]initWithCapacity:0];
    //背景层
    coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    coverView.hidden = YES;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.3;
    [self.view addSubview:coverView];
    //显示视图
    popIMgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 304, 288)];
    popIMgview.hidden = YES;
    popIMgview.center = self.view.center;
    popIMgview.userInteractionEnabled = YES;
    popIMgview.image = [UIImage imageNamed:@"appear_03.png"];
    [self.view addSubview:popIMgview];
    //添加列表
    popTableView = [[UITableView alloc] initWithFrame:CGRectMake(2, 41, 298, 198) style:UITableViewStylePlain];
    popTableView.delegate = self;
    popTableView.dataSource = self;
    popTableView.tableFooterView = [[UIView alloc] init];
    [popIMgview addSubview:popTableView];
    //标题栏
    popLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 5, 240, 30)];
    popLabel.backgroundColor = [UIColor clearColor];
    [popIMgview addSubview:popLabel];
    //按钮
    //控制按钮
    UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaoBtn.frame = CGRectMake(5, 240, 143, 43);
    [quxiaoBtn setImage:[UIImage imageNamed:@"appear_05.png"] forState:UIControlStateNormal];
    [quxiaoBtn setImage:[UIImage imageNamed:@"appear_65.png"] forState:UIControlStateHighlighted];
    [quxiaoBtn addTarget:self action:@selector(fsalAction:) forControlEvents:UIControlEventTouchUpInside];
    [popIMgview addSubview:quxiaoBtn];
    
    UIButton * quedingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quedingBtn.frame = CGRectMake(152, 240, 143, 43);
    [quedingBtn setImage:[UIImage imageNamed:@"appear_08.png"] forState:UIControlStateNormal];
    [quedingBtn setImage:[UIImage imageNamed:@"appear_80.png"] forState:UIControlStateHighlighted];
    [quedingBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [popIMgview addSubview:quedingBtn];
}

#pragma mark -------Tab Dele-------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tabArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    cell.textLabel.text = self.tabArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    xianString = [tabArray objectAtIndex:indexPath.row];
}

//取消和确定按钮
-(void)fsalAction:(UIButton *)btn
{
    popIMgview.hidden = YES;
    coverView.hidden = YES;
}
-(void)sureAction:(UIButton *)btn
{
    popIMgview.hidden = YES;
    coverView.hidden = YES;
    if ([popType isEqualToString:@"商贷按揭成数"]) {
        if (xianString.length>0) {
            shangDanCheng.text = xianString;
        }
    }
    if ([popType isEqualToString:@"商贷按揭年数"]) {
        if (xianString.length>0) {
            shangDanNian.text = xianString;
        }
    }
    if ([popType isEqualToString:@"商贷按揭利率"]) {
        if (xianString.length>0) {
            shangDanLiLv.text = xianString;
            int a = [array_3 indexOfObject:xianString];
            label_1.text = [array_4 objectAtIndex:a];
        }
    }
    if ([popType isEqualToString:@"商贷总价按揭成数"]) {
        if (xianString.length>0) {
            shangZongNian.text = xianString;
        }
    }
    if ([popType isEqualToString:@"商贷总价按揭利率"]) {
        if (xianString.length>0) {
            shangZongLiLv.text = xianString;
            int a = [array_3 indexOfObject:xianString];
            label_2.text = [array_4 objectAtIndex:a];
        }
    }
    if ([popType isEqualToString:@"公积金按揭成数"]) {
        if (xianString.length>0) {
            gongDanCheng.text = xianString;
        }
    }
    if ([popType isEqualToString:@"公积金按揭年数"]) {
        if (xianString.length>0) {
            gongDanNian.text = xianString;
        }
    }
    if ([popType isEqualToString:@"公积金按揭利率"]) {
        if (xianString.length>0) {
            gongDanLiLv.text = xianString;
            int a = [array_3 indexOfObject:xianString];
            label_3.text = [array_5 objectAtIndex:a];
        }
    }
    if ([popType isEqualToString:@"公积金总价按揭年数"]) {
        if (xianString.length>0) {
            gongZongNian.text = xianString;
        }
    }
    if ([popType isEqualToString:@"公积金总价按揭利率"]) {
        if (xianString.length>0) {
            gongZongLiLv.text = xianString;
            int a = [array_3 indexOfObject:xianString];
            label_4.text = [array_4 objectAtIndex:a];
        }
    }
    if ([popType isEqualToString:@"组合型按揭年数"]) {
        if (xianString.length>0) {
            zuHeNian.text = xianString;
        }
    }
    if ([popType isEqualToString:@"组合型按揭利率"]) {
        if (xianString.length>0) {
            zuHeLiLv.text = xianString;
            int a = [array_3 indexOfObject:xianString];
            label_5.text = [NSString stringWithFormat:@"公积金贷款利率%@",[array_5 objectAtIndex:a]];
            label_6.text = [NSString stringWithFormat:@"商业贷款利率%@",[array_4 objectAtIndex:a]];
        }
    }
}

//商业贷款
-(void)addShangyeView
{
    shangDaiView = [[UIView alloc]init];
    shangDaiView.hidden = YES;
    shangDaiView.frame = CGRectMake(10, 62+59, 300, 500);
    shangDaiView.backgroundColor = [UIColor clearColor];
    
    //添加房款计价方式
    UIImageView * twoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 45)];
    twoImgView.image = [UIImage imageNamed:@"top_02.png"];
    twoImgView.userInteractionEnabled = YES;
    [shangDaiView addSubview:twoImgView];

    //视图添加手势
    UITapGestureRecognizer *singOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singOne.numberOfTouchesRequired = 1; //手指数
    singOne.numberOfTapsRequired = 1; //tap次数
    singOne.delegate = self;
    [twoImgView addGestureRecognizer:singOne];
    //添加计价方式按钮
       //按照单价
    shangDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangDanBtn.frame = CGRectMake(100, 12, 20, 20);
    [shangDanBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [shangDanBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [shangDanBtn addTarget:self action:@selector(danBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [twoImgView addSubview:shangDanBtn];
       //按照总价
    shangZongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangZongBtn.frame = CGRectMake(200, 12, 20, 20);
    [shangZongBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [shangZongBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [shangZongBtn addTarget:self action:@selector(zongBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [twoImgView addSubview:shangZongBtn];
    
    [userContentView addSubview:shangDaiView];
    //单价计算详细页面
    sonShangView_one = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 300, 368)];
    sonShangView_one.backgroundColor = [UIColor clearColor];
    sonShangView_one.hidden = YES;
    [shangDaiView addSubview:sonShangView_one];

    UIImageView * oneImgView_shang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 268)];
    oneImgView_shang.userInteractionEnabled = YES;
    oneImgView_shang.image = [UIImage imageNamed:@"danview.png"];
    [sonShangView_one addSubview:oneImgView_shang];

    //视图添加手势
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [oneImgView_shang addGestureRecognizer:singleFingerOne];
    
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(42, 288, 216, 45);
    [shangOneBtn setImage:[UIImage imageNamed:@"button_js.png"] forState:UIControlStateNormal];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_one addSubview:shangOneBtn];
    //添加输入部分信息
        //单价部分
    UIImageView * inputImg_dan_one = [[UIImageView alloc]initWithFrame:CGRectMake(110, 7, 92, 30)];
    inputImg_dan_one.userInteractionEnabled = YES;
    inputImg_dan_one.image = [UIImage imageNamed:@"input.png"];
    [sonShangView_one addSubview:inputImg_dan_one];

    shangJiaGe = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    shangJiaGe.borderStyle = UITextBorderStyleNone;
    shangJiaGe.backgroundColor = [UIColor clearColor];
    shangJiaGe.keyboardType = UIKeyboardTypeDecimalPad;
    shangJiaGe.autocapitalizationType = UITextAutocapitalizationTypeNone;
    shangJiaGe.font = [UIFont systemFontOfSize:15];
    shangJiaGe.textAlignment = NSTextAlignmentCenter;
    [shangJiaGe setUserInteractionEnabled:YES];
    shangJiaGe.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_dan_one addSubview:shangJiaGe];

    
        //面积部分
    UIImageView * inputImg_dan_two = [[UIImageView alloc]initWithFrame:CGRectMake(110, 52, 92, 30)];
    inputImg_dan_two.userInteractionEnabled = YES;
    inputImg_dan_two.image = [UIImage imageNamed:@"input.png"];
    [sonShangView_one addSubview:inputImg_dan_two];

    shangMianJi = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    shangMianJi.borderStyle = UITextBorderStyleNone;
    shangMianJi.backgroundColor = [UIColor clearColor];
    shangMianJi.keyboardType = UIKeyboardTypeDecimalPad;
    shangMianJi.autocapitalizationType = UITextAutocapitalizationTypeNone;
    shangMianJi.font = [UIFont systemFontOfSize:15];
    shangMianJi.textAlignment = NSTextAlignmentCenter;
    [shangMianJi setUserInteractionEnabled:YES];
    shangMianJi.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_dan_two addSubview:shangMianJi];

    
       //按揭成数
    UIButton * btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne.frame = CGRectMake(110, 97, 167, 30);
    btnOne.tag = 1;
    [btnOne setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_one addSubview:btnOne];
    shangDanCheng = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    shangDanCheng.textAlignment = NSTextAlignmentCenter;
    shangDanCheng.backgroundColor = [UIColor clearColor];
    shangDanCheng.text = [array_1 objectAtIndex:0];
    shangDanCheng.font = [UIFont systemFontOfSize:16];
    [btnOne addSubview:shangDanCheng];

       //按揭年数
    UIButton * btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.frame = CGRectMake(110, 142, 167, 30);
    btnTwo.tag = 2;
    [btnTwo setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_one addSubview:btnTwo];
    shangDanNian = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    shangDanNian.textAlignment = NSTextAlignmentCenter;
    shangDanNian.backgroundColor = [UIColor clearColor];
    shangDanNian.text = [array_2 objectAtIndex:0];
    shangDanNian.font = [UIFont systemFontOfSize:16];
    [btnTwo addSubview:shangDanNian];

       //利率
    UIButton * btnTre = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTre.frame = CGRectMake(110, 187, 167, 30);
    btnTre.tag = 3;
    [btnTre setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnTre addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_one addSubview:btnTre];
    shangDanLiLv = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    shangDanLiLv.textAlignment = NSTextAlignmentCenter;
    shangDanLiLv.backgroundColor = [UIColor clearColor];
    shangDanLiLv.text = [array_3 objectAtIndex:0];
    shangDanLiLv.font = [UIFont systemFontOfSize:12];
    [btnTre addSubview:shangDanLiLv];

        //显示利率
    label_1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 230, 167, 25)];
    label_1.font = [UIFont systemFontOfSize:16];
    label_1.text = [array_4 objectAtIndex:0];
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.backgroundColor = [UIColor clearColor];
    [sonShangView_one addSubview:label_1];

    
    //总价计算详细页面
    sonShangView_two = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 300, 288)];
    sonShangView_two.backgroundColor = [UIColor clearColor];
    sonShangView_two.hidden = YES;
    [shangDaiView addSubview:sonShangView_two];

    UIImageView * twoImgView_shang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 188)];
    twoImgView_shang.userInteractionEnabled = YES;
    twoImgView_shang.image = [UIImage imageNamed:@"zongview.png"];
    [sonShangView_two addSubview:twoImgView_shang];

    //视图添加手势
    UITapGestureRecognizer *singleZong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleZong.numberOfTouchesRequired = 1; //手指数
    singleZong.numberOfTapsRequired = 1; //tap次数
    singleZong.delegate = self;
    [twoImgView_shang addGestureRecognizer:singleZong];
    //贷款总额输入部分
    UIImageView * inputImg_zong = [[UIImageView alloc]initWithFrame:CGRectMake(110, 8, 92, 30)];
    inputImg_zong.userInteractionEnabled = YES;
    inputImg_zong.image = [UIImage imageNamed:@"input.png"];
    [sonShangView_two addSubview:inputImg_zong];

    shangZong = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    shangZong.borderStyle = UITextBorderStyleNone;
    shangZong.backgroundColor = [UIColor clearColor];
    shangZong.keyboardType = UIKeyboardTypeDecimalPad;
    shangZong.autocapitalizationType = UITextAutocapitalizationTypeNone;
    shangZong.font = [UIFont systemFontOfSize:15];
    shangZong.textAlignment = NSTextAlignmentCenter;
    [shangZong setUserInteractionEnabled:YES];
    shangZong.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong addSubview:shangZong];

       //按揭年数
    UIButton * btnOne_one = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_one.frame = CGRectMake(110, 52, 167, 30);
    btnOne_one.tag = 4;
    [btnOne_one setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_one addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_two addSubview:btnOne_one];
    shangZongNian = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    shangZongNian.textAlignment = NSTextAlignmentCenter;
    shangZongNian.backgroundColor = [UIColor clearColor];
    shangZongNian.text = [array_2 objectAtIndex:0];
    shangZongNian.font = [UIFont systemFontOfSize:16];
    [btnOne_one addSubview:shangZongNian];

        //利率
    UIButton * btnOne_two = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_two.frame = CGRectMake(110, 96, 167, 30);
    btnOne_two.tag = 5;
    [btnOne_two setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_two addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_two addSubview:btnOne_two];
    shangZongLiLv = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    shangZongLiLv.textAlignment = NSTextAlignmentCenter;
    shangZongLiLv.backgroundColor = [UIColor clearColor];
    shangZongLiLv.text = [array_3 objectAtIndex:0];
    shangZongLiLv.font = [UIFont systemFontOfSize:12];
    [btnOne_two addSubview:shangZongLiLv];

    //显示利率
    label_2 = [[UILabel alloc]initWithFrame:CGRectMake(110, 137, 167, 25)];
    label_2.font = [UIFont systemFontOfSize:16];
    label_2.text = [array_4 objectAtIndex:0];
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.backgroundColor = [UIColor clearColor];
    [sonShangView_two addSubview:label_2];

    
    //添加按钮
    UIButton * shangTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangTwoBtn.frame = CGRectMake(42, 208, 216, 45);
    [shangTwoBtn setImage:[UIImage imageNamed:@"button_js.png"] forState:UIControlStateNormal];
    [shangTwoBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_two addSubview:shangTwoBtn];
    
    //默认选中按单价计算按钮
    shangDanBtn.selected = YES;
    [self danBtnAction:shangDanBtn];
}
//房款计算类型
-(void)danBtnAction:(UIButton *)btn
{
    shangDanBtn.selected = YES;
    shangZongBtn.selected = NO;
    sonShangView_one.hidden = NO;
    sonShangView_two.hidden = YES;
    suanType = @"单价计算";
    //回收键盘
    [shangZong resignFirstResponder];
}
-(void)zongBtnAction:(UIButton *)btn
{
    shangZongBtn.selected = YES;
    shangDanBtn.selected = NO;
    sonShangView_two.hidden = NO;
    sonShangView_one.hidden = YES;
    suanType = @"总价计算";
    //回收键盘
    [shangJiaGe resignFirstResponder];
    [shangMianJi resignFirstResponder];
}

#pragma mark ----------弹出视图按钮事件----------
-(void)chooseAction:(UIButton *)btn
{
    //回收键盘
    [self closeKeyBoad];
    switch (btn.tag) {
        case 1:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_1];
            }
            else{
                [tabArray addObjectsFromArray:array_1];
            }
            popType = @"商贷按揭成数";
            popLabel.text = @"按揭成数";
            [popTableView reloadData];
        }
            break;
        case 2:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_2];
            }
            else{
                [tabArray addObjectsFromArray:array_2];
            }
            popType = @"商贷按揭年数";
            popLabel.text = @"按揭年数";
            [popTableView reloadData];
        }
            break;
        case 3:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_3];
            }
            else{
                [tabArray addObjectsFromArray:array_3];
            }
            popType = @"商贷按揭利率";
            popLabel.text = @"按揭利率";
            [popTableView reloadData];
        }
            break;
        case 4:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_2];
            }
            else{
                [tabArray addObjectsFromArray:array_2];
            }
            popType = @"商贷总价按揭成数";
            popLabel.text = @"按揭成数";
            [popTableView reloadData];
        }
            break;
        case 5:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_3];
            }
            else{
                [tabArray addObjectsFromArray:array_3];
            }
            popType = @"商贷总价按揭利率";
            popLabel.text = @"按揭利率";
            [popTableView reloadData];
        }
            break;
        case 6:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_1];
            }
            else{
                [tabArray addObjectsFromArray:array_1];
            }
            popType = @"公积金按揭成数";
            popLabel.text = @"按揭成数";
            [popTableView reloadData];
        }
            break;
        case 7:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_2];
            }
            else{
                [tabArray addObjectsFromArray:array_2];
            }
            popType = @"公积金按揭年数";
            popLabel.text = @"按揭年数";
            [popTableView reloadData];
        }
            break;
        case 8:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_3];
            }
            else{
                [tabArray addObjectsFromArray:array_3];
            }
            popType = @"公积金按揭利率";
            popLabel.text = @"按揭利率";
            [popTableView reloadData];
        }
            break;
        case 9:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_2];
            }
            else{
                [tabArray addObjectsFromArray:array_2];
            }
            popType = @"公积金总价按揭年数";
            popLabel.text = @"按揭年数";
            [popTableView reloadData];
        }
            break;
        case 10:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_3];
            }
            else{
                [tabArray addObjectsFromArray:array_3];
            }
            popType = @"公积金总价按揭利率";
            popLabel.text = @"按揭利率";
            [popTableView reloadData];
        }
            break;
        case 11:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_2];
            }
            else{
                [tabArray addObjectsFromArray:array_2];
            }
            popType = @"组合型按揭年数";
            popLabel.text = @"按揭年数";
            [popTableView reloadData];
        }
            break;
        case 12:
        {
            if (tabArray.count>0) {
                [tabArray removeAllObjects];
                [tabArray addObjectsFromArray:array_3];
            }
            else{
                [tabArray addObjectsFromArray:array_3];
            }
            popType = @"组合型按揭利率";
            popLabel.text = @"按揭利率";
            [popTableView reloadData];
        }
            break;
        default:
            break;
    }
    
    popIMgview.hidden = NO;
    coverView.hidden = NO;
}

//公积金贷款
-(void)addGongjiView
{
    gongView = [[UIView alloc]init];
    gongView.hidden = YES;
    gongView.frame = CGRectMake(10, 62+59, 300, 500);
    gongView.backgroundColor = [UIColor clearColor];
    //添加房款计价方式
    UIImageView * twoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 45)];
    twoImgView.image = [UIImage imageNamed:@"top_02.png"];
    twoImgView.userInteractionEnabled = YES;
    [gongView addSubview:twoImgView];

    //视图添加手势
    UITapGestureRecognizer *singleFingerOne_smal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleFingerOne_smal.numberOfTouchesRequired = 1; //手指数
    singleFingerOne_smal.numberOfTapsRequired = 1; //tap次数
    singleFingerOne_smal.delegate = self;
    [twoImgView addGestureRecognizer:singleFingerOne_smal];
    //添加计价方式按钮
    //按照单价
    gongDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gongDanBtn.frame = CGRectMake(100, 12, 20, 20);
    [gongDanBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [gongDanBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [gongDanBtn addTarget:self action:@selector(gongDanAction:) forControlEvents:UIControlEventTouchUpInside];
    [twoImgView addSubview:gongDanBtn];
    //按照总价
    gongZongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gongZongBtn.frame = CGRectMake(200, 12, 20, 20);
    [gongZongBtn setImage:[UIImage imageNamed:@"option_02.png"] forState:UIControlStateNormal];
    [gongZongBtn setImage:[UIImage imageNamed:@"option_01.png"] forState:UIControlStateSelected];
    [gongZongBtn addTarget:self action:@selector(gongZongAction:) forControlEvents:UIControlEventTouchUpInside];
    [twoImgView addSubview:gongZongBtn];
    
    [userContentView addSubview:gongView];

    
    //单价计算详细页面
    sonGongView_one = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 300, 368)];
    sonGongView_one.backgroundColor = [UIColor clearColor];
    sonGongView_one.hidden = YES;
    [gongView addSubview:sonGongView_one];

    UIImageView * oneImgView_shang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 268)];
    oneImgView_shang.userInteractionEnabled = YES;
    oneImgView_shang.image = [UIImage imageNamed:@"danview.png"];
    [sonGongView_one addSubview:oneImgView_shang];

    //视图添加手势
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [oneImgView_shang addGestureRecognizer:singleFingerOne];
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(42, 288, 216, 45);
    [shangOneBtn setImage:[UIImage imageNamed:@"button_js.png"] forState:UIControlStateNormal];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_one addSubview:shangOneBtn];
    //添加输入部分信息
    //单价部分
    UIImageView * inputImg_zong_one = [[UIImageView alloc]initWithFrame:CGRectMake(110, 7, 92, 30)];
    inputImg_zong_one.userInteractionEnabled = YES;
    inputImg_zong_one.image = [UIImage imageNamed:@"input.png"];
    [sonGongView_one addSubview:inputImg_zong_one];

    gongJiaGe = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    gongJiaGe.borderStyle = UITextBorderStyleNone;
    gongJiaGe.backgroundColor = [UIColor clearColor];
    gongJiaGe.keyboardType = UIKeyboardTypeDecimalPad;
    gongJiaGe.autocapitalizationType = UITextAutocapitalizationTypeNone;
    gongJiaGe.font = [UIFont systemFontOfSize:15];
    gongJiaGe.textAlignment = NSTextAlignmentCenter;
    [gongJiaGe setUserInteractionEnabled:YES];
    gongJiaGe.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong_one addSubview:gongJiaGe];

    
    //面积部分
    UIImageView * inputImg_zong_two = [[UIImageView alloc]initWithFrame:CGRectMake(110, 52, 92, 30)];
    inputImg_zong_two.userInteractionEnabled = YES;
    inputImg_zong_two.image = [UIImage imageNamed:@"input.png"];
    [sonGongView_one addSubview:inputImg_zong_two];

    gongMianJi = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    gongMianJi.borderStyle = UITextBorderStyleNone;
    gongMianJi.backgroundColor = [UIColor clearColor];
    gongMianJi.keyboardType = UIKeyboardTypeDecimalPad;
    gongMianJi.autocapitalizationType = UITextAutocapitalizationTypeNone;
    gongMianJi.font = [UIFont systemFontOfSize:15];
    gongMianJi.textAlignment = NSTextAlignmentCenter;
    [gongMianJi setUserInteractionEnabled:YES];
    gongMianJi.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong_two addSubview:gongMianJi];


    //按揭成数
    UIButton * btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne.frame = CGRectMake(110, 97, 167, 30);
    btnOne.tag = 6;
    [btnOne setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_one addSubview:btnOne];
    gongDanCheng = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    gongDanCheng.textAlignment = NSTextAlignmentCenter;
    gongDanCheng.backgroundColor = [UIColor clearColor];
    gongDanCheng.text = [array_1 objectAtIndex:0];
    gongDanCheng.font = [UIFont systemFontOfSize:16];
    [btnOne addSubview:gongDanCheng];

    //按揭年数
    UIButton * btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.frame = CGRectMake(110, 142, 167, 30);
    btnTwo.tag = 7;
    [btnTwo setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_one addSubview:btnTwo];
    gongDanNian = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    gongDanNian.textAlignment = NSTextAlignmentCenter;
    gongDanNian.backgroundColor = [UIColor clearColor];
    gongDanNian.text = [array_2 objectAtIndex:0];
    gongDanNian.font = [UIFont systemFontOfSize:16];
    [btnTwo addSubview:gongDanNian];

    //利率
    UIButton * btnTre = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTre.frame = CGRectMake(110, 187, 167, 30);
    btnTre.tag = 8;
    [btnTre setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnTre addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_one addSubview:btnTre];
    gongDanLiLv = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    gongDanLiLv.textAlignment = NSTextAlignmentCenter;
    gongDanLiLv.backgroundColor = [UIColor clearColor];
    gongDanLiLv.text = [array_3 objectAtIndex:0];
    gongDanLiLv.font = [UIFont systemFontOfSize:12];
    [btnTre addSubview:gongDanLiLv];

    //显示利率
    label_3 = [[UILabel alloc]initWithFrame:CGRectMake(110, 230, 167, 25)];
    label_3.font = [UIFont systemFontOfSize:16];
    label_3.text = [array_5 objectAtIndex:0];
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.backgroundColor = [UIColor clearColor];
    [sonGongView_one addSubview:label_3];

    
    //总价计算详细页面
    sonGongView_two = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 300, 288)];
    sonGongView_two.backgroundColor = [UIColor clearColor];
    sonGongView_two.hidden = YES;
    [gongView addSubview:sonGongView_two];

    UIImageView * twoImgView_shang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 188)];
    twoImgView_shang.userInteractionEnabled = YES;
    twoImgView_shang.image = [UIImage imageNamed:@"zongview.png"];
    [sonGongView_two addSubview:twoImgView_shang];

    //视图添加手势
    UITapGestureRecognizer *singleZong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleZong.numberOfTouchesRequired = 1; //手指数
    singleZong.numberOfTapsRequired = 1; //tap次数
    singleZong.delegate = self;
    [twoImgView_shang addGestureRecognizer:singleZong];
    //贷款总额输入部分
    UIImageView * inputImg_zong = [[UIImageView alloc]initWithFrame:CGRectMake(110, 8, 92, 30)];
    inputImg_zong.userInteractionEnabled = YES;
    inputImg_zong.image = [UIImage imageNamed:@"input.png"];
    [sonGongView_two addSubview:inputImg_zong];

    gongZong = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    gongZong.borderStyle = UITextBorderStyleNone;
    gongZong.backgroundColor = [UIColor clearColor];
    gongZong.keyboardType = UIKeyboardTypeDecimalPad;
    gongZong.autocapitalizationType = UITextAutocapitalizationTypeNone;
    gongZong.font = [UIFont systemFontOfSize:15];
    gongZong.textAlignment = NSTextAlignmentCenter;
    [gongZong setUserInteractionEnabled:YES];
    gongZong.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong addSubview:gongZong];

    
    //按揭年数
    UIButton * btnOne_one = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_one.frame = CGRectMake(110, 52, 167, 30);
    btnOne_one.tag = 9;
    [btnOne_one setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_one addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_two addSubview:btnOne_one];
    gongZongNian = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    gongZongNian.textAlignment = NSTextAlignmentCenter;
    gongZongNian.backgroundColor = [UIColor clearColor];
    gongZongNian.text = [array_2 objectAtIndex:0];
    gongZongNian.font = [UIFont systemFontOfSize:16];
    [btnOne_one addSubview:gongZongNian];

    //利率
    UIButton * btnOne_two = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_two.frame = CGRectMake(110, 96, 167, 30);
    btnOne_two.tag = 10;
    [btnOne_two setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_two addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_two addSubview:btnOne_two];
    gongZongLiLv = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    gongZongLiLv.textAlignment = NSTextAlignmentCenter;
    gongZongLiLv.backgroundColor = [UIColor clearColor];
    gongZongLiLv.text = [array_3 objectAtIndex:0];
    gongZongLiLv.font = [UIFont systemFontOfSize:12];
    [btnOne_two addSubview:gongZongLiLv];

    //显示利率
    label_4 = [[UILabel alloc]initWithFrame:CGRectMake(110, 137, 167, 25)];
    label_4.font = [UIFont systemFontOfSize:16];
    label_4.text = [array_5 objectAtIndex:0];
    label_4.textAlignment = NSTextAlignmentCenter;
    label_4.backgroundColor = [UIColor clearColor];
    [sonGongView_two addSubview:label_4];

    
    //添加按钮
    UIButton * shangTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangTwoBtn.frame = CGRectMake(42, 208, 216, 45);
    [shangTwoBtn setImage:[UIImage imageNamed:@"button_js.png"] forState:UIControlStateNormal];
    [shangTwoBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_two addSubview:shangTwoBtn];
    
    //默认选中按单价选择按钮
    gongDanBtn.selected = YES;
    [self gongDanAction:gongDanBtn];
}
-(void)gongDanAction:(UIButton *)btn
{
    gongDanBtn.selected = YES;
    gongZongBtn.selected = NO;
    sonGongView_one.hidden = NO;
    sonGongView_two.hidden = YES;
    suanType = @"单价计算";
    //回收键盘
    [gongZong resignFirstResponder];
}
-(void)gongZongAction:(UIButton *)btn
{
    gongZongBtn.selected = YES;
    gongDanBtn.selected = NO;
    sonGongView_two.hidden = NO;
    sonGongView_one.hidden = YES;
    suanType = @"总价计算";
    //回收键盘
    [gongJiaGe resignFirstResponder];
    [gongMianJi resignFirstResponder];
}

//组合型贷款
-(void)addZuheView
{
    zuHeView = [[UIView alloc]init];
    zuHeView.hidden = YES;
    zuHeView.frame = CGRectMake(10, 62+59, 300, 450);
    zuHeView.backgroundColor = [UIColor clearColor];
    [userContentView addSubview:zuHeView];

    //添加组合贷款页面
    UIImageView * zuHeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 259)];
    zuHeImgView.userInteractionEnabled = YES;
    zuHeImgView.image = [UIImage imageNamed:@"zuheimg.png"];
    [zuHeView addSubview:zuHeImgView];

    //视图添加手势
    UITapGestureRecognizer *singleZong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoad)];
    singleZong.numberOfTouchesRequired = 1; //手指数
    singleZong.numberOfTapsRequired = 1; //tap次数
    singleZong.delegate = self;
    [zuHeImgView addGestureRecognizer:singleZong];
    //公积金贷款输入部分
    UIImageView * inputImg_zong_one = [[UIImageView alloc]initWithFrame:CGRectMake(110, 8, 92, 30)];
    inputImg_zong_one.userInteractionEnabled = YES;
    inputImg_zong_one.image = [UIImage imageNamed:@"input.png"];
    [zuHeImgView addSubview:inputImg_zong_one];

    gongDai = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    gongDai.borderStyle = UITextBorderStyleNone;
    gongDai.backgroundColor = [UIColor clearColor];
    gongDai.keyboardType = UIKeyboardTypeDecimalPad;
    gongDai.autocapitalizationType = UITextAutocapitalizationTypeNone;
    gongDai.font = [UIFont systemFontOfSize:15];
    gongDai.textAlignment = NSTextAlignmentCenter;
    [gongDai setUserInteractionEnabled:YES];
    gongDai.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong_one addSubview:gongDai];

    //商业贷款输入部分
    UIImageView * inputImg_zong_two = [[UIImageView alloc]initWithFrame:CGRectMake(110, 52, 92, 30)];
    inputImg_zong_two.userInteractionEnabled = YES;
    inputImg_zong_two.image = [UIImage imageNamed:@"input.png"];
    [zuHeImgView addSubview:inputImg_zong_two];

    shangDai = [[UITextField alloc]initWithFrame:CGRectMake(1, 5, 90, 20)];
    shangDai.borderStyle = UITextBorderStyleNone;
    shangDai.backgroundColor = [UIColor clearColor];
    shangDai.keyboardType = UIKeyboardTypeDecimalPad;
    shangDai.autocapitalizationType = UITextAutocapitalizationTypeNone;
    shangDai.font = [UIFont systemFontOfSize:15];
    shangDai.textAlignment = NSTextAlignmentCenter;
    [shangDai setUserInteractionEnabled:YES];
    shangDai.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputImg_zong_two addSubview:shangDai];

       //按揭年数
    UIButton * btnOne_one = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_one.frame = CGRectMake(110, 98, 167, 30);
    btnOne_one.tag = 11;
    [btnOne_one setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_one addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [zuHeImgView addSubview:btnOne_one];
    zuHeNian = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    zuHeNian.textAlignment = NSTextAlignmentCenter;
    zuHeNian.backgroundColor = [UIColor clearColor];
    zuHeNian.text = [array_2 objectAtIndex:0];
    zuHeNian.font = [UIFont systemFontOfSize:16];
    [btnOne_one addSubview:zuHeNian];

       //利率
    UIButton * btnOne_two = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne_two.frame = CGRectMake(110, 142, 167, 30);
    btnOne_two.tag = 12;
    [btnOne_two setImage:[UIImage imageNamed:@"selectlabel.png"] forState:UIControlStateNormal];
    [btnOne_two addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [zuHeImgView addSubview:btnOne_two];
    zuHeLiLv = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 135, 24)];
    zuHeLiLv.textAlignment = NSTextAlignmentCenter;
    zuHeLiLv.backgroundColor = [UIColor clearColor];
    zuHeLiLv.text = [array_3 objectAtIndex:0];
    zuHeLiLv.font = [UIFont systemFontOfSize:12];
    [btnOne_two addSubview:zuHeLiLv];

    //显示利率
    label_5 = [[UILabel alloc]initWithFrame:CGRectMake(110, 180, 167, 25)];
    label_5.font = [UIFont systemFontOfSize:14];
    label_5.text = [NSString stringWithFormat:@"公积金贷款利率%@",[array_5 objectAtIndex:0]];
    label_5.backgroundColor = [UIColor clearColor];
    [zuHeImgView addSubview:label_5];

    
    label_6 = [[UILabel alloc]initWithFrame:CGRectMake(110, 215, 167, 25)];
    label_6.font = [UIFont systemFontOfSize:14];
    label_6.text = [NSString stringWithFormat:@"商业贷款利率%@",[array_4 objectAtIndex:0]];
    label_6.backgroundColor = [UIColor clearColor];
    [zuHeImgView addSubview:label_6];

    
    //添加计算按钮
    UIButton * shangTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangTwoBtn.frame = CGRectMake(42, 279, 216, 45);
    [shangTwoBtn setImage:[UIImage imageNamed:@"button_js.png"] forState:UIControlStateNormal];
    [shangTwoBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [zuHeView addSubview:shangTwoBtn];
    
}

#pragma mark ------------按钮事件------------
//商贷按钮事件
-(void)shangAction:(UIButton *)btn
{
    shangDaiBtn.selected = YES;
    gongBtn.selected = NO;
    zuHeBtn.selected = NO;
    shangDaiView.hidden = NO;
    gongView.hidden = YES;
    zuHeView.hidden = YES;
    jiSuanType = @"商业贷款";
    //回收键盘
    [gongJiaGe resignFirstResponder];
    [gongMianJi resignFirstResponder];
    [gongZong resignFirstResponder];
    [gongDai resignFirstResponder];
    [shangDai resignFirstResponder];
}
//公积金按钮事件
-(void)gongAction:(UIButton *)btn
{
    gongBtn.selected = YES;
    shangDaiBtn.selected = NO;
    zuHeBtn.selected = NO;
    gongView.hidden = NO;
    shangDaiView.hidden = YES;
    zuHeView.hidden = YES;
    jiSuanType = @"公积金贷款";
    //回收键盘
    [shangJiaGe resignFirstResponder];
    [shangMianJi resignFirstResponder];
    [shangZong resignFirstResponder];
    [gongDai resignFirstResponder];
    [shangDai resignFirstResponder];
}
//组合型按钮事件
-(void)zuHeAction:(UIButton *)btn
{
    zuHeBtn.selected = YES;
    shangDaiBtn.selected = NO;
    gongBtn.selected = NO;
    zuHeView.hidden = NO;
    shangDaiView.hidden = YES;
    gongView.hidden = YES;
    jiSuanType = @"组合型贷款";
    //回收键盘
    [shangJiaGe resignFirstResponder];
    [shangMianJi resignFirstResponder];
    [shangZong resignFirstResponder];
    [gongJiaGe resignFirstResponder];
    [gongMianJi resignFirstResponder];
    [gongZong resignFirstResponder];
}
//还款类型
-(void)oneBtnAction:(UIButton *)btn
{
    oneBtn.selected = YES;
    twoBtn.selected = NO;
    huanKuanType = @"等额本息";
}
-(void)twoBtnAction:(UIButton *)btn
{
    twoBtn.selected = YES;
    oneBtn.selected = NO;
    huanKuanType = @"等额本金";
}

//计算结果
-(void)jiSuanAction:(UIButton *)btn
{
    NSString * resultType;
    if ([jiSuanType isEqualToString:@"组合型贷款"]) {
        resultType = [NSString stringWithFormat:@"%@%@",jiSuanType,huanKuanType];
    }
    else{
        resultType = [NSString stringWithFormat:@"%@%@%@",jiSuanType,huanKuanType,suanType];
    }
    /*
     * 商业贷款数据的计算
     */
    if ([resultType isEqualToString:@"商业贷款等额本息单价计算"]) {
        if (shangJiaGe.text.length==0 && shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangMianJi.text.length==0 && shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangJiaGe.text.length==0 && shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            float jiaGe = [shangJiaGe.text floatValue];//单价
            float mianJi = [shangMianJi.text floatValue];//面积
            int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNian.text]] intValue];
            float cheng = [[shangDanCheng.text substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
            float liLv = [label_1.text floatValue]/100;//利率
            float zongJia = jiaGe * mianJi;//房屋总价
            float daiKuan = zongJia * cheng;//贷款总额
            float shouYue = zongJia-daiKuan;//首月还款
            int yueShu = nian*12;//贷款月数
            float yueLilv = liLv/12;
            float yueHuan = daiKuan*yueLilv*powf(1+yueLilv, yueShu)/(powf(1+yueLilv, yueShu)-1);//每月还款
            float zongHuan = yueHuan*yueShu;//还款总额
            float huanLi = zongHuan-daiKuan;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首月还款",@"贷款月数",@"月均还款", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongJia];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",daiKuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str4 = [NSString stringWithFormat:@"%.2f 元",huanLi];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",shouYue];
            NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSString * str7 = [NSString stringWithFormat:@"%.2f 元",yueHuan];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,str7, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.xianType = @"1";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金单价计算"]) {
        if (shangJiaGe.text.length==0 && shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangMianJi.text.length==0 && shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangJiaGe.text.length==0 && shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            //每月还款数组
            NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
            //月数数组
            NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
            float jiaGe = [shangJiaGe.text floatValue];//单价
            float mianJi = [shangMianJi.text floatValue];//面积
            int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNian.text]] intValue];
            int yueShu = nian*12;//贷款月数
            float cheng = [[shangDanCheng.text substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
            float liLv = [label_1.text floatValue]/100;//利率
            float yueJun = jiaGe*mianJi*cheng/(nian*12);//每月所还本金
            float yueLilv = liLv/12;//月利率
            float zongJia = jiaGe*mianJi;//房款总额
            float daiZong = zongJia*cheng;//贷款总额
            float zongHuan = 0.0;//还款总额
            for (int i=0; i<nian*12; i++) {
                float yueHuan = yueJun+(jiaGe*mianJi*cheng-yueJun*i)*yueLilv;
                NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",yueHuan];
                NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
                [array4 addObject:strKuan];
                [array3 addObject:strYue];
                zongHuan+=yueHuan;
            }
            float zhiLi = zongHuan-daiZong;//支付利息
            float shouFu = zongJia-daiZong;//首期付款
            NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首期付款",@"还款月数", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongJia];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str4 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",shouFu];
            NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.nameArray_2 = array3;
            fvc.dataArray_2 = array4;
            fvc.xianType = @"2";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本息总价计算"]) {
        if (shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            float daiZong = [shangZong.text floatValue]*10000;//贷款总额
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:shangZongNian.text]] intValue]*12;//贷款月数
            float liLv = [label_2.text floatValue]/100;//利率
            float yueLilv = liLv/12;//月利率
            float yueHuan = daiZong*yueLilv*powf(1+yueLilv, yueShu)/(powf(1+yueLilv, yueShu)-1);//每月还款
            float zongHuan = yueHuan * yueShu;//还款总额
            float huanLi = zongHuan-daiZong;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",huanLi];
            NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",yueHuan];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.xianType = @"1";
            [self.navigationController pushViewController:fvc animated:YES];

            
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金总价计算"]) {
        if (shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            //每月还款数组
            NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
            //月数数组
            NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
            float daiZong = [shangZong.text floatValue]*10000;//贷款总额
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:shangZongNian.text]] intValue]*12;//贷款月数
            float liLv = [label_2.text floatValue]/100;//利率
            float yueLilv = liLv/12;//月利率
            float yueJun = daiZong/yueShu;//月还本金
            float zongHuan = 0.0;//还款总额
            for (int i=0; i<yueShu; i++) {
                float yueHuan = yueJun+(daiZong-yueJun*i)*yueLilv;
                NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",yueHuan];
                NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
                [array4 addObject:strKuan];
                [array3 addObject:strYue];
                zongHuan+=yueHuan;
            }
            float zhiLi = zongHuan-daiZong;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.nameArray_2 = array3;
            fvc.dataArray_2 = array4;
            fvc.xianType = @"2";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    /*
     * 公积金贷款数据的计算
     */
    if ([resultType isEqualToString:@"公积金贷款等额本息单价计算"]) {
        if (gongJiaGe.text.length==0 && gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongMianJi.text.length==0 && gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongJiaGe.text.length==0 && gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            float jiaGe = [gongJiaGe.text floatValue];//单价
            float mianJi = [gongMianJi.text floatValue];//面积
            int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNian.text]] intValue];
            float cheng = [[gongDanCheng.text substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
            float liLv = [label_3.text floatValue]/100;//利率
            float zongJia = jiaGe * mianJi;//房屋总价
            float daiKuan = zongJia * cheng;//贷款总额
            float shouYue = zongJia-daiKuan;//首月还款
            int yueShu = nian*12;//贷款月数
            float yueLilv = liLv/12;
            float yueHuan = daiKuan*yueLilv*powf(1+yueLilv, yueShu)/(powf(1+yueLilv, yueShu)-1);//每月还款
            float zongHuan = yueHuan*yueShu;//还款总额
            float huanLi = zongHuan-daiKuan;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首月还款",@"贷款月数",@"月均还款", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongJia];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",daiKuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str4 = [NSString stringWithFormat:@"%.2f 元",huanLi];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",shouYue];
            NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSString * str7 = [NSString stringWithFormat:@"%.2f 元",yueHuan];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,str7, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.xianType = @"1";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金单价计算"]) {
        if (gongJiaGe.text.length==0 && gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongMianJi.text.length==0 && gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongJiaGe.text.length==0 && gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            //每月还款数组
            NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
            //月数数组
            NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
            float jiaGe = [gongJiaGe.text floatValue];//单价
            float mianJi = [gongMianJi.text floatValue];//面积
            int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNian.text]] intValue];
            int yueShu = nian*12;//贷款月数
            float cheng = [[gongDanCheng.text substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
            float liLv = [label_3.text floatValue]/100;//利率
            float yueJun = jiaGe*mianJi*cheng/(nian*12);//每月所还本金
            float yueLilv = liLv/12;//月利率
            float zongJia = jiaGe*mianJi;//房款总额
            float daiZong = zongJia*cheng;//贷款总额
            float zongHuan = 0.0;//还款总额
            for (int i=0; i<nian*12; i++) {
                float yueHuan = yueJun+(jiaGe*mianJi*cheng-yueJun*i)*yueLilv;
                NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",yueHuan];
                NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
                [array4 addObject:strKuan];
                [array3 addObject:strYue];
                zongHuan+=yueHuan;
            }
            float zhiLi = zongHuan-daiZong;//支付利息
            float shouFu = zongJia-daiZong;//首期付款
            NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首期付款",@"还款月数", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongJia];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str4 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",shouFu];
            NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.nameArray_2 = array3;
            fvc.dataArray_2 = array4;
            fvc.xianType = @"2";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本息总价计算"]) {
        if (gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            float daiZong = [gongZong.text floatValue]*10000;//贷款总额
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:gongZongNian.text]] intValue]*12;//贷款月数
            float liLv = [label_4.text floatValue]/100;//利率
            float yueLilv = liLv/12;//月利率
            float yueHuan = daiZong*yueLilv*powf(1+yueLilv, yueShu)/(powf(1+yueLilv, yueShu)-1);//每月还款
            float zongHuan = yueHuan * yueShu;//还款总额
            float huanLi = zongHuan-daiZong;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",huanLi];
            NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",yueHuan];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.xianType = @"1";
            [self.navigationController pushViewController:fvc animated:YES];

            
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金总价计算"]) {
        if (gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            //每月还款数组
            NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
            //月数数组
            NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
            float daiZong = [gongZong.text floatValue]*10000;//贷款总额
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:gongZongNian.text]] intValue]*12;//贷款月数
            float liLv = [label_4.text floatValue]/100;//利率
            float yueLilv = liLv/12;//月利率
            float yueJun = daiZong/yueShu;//月还本金
            float zongHuan = 0.0;//还款总额
            for (int i=0; i<yueShu; i++) {
                float yueHuan = yueJun+(daiZong-yueJun*i)*yueLilv;
                NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",yueHuan];
                NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
                [array4 addObject:strKuan];
                [array3 addObject:strYue];
                zongHuan+=yueHuan;
            }
            float zhiLi = zongHuan-daiZong;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",daiZong];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.nameArray_2 = array3;
            fvc.dataArray_2 = array4;
            fvc.xianType = @"2";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    /*
     * 组合型贷款数据的计算
     */
    if ([resultType isEqualToString:@"组合型贷款等额本息"]) {
        if (gongDai.text.length==0 && shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangDai.text.length==0 && gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongDai.text.length==0 && shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            float gongKuan = [gongDai.text floatValue]*10000;//公积金贷款
            float shangKuan = [shangDai.text floatValue]*10000;//商业贷款
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:zuHeNian.text]] intValue]*12;//贷款月数
            //字符串替换
            NSString * gongStr = label_5.text;
            NSString * shangStr = label_6.text;
            NSString * tem1 = @"公积金贷款利率";
            NSString * tem2 = @"商业贷款利率";
            NSString * replace = @"";
            NSRange rang1 = [gongStr rangeOfString:tem1];
            NSRange rang2 = [shangStr rangeOfString:tem2];
            NSString * newOne = [gongStr stringByReplacingCharactersInRange:rang1 withString:replace];
            NSString * newTwo = [shangStr stringByReplacingCharactersInRange:rang2 withString:replace];
            float gongLilv = [newOne floatValue]/100/12;//公积金贷款利率
            float shangLilv = [newTwo floatValue]/100/12;//商业贷款利率
            float zongDai = gongKuan + shangKuan;//贷款总额
            float yueHuan = gongKuan*gongLilv*powf(1+gongLilv, yueShu)/(powf(1+gongLilv, yueShu)-1)+shangKuan*shangLilv*powf(1+shangLilv, yueShu)/(powf(1+shangLilv, yueShu)-1);//每月还款
            float zongHuan = yueHuan*yueShu;//还款总额
            float zhiLi = zongHuan-zongDai;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongDai];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str4 = [NSString stringWithFormat:@"%d",yueShu];
            NSString * str5 = [NSString stringWithFormat:@"%.2f 元",yueHuan];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.xianType = @"1";
            [self.navigationController pushViewController:fvc animated:YES];

        }
    }
    if ([resultType isEqualToString:@"组合型贷款等额本金"]) {
        if (gongDai.text.length==0 && shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (shangDai.text.length==0 && gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else if (gongDai.text.length==0 && shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
        else{
            //每月还款数组
            NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
            //月数数组
            NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
            float gongKuan = [gongDai.text floatValue]*10000;//公积金贷款
            float shangKuan = [shangDai.text floatValue]*10000;//商业贷款
            int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:zuHeNian.text]] intValue]*12;//贷款月数
            //字符串替换
            NSString * gongStr = label_5.text;
            NSString * shangStr = label_6.text;
            NSString * tem1 = @"公积金贷款利率";
            NSString * tem2 = @"商业贷款利率";
            NSString * replace = @"";
            NSRange rang1 = [gongStr rangeOfString:tem1];
            NSRange rang2 = [shangStr rangeOfString:tem2];
            NSString * newOne = [gongStr stringByReplacingCharactersInRange:rang1 withString:replace];
            NSString * newTwo = [shangStr stringByReplacingCharactersInRange:rang2 withString:replace];
            float gongLilv = [newOne floatValue]/100/12;//公积金贷款利率
            float shangLilv = [newTwo floatValue]/100/12;//商业贷款利率
            float zongDai = gongKuan + shangKuan;//贷款总额
            float gongJun = gongKuan/yueShu;//公积金贷款每月所还本金
            float shangJun = shangKuan/yueShu;//商业贷款每月所还本金
            float zongHuan = 0.0;//还款总额
            for (int i=0; i<yueShu; i++) {
                float yueHuan = gongJun+(gongKuan-gongJun*i)*gongLilv+shangJun+(shangKuan-shangJun*i)*shangLilv;
                NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",yueHuan];
                NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
                [array4 addObject:strKuan];
                [array3 addObject:strYue];
                zongHuan+=yueHuan;
            }
            float zhiLi = zongHuan-zongDai;//支付利息
            NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数", nil];
            NSString * str1 = [NSString stringWithFormat:@"%.2f 元",zongDai];
            NSString * str2 = [NSString stringWithFormat:@"%.2f 元",zongHuan];
            NSString * str3 = [NSString stringWithFormat:@"%.2f 元",zhiLi];
            NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
            NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4, nil];
            FangResultViewController * fvc = [[FangResultViewController alloc]init];
            fvc.nameArray_1 = array1;
            fvc.dataArray_1 = array2;
            fvc.nameArray_2 = array3;
            fvc.dataArray_2 = array4;
            fvc.xianType = @"2";
            [self.navigationController pushViewController:fvc animated:YES];
            
        }
    }
}

//回收键盘
-(void)closeKeyBoad
{
    [shangJiaGe resignFirstResponder];
    [shangMianJi resignFirstResponder];
    [shangZong resignFirstResponder];
    [gongJiaGe resignFirstResponder];
    [gongMianJi resignFirstResponder];
    [gongZong resignFirstResponder];
    [gongDai resignFirstResponder];
    [shangDai resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
