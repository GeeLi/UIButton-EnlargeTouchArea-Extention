//
//  AirPlayController.m
//  AirPlayDemo
//
//  Created by iOS-李帅 on 16/7/6.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "AirPlayController.h"
#import "UIView+YYAdd.h"
#import <MediaPlayer/MediaPlayer.h>
@interface AirPlayController ()
@property (nonatomic, strong) MPMoviePlayerController *player;
@end

@implementation AirPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark AirPlay播放本地图片
- (void)playLocalImageWithImage:(UIImage *)image{
    [self.view removeAllSubviews];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.image= image;
    iv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iv];
}

#pragma mark AirPlay播放网络图片
- (void)playNetImageWithUrlString:(NSString *)urlString{
    [self.view removeAllSubviews];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [iv sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [self.view addSubview:iv];
}

#pragma mark AirPlay进入网络视频播放状态
- (void)playNetVideoWithUrlString:(NSString *)urlString{
    [self.view removeAllSubviews];
    NSURL* url = [NSURL URLWithString:urlString];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.view addSubview:self.player.view];
    self.player.view.frame=CGRectMake(0, 0, self.view.frame.size.width, CGRectGetWidth(self.view.frame)*(9.0/16.0));
    self.player.shouldAutoplay = YES;// 是否自动播放（默认为YES）
    self.player.controlStyle = MPMovieControlStyleNone;
    [self.player prepareToPlay];
    [self.player play];
}

#pragma mark AirPlay进入本地视频播放状态
- (void)playLocalVideoWithFilePath:(NSString *)path{
    [self.view removeAllSubviews];
    self.player=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
    [self.view addSubview:self.player.view];
    
    self.player.view.frame=CGRectMake(0, 0, self.view.frame.size.width, CGRectGetWidth(self.view.frame)*(9.0/16.0));
    self.player.movieSourceType = MPMovieSourceTypeFile;// 播放本地视频时需要这句
    self.player.controlStyle = MPMovieControlStyleNone;
    //    self.player.controlStyle = MPMovieControlStyleNone;// 不需要进度条
    self.player.shouldAutoplay = YES;// 是否自动播放（默认为YES）
    //    self.player.scalingMode=MPMovieScalingModeAspectFill;
    [self.player prepareToPlay];//缓存
    [self.player play];//可以不加这句
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
