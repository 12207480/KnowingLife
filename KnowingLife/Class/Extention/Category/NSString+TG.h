//
//  NSString+TG.h
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_TG)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
