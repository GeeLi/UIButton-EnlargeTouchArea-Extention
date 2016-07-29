//
//  FZButton.m
//  WelfareClub
//
//  Created by 李帅 on 15/8/23.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "FZButton.h"

@interface FZButton ()

@property (nonatomic, strong) UIImageView *badge;


@end

@implementation FZButton

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.frame  = _imgFrame;
    
    self.titleLabel.frame  = _titleFrame;
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:_fontSize]];
    
}
 
- (void)setShowBadge:(BOOL)showBadge
{
    _showBadge = showBadge;
    _badge.hidden = !_showBadge;
}

- (void)createBadge
{
    self.badge = [[UIImageView alloc] initWithFrame:CGRectMake((DEF_WIDTH_VIEW(self) - _imgFrame.size.height) / 2 + _imgFrame.size.height + 2, _imgFrame.origin.y, 7, 7)];
    _badge.image = [UIImage imageNamed:@"Oval 20"];
    _badge.hidden = YES;
    [self addSubview:_badge];
}


@end
