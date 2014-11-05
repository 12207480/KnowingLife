//
//  ListImageItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "KLImageItem.h"

@implementation KLImageItem

+ (KLImageItem *)itemWithImageNamed:(NSString *)imageName
{
    KLImageItem *item = [[KLImageItem alloc] init];
    item.imageName = imageName;
    return item;
}

+ (KLImageItem *)itemWithImageUrl:(NSString *)imageUrl isReservation:(BOOL)isReservation
{
    KLImageItem *item = [[KLImageItem alloc] init];
    item.imageUrl = imageUrl;
    item.isReservation = isReservation;
    return item;
}

@end
