//
//  ProductCell.m
//  Lottery Ticket
//
//  Created by tanyang on 14-9-25.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "ProductCell.h"
#import "ProductItem.h"

@interface ProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ProductCell

- (void)awakeFromNib
{
    self.iconImage.layer.cornerRadius = 8;
    self.iconImage.clipsToBounds = YES;
    self.backgroundColor = KLCollectionBkgCollor;//KLColor(231, 231, 231);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(ProductItem *)item
{
    _item = item;
    self.iconImage.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
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
