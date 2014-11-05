//
//  NSDate+WB.h
//  XinWeibo
//
//  Created by tanyang on 14-10-14.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WB)
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
- (NSDateComponents *)compare:(NSDate *)other;
@end
