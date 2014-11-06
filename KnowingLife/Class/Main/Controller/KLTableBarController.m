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
#import "KLNewsViewController.h"
#import "KLMoreViewController.h"
#import "ProductCollectionController.h"
#import "CSStickyHeaderFlowLayout.h"
#import "KLGroupBuyController.h"
#import "KLNewsMenuController.h"

@interface KLTableBarController ()<WBTabbarDekegate>
@property (nonatomic, weak) WBTabBar *customTabBar;
@property (nonatomic, weak) ProductCollectionController *life;
@property (nonatomic, weak) KLMoreViewController *more;
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
    
    if (to == 3) { // 点击更多
        //[self.home refreshData];
        // 传递数据
        self.more.weatherInfo = self.life.weatherInfo;
    }
}

- (void)setupAllChildViewControls
{
    // 首页控制器
    // 创建布局
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    // 设置cell尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 设置水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置垂直间距
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 170);
    layout.headerReferenceSize = CGSizeMake(200, 50);
    ProductCollectionController *life = [[ProductCollectionController alloc]initWithCollectionViewLayout:layout];
    //ProductCollectionController *life = [[ProductCollectionController alloc]init];
    //home.tabBarItem.badgeValue = @"20";
    [self addChildViewControl:life title:@"生活" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.life = life;
    
    // 新闻控制器
    KLNewsMenuController *news = [[KLNewsMenuController alloc]init];
    //msg.tabBarItem.badgeValue = @"30";
    [self addChildViewControl:news title:@"新闻" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 团购控制器
    KLGroupBuyController *discover = [[KLGroupBuyController alloc]init];
    //discover.tabBarItem.badgeValue = @"60";
    [self addChildViewControl:discover title:@"团购" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 更多控制器
    KLMoreViewController *more = [[KLMoreViewController alloc]init];
    //me.tabBarItem.badgeValue = @"80";
    [self addChildViewControl:more title:@"更多" imageName:@"tabbar_more" selectedImageName:@"tabbar_more_selected"];
    self.more = more;
    
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
