//
//  ProductSection.m
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "ProductSection.h"

@implementation ProductSection

+ (instancetype)section
{
    return [[self alloc]init];
}

- (id)init
{
    if (self = [super init]) {
        _items = [NSMutableArray array];
    }
    return self;
}

@end
