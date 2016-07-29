//
//  SaveFile.m
//  
//
//  Created by Dave Cai on 14/11/9.
//  Copyright (c) 2014年 chaziyjs. All rights reserved.
//

#import "SaveFile.h"

@implementation SaveFile
#pragma mark -
#pragma 根据名字获取路径，library
+ (NSString *)pathWithName:(NSString *)name
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [arr lastObject];
    path = [NSString stringWithFormat:@"%@/Jsonfiles",path];
    
    NSString *path_name;
    if (![[UserDefaults objectForKey:@"login"] isEqualToString:@"true"]) {
        path_name = [NSString stringWithFormat:@"%@", name];
    } else {
        path_name = [NSString stringWithFormat:@"%@%@", name, [[UserDefaults objectForKey:@"UserInfo"] objectForKey:@"id"]];
    }
    
    NSString *ne_name = [path_name stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *new_name = [ne_name stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path];
    if (!(existed == YES))
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        //設定這個URL指向的資料為不備份到iCloud
        NSError *error;
        [[NSURL fileURLWithPath:path] setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(error){
            NSLog(@"设置不备份到cloud出错");
        }
    }
    NSString *newpath = [NSString stringWithFormat:@"%@/%@", path, new_name];
    return newpath;
}


#pragma mark -
#pragma 判断文件是否存在
+ (BOOL)judgeFileExistWithName:(NSString *)name
{
    NSString *path = [SaveFile pathWithName:name];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:path]) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark -
#pragma 取文件
+ (NSMutableData *)readFileWithName:(NSString *)name
{
    if ([SaveFile judgeFileExistWithName:name] == YES) {
        NSString *path = [SaveFile pathWithName:name];
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
        return data;
    } else {
        return nil;
    }
}
#pragma mark -
#pragma 存文件
+ (NSString *)writeFileWithName:(NSString *)name data:(NSData *)data
{
    NSString *path = [SaveFile pathWithName:name];
    [data writeToFile:path atomically:YES];
    return path;
}



@end
