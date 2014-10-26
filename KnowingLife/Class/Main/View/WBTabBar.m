//
//  WBTabbar.m
//  XinWeibo
//
//  Created by tanyang on 14-10-6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBTabBar.h"
#import "UIImage+WB.h"
#import "WBTabBarButton.h"

@interface WBTabBar()
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, strong) NSMutableArray *arrButton;
@end
@implementation WBTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!ios7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}


- (NSMutableArray *)arrButton
{
    if (_arrButton == nil) {
        _arrButton = [NSMutableArray array];
    }
    return _arrButton;
}

- (void)addButtonWithItem:(UITabBarItem *)item
{
    // 创建按钮
    WBTabBarButton *button = [[WBTabBarButton alloc]init];
    [self addSubview:button];
    [self.arrButton addObject:button];
    
    button.item = item;
    // 点击监听
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    
    if (self.arrButton.count == 1) {
        [self clickButton:button];
    }
}

- (void)clickButton:(UIButton *)button
{
    // 通知代理点击了哪个
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonfrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonfrom:self.selectButton.tag to:button.tag];
    }
    // 点击按钮状态改变
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

// 子视图布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"%@",self.subviews);
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.arrButton.count; index++) {
        // 1.取出按钮
        WBTabBarButton *button = self.arrButton[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;

        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
