//
//  CUTextField.h
//  TextFieldTest
//
//  Created by 李帅 on 15/6/30.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWTextField : UITextField

/// 占位符离边缘的距离
@property (nonatomic, assign) NSInteger placeHolderGap;

/// 光标离边缘的距离
@property (nonatomic, assign) NSInteger editGap;

/// 显示文本离边缘的距离
@property (nonatomic, assign) NSInteger textRectGap;



@end
