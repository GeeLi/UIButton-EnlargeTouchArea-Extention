//
//  AirPlayController.h
//  AirPlayDemo
//
//  Created by iOS-李帅 on 16/7/6.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlayController : UIViewController

/**
 *  AirPlay播放本地图片
 */
- (void)playLocalImageWithImage:(UIImage *)image;

/**
 *  AirPlay播放网络图片
 */
- (void)playNetImageWithUrlString:(NSString *)urlString;

/**
 *  AirPlay进入网络视频播放状态
 */
- (void)playNetVideoWithUrlString:(NSString *)urlString;

/**
 *  AirPlay进入本地视频播放状态
 */
- (void)playLocalVideoWithFilePath:(NSString *)path;
@end
