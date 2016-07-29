//
//  NSFileManager+addskip.h
//  dajiaochong
//
//  Created by 王春景 on 16/1/28.
//  Copyright © 2016年 王春景. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager(addskip)
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;

+ (float ) folderSizeAtPath:(NSString*) folderPath;
@end
