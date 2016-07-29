//
//  Singleton.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/7/14.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

@property (nonatomic, strong) NSURLSessionTask *sessionTask;
// 推送clientId
@property (nonatomic, assign) NSString *clientId;

@property (nonatomic, strong) NSMutableArray *searchHistory_array;
@property (nonatomic, strong) NSMutableArray *cityHistory_array;

@property (nonatomic, strong) NSMutableArray *timeList_array;
@property (nonatomic, strong) NSMutableArray *historyTime_array;

+ (Singleton *)sharedSingleton;

@end
