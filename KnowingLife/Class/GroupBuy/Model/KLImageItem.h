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

+ (KLImageItem *)itemWithImageNamed:(NSString *)imageName;

+ (KLImageItem *)itemWithImageUrl:(NSString *)imageUrl;

@end
