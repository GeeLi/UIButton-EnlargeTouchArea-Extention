//
//  AFNetworkTools.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "AFNetworkTools.h"
#import "SaveFile.h"
#import "ReConnectHandler.h"

@implementation AFNetworkTools

#pragma mark - GET方式请求JSON数据
+ (void)get_JsonData_withUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(id))failure{
    [AFNetworkTools get_JsonData_withUrl:url parameters:parameters inView:nil isRemoveIndicator:YES indicatorStyle:3 isShowReNetwork:NO isNeedCache:NO success:success failure:failure];
}

#pragma mark - GET方式请求JSON数据
+ (void)get_JsonData_withUrl:(NSString *)url
                  parameters:(NSDictionary *)parameters
                      inView:(UIView *)inView
           isRemoveIndicator:(BOOL)isRemove
              indicatorStyle:(NSInteger)indicatorStyle
             isShowReNetwork:(BOOL)isShowReNetwork
                 isNeedCache:(BOOL)isNeedCache
                     success:(void (^)(id json))success
                     failure:(void (^)(id json))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HEADER, url];
    
    // 旋转动画
    if (inView) {
        [IndicatorHandler addIndicatorHUD_InView:inView indicatorStyle:indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain",@"application/json", nil];
    
    // 得到NSURLSessionTask对象, 网络请求
    Singleton *single = [Singleton sharedSingleton];
    single.sessionTask = [session GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"msg"] && [[responseObject objectForKey:@"msg"] isEqualToString:@"4050"]) {
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            // 提示
            [UIMethod createAlertWithStr:[[responseObject objectForKey:@"msg"] stringByRemovingPercentEncoding]];
            // 读取缓存, 执行failure方法
            NSData *result = [SaveFile readFileWithName:urlStr];
            failure([DataHandler jsonWithData:result]);
            // 是否显示无网图
            if (isShowReNetwork || (isNeedCache && !result)) {
                // 显示无网图
                ReConnectHandler *reConnect = [[ReConnectHandler alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT)];
                [reConnect addReConnectView_Url:urlStr parameters:parameters inView:inView isRemoveIndicator:isRemove indicatorStyle:indicatorStyle requestType:RequestTypeGet success:^(id json) {
                    // 请求成功
                    success(json);
                }];
            }
            
        } else {
            if (isNeedCache) {
                [SaveFile writeFileWithName:urlStr data:[DataHandler dataWithObject:responseObject]];
            }
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [IndicatorHandler stopIndicatorHUD_InView:inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"%@",error.localizedDescription);
        NSLog(@"请求失败！参数：%@",parameters);
        // 读取缓存
        NSData *result = [SaveFile readFileWithName:urlStr];
        failure([DataHandler jsonWithData:result]);
        if (error.code != -999) {
            if (isShowReNetwork || (isNeedCache && !result)) {
                // 显示无网图
                ReConnectHandler *reConnect = [[ReConnectHandler alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT)];
                [reConnect addReConnectView_Url:urlStr parameters:parameters inView:inView isRemoveIndicator:isRemove indicatorStyle:indicatorStyle requestType:RequestTypeGet success:^(id json) {
                    // 请求成功
                    success(json);
                }]; 
            } else {
                [UIMethod createAlertWithStr:@"网络异常"];
            }
            
        }
    }];
    
}

#pragma mark - POST方式请求JSON数据
+ (void)post_JsonData_withUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(id))failure{
    [AFNetworkTools post_JsonData_withUrl:url parameters:parameters inView:nil isRemoveIndicator:YES indicatorStyle:3 isShowReNetwork:NO isNeedCache:NO success:success failure:failure];
}

#pragma mark - POST方式请求JSON数据
+ (void)post_JsonData_withUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
                       inView:(UIView *)inView
            isRemoveIndicator:(BOOL)isRemove
               indicatorStyle:(NSInteger)indicatorStyle
              isShowReNetwork:(BOOL)isShowReNetwork
                  isNeedCache:(BOOL)isNeedCache
                      success:(void (^)(id json))success
                      failure:(void (^)(id json))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HEADER, url];
    NSLog(@"%@", urlStr);
    for (NSString *key in parameters) {
        if ([[parameters objectForKey:key] isKindOfClass:[NSString class]]) {
            NSLog(@"%@ = %@", key, [[parameters objectForKey:key] stringByRemovingPercentEncoding]);
        } else {
            NSLog(@"%@ = %@", key, [parameters objectForKey:key]);
        }
    }
    // 旋转动画
    if (inView) {
        [IndicatorHandler addIndicatorHUD_InView:inView indicatorStyle:indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain",@"application/json", nil]; //设置相应内容类型
    
    // 得到NSURLSessionTask对象, 网络请求
    Singleton *single = [Singleton sharedSingleton];
    single.sessionTask = [session POST:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if (isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"msg"] && [[responseObject objectForKey:@"msg"] isEqualToString:@"4050"]) {
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            // 提示
            [UIMethod createAlertWithStr:[[responseObject objectForKey:@"msg"] stringByRemovingPercentEncoding]];
            // 读取缓存, 执行failure方法
            NSData *result = [SaveFile readFileWithName:urlStr];
            failure([DataHandler jsonWithData:result]);
            // 是否显示无网图
            if (isShowReNetwork || (isNeedCache && !result)) {
                // 显示无网图
                ReConnectHandler *reConnect = [[ReConnectHandler alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT)];
                [reConnect addReConnectView_Url:urlStr parameters:parameters inView:inView isRemoveIndicator:isRemove indicatorStyle:indicatorStyle requestType:RequestTypePost success:^(id json) {
                    // 请求成功
                    success(json);
                }];
            }
            
        } else {
            if (isNeedCache) {
                [SaveFile writeFileWithName:urlStr data:[DataHandler dataWithObject:responseObject]];
            }
            success(responseObject);
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"error == %ld", (long)error.code); // -1009 无网    -1004无法连接服务器   -1001  连接超时
        [IndicatorHandler stopIndicatorHUD_InView:inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        // 读取缓存
        NSData *result = [SaveFile readFileWithName:urlStr];
        failure([DataHandler jsonWithData:result]);
        if (error.code != -999) {
            if (isShowReNetwork || (isNeedCache && !result)) {
                // 显示无网图
                ReConnectHandler *reConnect = [[ReConnectHandler alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT)];
                [reConnect addReConnectView_Url:urlStr parameters:parameters inView:inView isRemoveIndicator:isRemove indicatorStyle:indicatorStyle requestType:RequestTypePost success:^(id json) {
                    // 请求成功
                    success(json);
                }]; 
            } else {
                [UIMethod createAlertWithStr:@"网络异常"];
            }
        }
    }];

}

#pragma mark - 文件上传
+ (void)post_File_Upload_WithUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                        fileData:(NSData *)fileData
                            name:(NSString *)name
                          inView:(UIView *)inView
               isRemoveIndicator:(BOOL)isRemove
                  indicatorStyle:(NSInteger)indicatorStyle 
                         success:(void (^)(id json))success
                         failure:(void (^)())failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HEADER, url];
    // 旋转动画
    if (inView) {
        [IndicatorHandler addIndicatorHUD_InView:inView indicatorStyle:indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil]; //设置相应内容类型
    session.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 得到NSURLSessionTask对象
    Singleton *single = [Singleton sharedSingleton];
    single.sessionTask = [session POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 以日期命名图片
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd-mm-ss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateStr];
        
        NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [pathArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@", path, fileName];
        [fileData writeToFile:path atomically:YES];
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 移除动画
        [IndicatorHandler stopIndicatorHUD_InView:inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error.code != -999) {
            [UIMethod createAlertWithStr:@"网络异常"];
        } 
        failure();

    }];
    
}

#pragma mark - 多个文件上传
+ (void)post_MultiFile_Upload_WithUrl:(NSString *)url
                      parameters:(NSDictionary *)parameters
                       dataArray:(NSArray *)dataArray
                            name:(NSString *)name
                          inView:(UIView *)inView
               isRemoveIndicator:(BOOL)isRemove
                  indicatorStyle:(NSInteger)indicatorStyle 
                         success:(void (^)(id json))success
                         failure:(void (^)())failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HEADER, url];
    // 旋转动画
    if (inView) {
        [IndicatorHandler addIndicatorHUD_InView:inView indicatorStyle:indicatorStyle];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain",@"application/json", nil]; //设置相应内容类型
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 得到AFHTTPRequestOperation对象
    Singleton *single = [Singleton sharedSingleton];
    single.sessionTask = [session POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < dataArray.count; i++) {
            // 以日期命名图片
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone systemTimeZone]];
            [formatter setDateFormat:@"yyyy-MM-dd-mm-ss"];
            NSString *dateStr = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateStr];
            
            NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [pathArr firstObject];
            path = [NSString stringWithFormat:@"%@/%@", path, fileName];
            [dataArray[i] writeToFile:path atomically:YES];  
            [formData appendPartWithFileData:dataArray[i] name:name fileName:fileName mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isRemove) {
            // 移除动画
            [IndicatorHandler stopIndicatorHUD_InView:inView];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 移除动画
        [IndicatorHandler stopIndicatorHUD_InView:inView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error.code != -999) {
            [UIMethod createAlertWithStr:@"网络异常"];
        } 
        failure();
        
    }];

}

@end
