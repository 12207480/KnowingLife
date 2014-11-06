//
//  KLDetailWebInfoController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLDetailWebInfoController.h"
#import "KLDeal.h"

@interface KLDetailWebInfoController () <UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation KLDetailWebInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addWebView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_deal.deal_h5_url]]];
    
}

- (void)addWebView
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    KLLog(@"%@",webView.request.URL);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1.加载请求
        NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
        NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        });
}

- (void)dealloc
{
    KLLog(@"KLDetailWebInfoController dealloc");
    
    // 释放webview内存
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    self.webView.delegate = nil;
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
