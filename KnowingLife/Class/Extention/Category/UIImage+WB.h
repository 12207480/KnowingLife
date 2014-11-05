//
//  UIImage+UIImage_WB.h
//  XinWeibo
//
//  Created by tanyang on 14-10-6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_WB)
// 加载图片自动匹配ios6，7
+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
- (UIImage *)imageToSize:(CGSize) size;
@end
