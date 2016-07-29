//
//  GlobalMethod.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GlobalMethod : NSObject 


/**
 *  获取字符串自适应后所占高度
 */
+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width;


+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height;


/**
 *  获取设备的UUID
 */
+ (NSString *)getUUID;

/**
 *  添加下划线
 */
+ (void)addUnderline:(UIView *)inView;


/**
 *  添加无数据情况下的提示
 */
+ (UIView *)showTipsOfNoData:(NSString *)tipsStr inView:(UIView *)inView;

/**
 *  移除无数据提示
 */
+ (void)removeTipsViewOfNoData:(UIView *)inView;

/**
 *  数据本地存储
 */
+ (void)setObject:(id)obj forKey:(NSString *)key;

+ (void)setBool:(BOOL)b forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;

@end
