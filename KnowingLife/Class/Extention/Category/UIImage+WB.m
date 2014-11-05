//
//  UIImage+UIImage_WB.m
//  XinWeibo
//
//  Created by tanyang on 14-10-6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "UIImage+WB.h"

@implementation UIImage (UIImage_WB)
+ (UIImage *)imageWithName:(NSString *)name
{
    if (ios7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        // 没有ios7图片
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    // 非ios7
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

- (UIImage *)imageToSize:(CGSize) size
{
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
