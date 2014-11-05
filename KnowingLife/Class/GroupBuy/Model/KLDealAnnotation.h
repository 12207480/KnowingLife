//
//  KLDealAnnotation.h
//  KnowingLife
//
//  Created by tanyang on 14/11/6.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@class KLDeal,KLBusiness;
@interface KLDealAnnotation: NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) KLDeal *deal; // 显示的哪个团购
@property (nonatomic, strong) KLBusiness *business; // 显示的是哪个商家
@property (nonatomic, copy) NSString *title;
@end
