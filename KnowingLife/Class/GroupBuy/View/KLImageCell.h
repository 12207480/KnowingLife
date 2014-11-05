//
//  ListImageCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"

@class KLImageItem;
@interface KLImageCell : RETableViewCell

@property (strong, readonly, nonatomic) UIImageView *pictureView;
@property (strong, readwrite, nonatomic) KLImageItem *item;

@end
