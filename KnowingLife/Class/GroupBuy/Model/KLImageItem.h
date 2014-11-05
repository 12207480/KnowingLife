//
//  ListImageItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface KLImageItem : RETableViewItem

@property (copy, readwrite, nonatomic) NSString *imageName;

@property (nonatomic, copy) NSString *imageUrl;
// 免预约
@property (nonatomic, assign) BOOL isReservation;

+ (KLImageItem *)itemWithImageNamed:(NSString *)imageName;

+ (KLImageItem *)itemWithImageUrl:(NSString *)imageUrl isReservation:(BOOL)isReservation;

@end
