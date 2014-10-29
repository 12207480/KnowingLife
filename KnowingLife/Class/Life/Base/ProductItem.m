//
//  ProductItem.m
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "ProductItem.h"

@implementation ProductItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    return [[self alloc]initWithTitle:title icon:icon];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVcClass:(Class)destVcClass
{
    return [[self alloc]initWithTitle:title icon:icon destVcClass:destVcClass];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon selectionHandler:(void (^)(id))selectionHandler
{
    return [[self alloc]initWithTitle:title icon:icon selectionHandler:selectionHandler];
}

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    return self;
}

- (id)initWithTitle:(NSString *)title icon:(NSString *)icon
{
    self = [self init];
    if (!self)
        return nil;
    self.title = title;
    self.icon = icon;
    return self;
}

- (id)initWithTitle:(NSString *)title icon:(NSString *)icon destVcClass:(Class)destVcClass
{
    self = [self initWithTitle:title icon:icon];
    if (!self)
        return nil;
    self.destVcClass = destVcClass;
    return self;
}

- (id)initWithTitle:(NSString *)title icon:(NSString *)icon selectionHandler:(void (^)(id item))selectionHandler
{
    self = [self initWithTitle:title icon:icon];
    if (!self)
        return nil;
    self.selectionHandler = selectionHandler;
    return self;
}

@end
