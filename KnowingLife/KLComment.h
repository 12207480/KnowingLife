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

#endif
