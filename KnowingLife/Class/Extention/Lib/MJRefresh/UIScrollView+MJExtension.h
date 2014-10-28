//
//  UIScrollView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface UIScrollView (MJExtension)
@property (assign, nonatomic) CGFloat mj_contentInsetTop;
@property (assign, nonatomic) CGFloat mj_contentInsetBottom;
@property (assign, nonatomic) CGFloat mj_contentInsetLeft;
@property (assign, nonatomic) CGFloat mj_contentInsetRight;

@property (assign, nonatomic) CGFloat mj_contentOffsetX;
@property (assign, nonatomic) CGFloat mj_contentOffsetY;

@property (assign, nonatomic) CGFloat mj_contentSizeWidth;
@property (assign, nonatomic) CGFloat mj_contentSizeHeight;
@end
