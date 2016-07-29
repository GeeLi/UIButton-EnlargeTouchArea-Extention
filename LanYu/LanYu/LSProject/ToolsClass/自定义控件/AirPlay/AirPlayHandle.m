//
//  AirPlayHandle.m
//  AirPlayDemo
//
//  Created by iOS-李帅 on 16/7/6.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "AirPlayHandle.h"
#import "AirPlayController.h"
@interface AirPlayHandle ()

@property (nonatomic,strong) UIWindow *externalWindow;
@property (nonatomic,strong) UIScreen *externalScreen;
@property (nonatomic,strong) AirPlayController *externalController;
@end
@implementation AirPlayHandle

#pragma mark 单例
+ (instancetype)shareAirPlay{
    static AirPlayHandle *airPlayVC;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        airPlayVC = [[AirPlayHandle alloc] init];
        [airPlayVC checkForExistingScreenAndInitializeIfPresent];
        [[NSNotificationCenter defaultCenter]addObserver:airPlayVC selector:@selector(screenDidConnect:) name:UIScreenDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:airPlayVC selector:@selector(screenDidDisconnect:) name:UIScreenDidDisconnectNotification object:nil];
    });
    
    return airPlayVC;
}

- (void)screenDidConnect:(NSNotification *)notification
{
    NSLog(@"connect");
    self.externalScreen = notification.object;
    [self checkForExistingScreenAndInitializeIfPresent];
    
    // Handle the configuration below......
}

- (void)screenDidDisconnect:(NSNotification *)notification
{
    NSLog(@"disconnect");
    if (self.externalWindow) {
        self.externalWindow.hidden = YES;
        self.externalScreen = nil;
        self.externalWindow = nil;
    }
}

#pragma mark 重置Window并连接设备
- (void)checkForExistingScreenAndInitializeIfPresent
{
    if ([UIScreen screens].count > 1) {
        self.externalScreen = [[UIScreen screens] objectAtIndex:1];
        NSLog(@"external screen :%@",self.externalScreen);
        
        
        CGRect screenBounds = self.externalScreen.bounds;
        self.externalWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        self.externalWindow.screen = self.externalScreen;
        self.externalWindow.backgroundColor = [UIColor whiteColor];
        self.externalController = [[AirPlayController alloc] init];
        self.externalController.view.frame = screenBounds;
        self.externalController.view.backgroundColor = [UIColor whiteColor];
        self.externalWindow.rootViewController = self.externalController;
        self.externalWindow.hidden = NO;
    }else{
        NSLog(@"未连接其他设备");
    }
}

#pragma mark -
#pragma mark 开启／关闭同步
- (void)setExternalWindowHidden:(BOOL)hidden{
    if (self.externalWindow) {
        self.externalWindow.hidden = hidden;
    }
}

#pragma mark AirPlay恢复默认同步
- (void)defaultStates{
    if (self.externalWindow) {
        self.externalWindow.hidden = YES;
    }
}

#pragma mark AirPlay关闭同步
- (void)closeAirPlay{
//    [self checkForExistingScreenAndInitializeIfPresent];
    self.externalWindow.hidden = NO;
}

#pragma mark AirPlay播放本地图片
- (void)playLocalImageWithImage:(UIImage *)image{
    [self closeAirPlay];
    [self.externalController playLocalImageWithImage:image];
}

#pragma mark AirPlay播放单张图片
- (void)playNetImageWithUrlString:(NSString *)urlString{
    [self closeAirPlay];
    [self.externalController playNetImageWithUrlString:urlString];
}

#pragma mark AirPlay进入网络视频播放状态
- (void)playNetVideoWithUrlString:(NSString *)urlString{
    [self closeAirPlay];
    [self.externalController playNetVideoWithUrlString:urlString];
}

#pragma mark AirPlay进入本地视频播放状态
- (void)playLocalVideoWithFilePath:(NSString *)path{
    [self closeAirPlay];
    [self.externalController playLocalVideoWithFilePath:path];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
