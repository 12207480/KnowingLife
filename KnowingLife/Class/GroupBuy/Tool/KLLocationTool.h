//
//  KLLocationTool.h
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <CoreLocation/CoreLocation.h>

// 城市位置类
@interface KLLocationCity : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

// 通知名
#define LocationCityNote @"location_City_Note"
@interface KLLocationTool : NSObject
singleton_interface(KLLocationTool)

// 定位城市
@property (nonatomic, strong) KLLocationCity *locationCity;
@end
