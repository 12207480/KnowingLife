//
//  KLComment.h
//  KnowingLife
//
//  Created by tanyang on 14/10/26.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#ifndef KnowingLife_KLComment_h
#define KnowingLife_KLComment_h

#import "UIImage+WB.h"

// 判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获得RGB颜色
#define KLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 是否是4寸iPhone
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)

// collectionview背景颜色
#define KLCollectionBkgCollor KLColor(231, 231, 231);

// 自定义Log
#ifdef DEBUG
#define KLLog(...) NSLog(__VA_ARGS__)
#else
#define KLLog(...)
#endif

// 顶部菜单项的宽高
#define kTopMenuItemW 100
#define kTopMenuItemH 44

// 底部菜单项的宽高
#define kBottomMenuItemW 100
#define kBottomMenuItemH 60

// 通知
// 城市改变的通知
#define kCityChangeNote @"city_change"

// 城市的key
#define kCityKey @"city"

#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];


// 4.全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]


// 5.默认的动画时间
#define kDefaultAnimDuration 0.3


#endif
