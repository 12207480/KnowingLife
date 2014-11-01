//
//  KLCitySection.m
//  KnowingLife
//
//  Created by tanyang on 14/11/1.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLCitySection.h"
#import "MJExtension.h"
#import "KLCity.h"

@implementation KLCitySection
- (NSDictionary *)objectClassInArray
{
    return @{@"cities" : [KLCity class]};
}
@end
