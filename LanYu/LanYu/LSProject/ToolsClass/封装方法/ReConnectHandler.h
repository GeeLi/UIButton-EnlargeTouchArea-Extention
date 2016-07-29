//
//  ReConnectHandler.h
//  test
//
//  Created by 李帅 on 15/9/22.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RequestType) {
    // get请求
    RequestTypeGet,
    // post请求
    RequestTypePost
};
// 请求成功以后的回调函数
typedef void(^SuccessBlock) (id json);

@interface ReConnectHandler : UIButton

/// block回调函数
@property (nonatomic, copy) SuccessBlock success;


- (void)addReConnectView_Url:(NSString *)url
                  parameters:(id)parameters
                      inView:(UIView *)inView
           isRemoveIndicator:(BOOL)isRemove
              indicatorStyle:(NSInteger)indicatorStyle
                 requestType:(NSInteger)requestType
                     success:(void (^)(id json))success;
@end
