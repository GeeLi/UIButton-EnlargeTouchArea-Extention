//
//  CustomSearchBar.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/4/25.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    UIView *searchTextField = nil;
    self.barTintColor = [UIColor whiteColor];
    [[[[self.subviews objectAtIndex:0] subviews] objectAtIndex:1] setOpaque:YES];
    searchTextField = [[[self.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = backgroundColor;
    
}

@end
