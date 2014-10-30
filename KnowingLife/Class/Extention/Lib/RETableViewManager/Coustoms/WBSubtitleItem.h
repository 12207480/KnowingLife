//
//  WBDetailLableItem.h
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "RETableViewItem.h"

@interface WBSubtitleItem : RETableViewItem
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) UIFont *subtitleFont;
@property (nonatomic, assign) NSTextAlignment subtitleAlignment;

+ (WBSubtitleItem *)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

+ (WBSubtitleItem *)itemWithTitle:(NSString *)title rightSubtitle:(NSString *)subtitle;

+ (WBSubtitleItem *)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName;

+ (WBSubtitleItem *)itemWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end
