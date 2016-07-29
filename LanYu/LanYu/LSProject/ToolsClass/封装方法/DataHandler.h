//
//  DataHandler.h
//  FrameworkTest
//
//  Created by 李帅 on 15/11/28.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

/**
 *  data解析
 */
+ (id)jsonWithData:(NSData *)data;

/**
 *  id转data
 */
+ (NSData *)dataWithObject:(id)object;

/**
 *  id转json
 */
+ (NSString *)jsonWithObject:(id)object;

/**
 *  去除空格和回车
 */
+ (NSString *)replaceSpace:(NSString *)string;





@end
