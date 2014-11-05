//
//  KLBusiness.h
//  KnowingLife
//
//  Created by tanyang on 14/11/6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLBusiness : NSObject
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;
@end
