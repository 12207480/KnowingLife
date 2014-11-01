//
//  FangResultViewController.h
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-17.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpendTableView.h"

@interface FangResultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ExpendDelegate>

@property (nonatomic, retain) UITableView * oneTableView;
@property (nonatomic, retain) NSArray * nameArray_1;
@property (nonatomic, retain) NSArray * dataArray_1;
@property (nonatomic, retain) NSArray * nameArray_2;
@property (nonatomic, retain) NSArray * dataArray_2;
@property (nonatomic, retain) NSString * xianType;//显示类型

@end
