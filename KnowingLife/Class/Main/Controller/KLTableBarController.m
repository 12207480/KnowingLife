//
//  KLTableBarController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/26.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLTableBarController.h"
#import "UIImage+WB.h"
#import "WBTabBar.h"
#import "KLNavigationController.h"
#import "ViewController.h"

@interface KLTableBarController ()<WBTabbarDekegate>
@property (nonatomic, weak) WBTabBar *customTabBar;
@property (nonatomic, weak) ViewController *home;
@end

@implementation KLTableBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self setupTabBar];
    
    // 初始化所以子控制器
    [self setupAllChildViewControls];
}

- (void)setupTabBar
{
    WBTabBar *customTabBar = [[WBTabBar alloc]init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

// tabbar代理方法 点击了哪个
- (void)tabBar:(WBTabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    
    if (to == 0) { // 点击首页
        //[self.home refreshData];
    }
}

- (void)setupAllChildViewControls
{
    // 首页控制器
    ViewController *home = [[ViewController alloc]init];
    //home.tabBarItem.badgeValue = @"20";
    [self addChildViewControl:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 消息控制器
    ViewController *msg = [[ViewController alloc]init];
    //msg.tabBarItem.badgeValue = @"30";
    [self addChildViewControl:msg title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 广场控制器
    ViewController *discover = [[ViewController alloc]init];
    //discover.tabBarItem.badgeValue = @"60";
    [self addChildViewControl:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 我控制器
    ViewController *me = [[ViewController alloc]init];
    //me.tabBarItem.badgeValue = @"80";
    [self addChildViewControl:me title:@"更多" imageName:@"tabbar_more" selectedImageName:@"tabbar_more_selected"];
    
    
}

/**
 *  添加子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 被选中图片
 */
- (void)addChildViewControl:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题图片
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    if (ios7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else {
        childVc.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    }
    
    // 添加到导航控制器
    KLNavigationController *childVcNav = [[KLNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:childVcNav];
    // 添加自定义item
    [self.customTabBar addButtonWithItem:childVc.tabBarItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
