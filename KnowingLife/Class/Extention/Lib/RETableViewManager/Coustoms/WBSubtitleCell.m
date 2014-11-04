//
//  WBDetailLableCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBSubtitleCell.h"

@interface WBSubtitleCell()
@property (nonatomic,weak) UILabel *subTitleLabel;
@end
@implementation WBSubtitleCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    CGFloat CellHeight = ((WBSubtitleItem *)item).cellHeight;
    return CellHeight > 0 ? CellHeight : 36;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    UILabel *subTitleLabel = [[UILabel alloc]init];
    [self addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
    
    self.subTitleLabel.font = [UIFont systemFontOfSize:11];
    self.subTitleLabel.textColor = [UIColor grayColor];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    if (self.item.subtitleFont) {
        self.subTitleLabel.font = self.item.subtitleFont;
    }
    if (self.item.subtitle) {
        self.subTitleLabel.textAlignment = self.item.subtitleAlignment;
        self.subTitleLabel.text = self.item.subtitle;
    }
    //NSLog(@"cellWillAppear");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"layoutSubviews");
    CGFloat textLabelW = [self.textLabel.text sizeWithFont:self.textLabel.font].width;
    CGFloat subtitleLableY = self.textLabel.frame.origin.y;
    CGFloat subtitleLableH = self.textLabel.frame.size.height;
    CGFloat subtitleLableX = self.textLabel.frame.origin.x + textLabelW + 6;
    CGFloat rightInset = self.accessoryView ? 40 : 20;
    CGFloat subtitleLableW = self.frame.size.width - subtitleLableX - rightInset;
//    CGFloat subtitleLableMaxW = [self.subTitleLabel.text sizeWithFont:self.subTitleLabel.font forWidth:subtitleLableW lineBreakMode:NSLineBreakByTruncatingTail].width;
    self.subTitleLabel.frame = CGRectMake(subtitleLableX, subtitleLableY, subtitleLableW, subtitleLableH);
    
}

/**
 // 被转发微博正文
 CGFloat retweetContentLabelX = retweetNameLabelX;
 CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelFrame) + WBStatusCellBorder;
 CGFloat retweetContentLabelMaxW = retweetViewW - 2 * WBStatusCellBorder;
 CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:WBStatusRetweetContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
 _retweetContentLabelFrame = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
