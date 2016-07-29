//
//  IndicatorHandler.h
//  Test_Framework
//
//  Created by 李帅 on 15/8/16.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMDCircleLoader.h"

typedef NS_ENUM(NSInteger, IndicatorStyle) {
    /// 加载数据
    IndicatorStyleLoadingData = 1,
    /// 上传文件
    IndicatorStyleUploadFile,
    /// 普通控件
    IndicatorStyleGeneralHUD
};
@interface IndicatorHandler : NSObject


/**
 *  开始加载数据动画
 */
+ (void)addIndicatorHUD_InView:(UIView *)inView indicatorStyle:(IndicatorStyle)style;

/**
 *  停止加载数据动画
 */
+ (void)stopIndicatorHUD_InView:(UIView *)inView;



@end
