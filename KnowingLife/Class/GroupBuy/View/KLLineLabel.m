//
//  KLLineLabel.m
//  KnowingLife
//
//  Created by tanyang on 14/11/4.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLLineLabel.h"

@implementation KLLineLabel

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置颜色
    [self.textColor setStroke];
    // 画线
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    
    CGFloat endX = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    // 渲染
    CGContextStrokePath(ctx);
}


@end
