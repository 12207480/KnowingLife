//
//  KLLocationTool.m
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@implementation KLLocationCity
@end

@interface KLLocationTool () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *mgr;
@property (nonatomic,strong) CLGeocoder *geo;
@end

@implementation KLLocationTool
singleton_implementation(KLLocationTool)

- (id)init
{
    if (self = [super init]) {
        
        _geo = [[CLGeocoder alloc] init];
        
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
        [_mgr startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.停止定位
    [_mgr stopUpdatingLocation];
    
    // 2.根据经纬度反向获得城市名称
    CLLocation *loc = locations[0];
    [_geo reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         // 取出位置
         CLPlacemark *place = placemarks[0];
         KLLog(@"%@",place.locality);
         //NSString *cityName = place.addressDictionary[@"State"];
         NSString *cityName = place.locality;
         cityName = [cityName substringToIndex:cityName.length - 1];
         
         // 设置定位城市
         _locationCity = [[KLLocationCity alloc]init];
         _locationCity.city = cityName;
         _locationCity.coordinate = loc.coordinate;
         
         // 发出通知
         [[NSNotificationCenter defaultCenter] postNotificationName:LocationCityNote object:nil];
     }];
}

@end
