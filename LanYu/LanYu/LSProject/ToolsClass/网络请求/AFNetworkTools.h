//
//  AFNetworkTools.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "IndicatorHandler.h"

@interface AFNetworkTools : NSObject


/**
 *  GET方式请求JSON数据
 */
+ (void)get_JsonData_withUrl:(NSString *)url
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(id json))success
                     failure:(void (^)(id json))failure;;


/**
 *  GET方式请求JSON数据
 */
+ (void)get_JsonData_withUrl:(NSString *)url
                  parameters:(NSDictionary *)parameters
                      inView:(UIView *)inView
           isRemoveIndicator:(BOOL)isRemove
              indicatorStyle:(NSInteger)indicatorStyle
             isShowReNetwork:(BOOL)isShowReNetwork
                 isNeedCache:(BOOL)isNeedCache
                     success:(void (^)(id json))success
                     failure:(void (^)(id json))failure;

/**
 *  POST方式请求JSON数据
 */
+ (void)post_JsonData_withUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(id json))success
                      failure:(void (^)(id json))failure;

/**
 *  POST方式请求JSON数据
 *  @prama isRemoveIndicator 请求成功后是否移除加载动画
 *  @prama indicatorStyle  加载动画类型(上传, 请求数据等)
 */
+ (void)post_JsonData_withUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
                       inView:(UIView *)inView
            isRemoveIndicator:(BOOL)isRemove
               indicatorStyle:(NSInteger)indicatorStyle
              isShowReNetwork:(BOOL)isShowReNetwork
                  isNeedCache:(BOOL)isNeedCache
                      success:(void (^)(id json))success
                      failure:(void (^)(id json))failure;


/**
 *  文件上传
 */
+ (void)post_File_Upload_WithUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                        fileData:(NSData *)fileData
                            name:(NSString *)name
                          inView:(UIView *)inView
               isRemoveIndicator:(BOOL)isRemove
                  indicatorStyle:(NSInteger)indicatorStyle 
                         success:(void (^)(id json))success
                         failure:(void (^)())failure;


/**
 *  多个文件上传
 */
+ (void)post_MultiFile_Upload_WithUrl:(NSString *)url
                           parameters:(NSDictionary *)parameters
                            dataArray:(NSArray *)dataArray
                                 name:(NSString *)name
                               inView:(UIView *)inView
                    isRemoveIndicator:(BOOL)isRemove
                       indicatorStyle:(NSInteger)indicatorStyle 
                              success:(void (^)(id json))success
                              failure:(void (^)())failure;


@end
