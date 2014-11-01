//
//  ExpendTableView.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-21.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "ExpendTableView.h"

@implementation ExpendTableView
@synthesize expendTab;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        expendTab = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, 300, self.nameAry.count*38+30) style:UITableViewStyleGrouped];
        expendTab.backgroundView.alpha = 0;
        expendTab.dataSource = self;
        expendTab.delegate = self;
        expendTab.scrollEnabled = NO;
        [self addSubview:expendTab];
    }
    return self;
}

#pragma mark -------Tab Dele-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while (cell.contentView.subviews.lastObject) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    NSUInteger row = [indexPath row];
    //名称栏
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(10, 9, 100, 20)];
    name.backgroundColor = [UIColor clearColor];
    name.text = [self.nameAry objectAtIndex:row];
    name.font = [UIFont systemFontOfSize:18];
    [cell.contentView addSubview:name];
    //数据栏
    UILabel * data = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 120, 18)];
    data.backgroundColor = [UIColor clearColor];
    data.text = [self.dataAry objectAtIndex:row];
    data.font = [UIFont systemFontOfSize:16];
    data.textAlignment = NSTextAlignmentRight;
    data.textColor = [UIColor blueColor];
    [cell.contentView addSubview:data];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"点击";
    if (self.expendDelegate && [self.expendDelegate respondsToSelector:@selector(clooseTab:)]) {
        [self.expendDelegate clooseTab:str];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
