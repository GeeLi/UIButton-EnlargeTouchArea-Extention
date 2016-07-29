//
//  SaveFile.h
//  豆瓣App
//
//  Created by Dave Cai on 14/11/9.
//  Copyright (c) 2014年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveFile : NSObject

+ (NSString *)pathWithName:(NSString *)name;
+ (BOOL)judgeFileExistWithName:(NSString *)name;
+ (NSMutableData *)readFileWithName:(NSString *)name;
+ (NSString *)writeFileWithName:(NSString *)name data:(NSData *)data;
@end
