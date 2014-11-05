//
//  KLDeal.m
//  KnowingLife
//
//  Created by tanyang on 14/11/3.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLDeal.h"
#import "NSString+TG.h"
#import "KLBusiness.h"
#import "MJExtension.h"

@implementation KLDeal

- (NSDictionary *)objectClassInArray
{
    return @{@"businesses":[KLBusiness class]};
}

- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];
}
@end
