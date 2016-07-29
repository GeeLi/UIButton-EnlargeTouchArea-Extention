//
//  IndicatorHandler.m
//  Test_Framework
//
//  Created by 李帅 on 15/8/16.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "IndicatorHandler.h"

@implementation IndicatorHandler

#pragma mark - 添加加载动画控件
+ (void)addIndicatorHUD_InView:(UIView *)inView indicatorStyle:(IndicatorStyle)style
{
    switch (style) {
        case IndicatorStyleLoadingData:
            // 加载数据动画
            [IndicatorHandler addLoadingDataHUD_InView:inView];
            break;
        case IndicatorStyleUploadFile:
            // 上传文件动画
            [IndicatorHandler addUploadFileHUD_InView:inView];
            break;
        case IndicatorStyleGeneralHUD:
            // 普通动画
            [IndicatorHandler addGeneralHUD_InView:inView];
            break;
        default:
            break;
    }
}

#pragma mark - 移除loading控件
+ (void)stopIndicatorHUD_InView:(UIView *)inView
{
    UIView *backView = [inView viewWithTag:999]; 
    UIImageView *imgView = (UIImageView *)[backView viewWithTag:888];
    [imgView stopAnimating];
    [imgView removeFromSuperview];
    [backView removeFromSuperview];
    backView = nil;
}

#pragma mark - 加载数据
+ (void)addLoadingDataHUD_InView:(UIView *)inView
{
    if (![inView viewWithTag:999]) {
        UIView *backView = [[UIView alloc] init];
        backView.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT);
        backView.tag = 999;
        backView.backgroundColor = WHITE_COLOR;
        [inView addSubview:backView];
        
        // loading控件
        NSMutableArray *imgArr = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]]];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        imgView.center = CGPointMake(DEF_SCREEN_WIDTH / 2 + 11, DEF_CONTENT_HEIGHT / 2.3);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.tag = 888;
        [backView addSubview:imgView];
        imgView.animationImages = imgArr;
        imgView.animationDuration = imgArr.count * 0.1;
        [imgView startAnimating];
        
    }
    
}

#pragma mark - 普通控件
+ (void)addGeneralHUD_InView:(UIView *)inView
{
    if (![inView viewWithTag:999]) {
        UIView *backView = [[UIView alloc] init];
        backView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
        backView.tag = 999;
        backView.backgroundColor = [UIColor clearColor];
        [inView addSubview:backView];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 2 - 20, DEF_CONTENT_HEIGHT / 2.5, 40, 40)];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [backView addSubview:indicator];
        [indicator startAnimating];
            
    }

}

#pragma mark - 上传文件
+ (void)addUploadFileHUD_InView:(UIView *)inView
{
    if (![inView viewWithTag:999]) {
        UIView *backView = [[UIView alloc] init];
        backView.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT);
        backView.tag = 999;
        backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [inView addSubview:backView];
        
        NSMutableArray *imgArr = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]]];
        }
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        imgView.center = CGPointMake(DEF_SCREEN_WIDTH / 2 + 11, DEF_CONTENT_HEIGHT / 2.3);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.tag = 888;
        [backView addSubview:imgView];
        imgView.animationImages = imgArr;
        imgView.animationDuration = imgArr.count * 0.1;
        [imgView startAnimating];
        
    }
    
}



@end
