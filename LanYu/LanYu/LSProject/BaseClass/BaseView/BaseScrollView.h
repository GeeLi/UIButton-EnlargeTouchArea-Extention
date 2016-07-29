//
//  BaseScrollView.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScrollView : UIScrollView
{
    BOOL canInit;  // 只记录一次contentSize的高
    CGFloat contentSizeHeight;
}
// 键盘高
@property (nonatomic, assign) CGFloat keyboardHeight;


@end
