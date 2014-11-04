//
//  TGCategory.m
//  团购
//
//  Created by apple on 13-11-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "KLCategory.h"
#import "KLSubCategorie.h"
#import "MJExtension.h"

@implementation KLCategory
- (NSDictionary *)objectClassInArray
{
    return @{@"subcategories":[KLSubCategorie class]};
}
@end
