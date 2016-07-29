//
//  LJSessionDownloader.h
//  Session断点下载
//
//  Created by Jay_Apple on 15/7/17.
//  Copyright (c) 2015年 Jay_Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJSessionDownloader : NSObject

/**
 *  工厂方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param contentPath 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
+ (instancetype)downloadWithURLString:(NSString *)urlString contentPath:(NSString *)contentPath withProgress:(void (^) (CGFloat progress))progress completion:(void (^) ())completion;

/**
 *  初始化方法
 *
 *  @param urlString   需要下载文件的URL
 *  @param contentPath 文件存储路径
 *  @param progress    文件下载进度
 *  @param completion  文件下载完成
 *
 *  @return 实例对象
 */
- (instancetype)initWithURLString:(NSString *)urlString contentPath:(NSString *)contentPath withProgress:(void (^) (CGFloat progress))progress completion:(void (^) ())completion;

/**
 *  开始下载
 */
- (void)start;

/**
 *  暂停下载
 */
- (void)suspend;

@end
