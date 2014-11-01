//
//  ExpendTableView.h
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-21.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpendDelegate <NSObject>

-(void)clooseTab:(NSString *)sendStr;

@end

@interface ExpendTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSArray * nameAry;
@property (nonatomic, retain) NSArray * dataAry;
@property (nonatomic, retain) UITableView * expendTab;

@property (nonatomic, retain) id<ExpendDelegate>expendDelegate;

@end
