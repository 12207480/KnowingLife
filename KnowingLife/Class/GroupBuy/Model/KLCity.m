//
//  KLCity.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLCity.h"
#import "MJExtension.h"
#import "KLCItyDistrict.h"

@implementation KLCity
- (NSDictionary *)objectClassInArray
{
    return @{@"districts" : [KLCItyDistrict class]};
}
@end
