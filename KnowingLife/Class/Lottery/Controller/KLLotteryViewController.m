//
//  LotteryViewController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/31.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLLotteryViewController.h"
#import "UIBarButtonItem+WB.h"

@interface KLLotteryViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView* indicator;
@end

#define LotteryUrl @"http://caipiao.163.com/t/"
@implementation KLLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" target:self action:@selector(Canccel)];
    
    // 添加webview
    [self setupWebview];
    
    // 添加UIActivityIndicatorView
    [self setupActivityIndicator];
    
    // 加载网页
    [self loadWebViewUrl:LotteryUrl];
}

#pragma mark setupViews
// 添加webview
- (void)setupWebview
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.delegate = self;
}

- (void)setupActivityIndicator
{
    //初始化:
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //设置显示位置
    [indicator setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    
    //设置背景色
    indicator.backgroundColor = [UIColor grayColor];
    
    //设置背景透明
    indicator.alpha = 0.5;
    
    //设置背景为圆角矩形
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    
    [self.view addSubview:indicator];
    self.indicator = indicator;
    self.indicator.hidden = YES;
}

// 加载网页
- (void)loadWebViewUrl:(NSString *)strUrl
{
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

#pragma mark navItem action
// 后退
- (void)Canccel
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
}


#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
    self.indicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
    
}

- (void)dealloc
{
    self.webView.delegate = nil;
    //self.webView = nil;
    KLLog(@"KLLotteryViewController dealloc");
}

@end
