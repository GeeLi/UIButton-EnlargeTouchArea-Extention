//
//  UIButton+Category.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if (backgroundColor) {
        [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
        
    }
}

#pragma mark - 通过颜色获得图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 获取上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 开始渲染
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    // 获得上下文中渲染过的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
