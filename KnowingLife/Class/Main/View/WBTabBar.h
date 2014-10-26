//
//  WBTabbar.h
//  XinWeibo
//
//  Created by tanyang on 14-10-6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;
@protocol WBTabbarDekegate <NSObject>

@optional
- (void)tabBar:(WBTabBar *)tabBar didSelectedButtonfrom:(NSInteger)from to:(NSInteger)to;
@end

@interface WBTabBar : UIView
@property (nonatomic, weak) id<WBTabbarDekegate>delegate;

- (void)addButtonWithItem:(UITabBarItem *)item;
@end
