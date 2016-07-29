    //
//  DWSearchBar.m
//  SearchBar
//
//  Created by 李帅 on 15/9/2.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "DWSearchBar.h"

@implementation DWSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customStyle];
        
        [self createBackView];
    }
    return self;
}

- (void)customStyle
{
    if (IOS7_Later) {
        [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBarTintColor:[UIColor clearColor]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, DEF_HEIGHT_VIEW(self) - 0.5, DEF_WIDTH_VIEW(self), 0.5)];
    line1.backgroundColor = DEF_RGB_COLOR(100, 100, 100, 1);
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, DEF_HEIGHT_VIEW(self) - 8, 0.5, 8)];
    line2.backgroundColor = DEF_RGB_COLOR(100, 100, 100, 1);
    [self addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(DEF_WIDTH_VIEW(self) - 0.5, DEF_HEIGHT_VIEW(self) - 8, 0.5, 8)];
    line3.backgroundColor = DEF_RGB_COLOR(100, 100, 100, 1);
    [self addSubview:line3];
    
}

- (void)createBackView
{
    self.backView = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT);
    _backView.hidden = YES;
    [_backView addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _backView.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.4];
    [[[UIApplication sharedApplication].delegate window] addSubview:_backView];
}

- (void)addBackView
{
    _backView.hidden = NO;
}

- (void)backButtonAction:(UIButton *)sender
{
    sender.hidden = YES;
    [self endEditing:YES];
}


@end
