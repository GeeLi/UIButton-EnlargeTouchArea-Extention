//
//  Singleton.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/7/14.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "Singleton.h"
@implementation Singleton

+ (Singleton *)sharedSingleton
{
    static Singleton *single = nil;
    static dispatch_once_t predictor;
    dispatch_once(&predictor, ^{
        single = [[Singleton alloc] init];
        single.searchHistory_array = [NSMutableArray arrayWithObjects:@"移动开发", @"淘宝运营", @"行政文员", @"设计", @"业务员", @"市场营销", @"运营", @"UI设计",nil];
        single.cityHistory_array = [NSMutableArray array];
        single.timeList_array = [NSMutableArray array];
        single.historyTime_array = [NSMutableArray array];
    });
    return single;
}

@end
