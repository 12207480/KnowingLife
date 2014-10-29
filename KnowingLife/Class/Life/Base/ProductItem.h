//
//  ProductItem.h
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductItem : NSObject
// 标题
@property (nonatomic, copy) NSString *title;
// 图标
@property (nonatomic, copy) NSString *icon;
// 点击cell 运行的控制器
@property (nonatomic, assign) Class destVcClass;
// 点击cell 运行block
@property (nonatomic, copy) void (^selectionHandler)();

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVcClass:(Class) destVcClass;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon selectionHandler:(void (^)(id item))selectionHandler;
@end
