//
//  CountOptionView.h
//  test
//
//  Created by 李帅 on 15/8/25.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountOptionDelegate <NSObject>

- (void)changeCount_Text:(NSString *)text buttonTag:(NSInteger)buttonTag;

@end

@interface CountOptionView : UIButton<UIAlertViewDelegate>
{
    CGFloat imgWidth; // 加号减号的宽
    NSInteger count;  
}
// 数量显示框
@property (nonatomic, strong) UITextField *textField;

// 增加按钮
@property (nonatomic, strong) UIButton *addButton;
// 减少按钮呢
@property (nonatomic, strong) UIButton *reduceButton;

@property (nonatomic, assign) NSInteger changeNumber; // 每次改变多少数量

@property (nonatomic, assign) NSInteger initialValue; // 初始值

@property (nonatomic, assign) BOOL reduceToZero; // 是否可以减到0



/// 代理
@property (nonatomic, weak) id<CountOptionDelegate> delegate;




@end
