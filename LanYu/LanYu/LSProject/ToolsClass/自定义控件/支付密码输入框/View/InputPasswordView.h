//
//  InputPasswordView.h
//  PayPassword
//
//  Created by Joel on 15/8/20.
//  Copyright (c) 2015年 Joel. All rights reserved.
//

#import <UIKit/UIKit.h>

// 屏幕的宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface InputPasswordView : UIView

// 响应者
@property (strong, nonatomic) UITextField *responsder;


/**
 *  6位支付密码输入完成的回调
 */
@property (copy, nonatomic) void (^finishedInputBlock)(NSString *inputedPassword);


@end
