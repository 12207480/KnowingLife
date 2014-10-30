//
//  MultilineTextItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface MultilineTextItem : RETableViewItem
@property (nonatomic, strong) UIFont *titleFont;

+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)font;

- (id)initWithTitle:(NSString *)title font:(UIFont *)font;

@end
