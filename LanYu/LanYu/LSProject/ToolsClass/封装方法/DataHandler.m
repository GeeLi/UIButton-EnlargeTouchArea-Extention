//
//  DataHandler.m
//  FrameworkTest
//
//  Created by 李帅 on 15/11/28.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

#pragma mark - json解析
+ (id)jsonWithData:(NSData *)data
{
    id jsonObject = nil;
    if (data) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    return jsonObject;
}

#pragma mark - id转data
+ (NSData *)dataWithObject:(id)object
{
    NSData *data = nil;
    if (object) {
        data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    } 
    return data;
}

#pragma mark - id转json字符串
+ (NSString *)jsonWithObject:(id)object
{
    NSString *jsonString = nil;
    NSData *jsonData = nil;
    if (object) {
        jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    }    
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

#pragma mark - 去除字符串空格和回车
+ (NSString *)replaceSpace:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}


@end
