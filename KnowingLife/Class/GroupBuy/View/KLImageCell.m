//
//  ListImageCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "KLImageCell.h"
#import "UIImageView+WebCache.h"

@interface KLImageCell ()

@property (strong, readwrite, nonatomic) UIImageView *pictureView;

@end

#define kImageViewH 160
@implementation KLImageCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    //KLLog(@"%@",item);
    return kImageViewH;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kImageViewH)];
    self.pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.pictureView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    if (self.item.imageName) {
        [self.pictureView setImage:[UIImage imageNamed:self.item.imageName]];
    } else {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:self.item.imageUrl] placeholderImage:[UIImage imageNamed:@"bg_hotTopic_default"]];
    }
}

- (void)cellDidDisappear
{
    
}

@end
