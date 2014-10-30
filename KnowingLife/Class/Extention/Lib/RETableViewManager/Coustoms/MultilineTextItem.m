//
//  MultilineTextItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "MultilineTextItem.h"

@implementation MultilineTextItem

- (UIFont *)titleFont
{
    if (_titleFont == nil) {
        _titleFont = [UIFont systemFontOfSize:17];
    }
    return _titleFont;
}

+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)font
{
    return [[self alloc]initWithTitle:title font:font];
}

- (id)initWithTitle:(NSString *)title font:(UIFont *)font
{
    if (self = [super initWithTitle:title]) {
        self.titleFont = font;
    }
    return self;
}

@end
