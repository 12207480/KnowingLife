//
//  CitysViewController.h
//  KnowingLife
//
//  Created by tanyang on 14/10/27.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitysViewdelegate <NSObject>

- (void)citysViewDidSetectedCity:(NSString *)city;

@end

@interface CitysViewController : UITableViewController
@property (nonatomic, weak) id<CitysViewdelegate> citysDelegate;
@end
