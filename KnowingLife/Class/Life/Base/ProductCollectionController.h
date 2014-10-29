//
//  ProductCollectionController.h
//  KnowingLife
//
//  Created by tanyang on 14/10/29.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLWeatherInfo;
@interface ProductCollectionController : UICollectionViewController
@property (nonatomic, strong) KLWeatherInfo *weatherInfo;
@end
