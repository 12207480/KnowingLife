//
//  KLCity.h
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLBaseCity.h"

@interface KLCity : KLBaseCity
// 分区
@property (nonatomic, strong) NSArray *districts;
// 热门
@property (nonatomic, assign) BOOL hot;
@end
