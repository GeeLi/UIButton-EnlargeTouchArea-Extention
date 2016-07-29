//
//  PayFixedAmountPopView.m
//  Num012&017
//
//  Created by 苑佳帅 on 15/9/8.
//  Copyright (c) 2015年 chaziyjs. All rights reserved.
//

#import "PayFixedAmountPopView.h"

#define FontSize [UIScreen mainScreen].bounds.size.height > 480 ? 15.0 : 12.0

@implementation PayFixedAmountPopView

- (void)dealloc
{
    self.inputPasswordView = nil;
    self.back_image = nil;
    self.cancel_BTN = nil;
    self.title_L = nil;
    self.amount_textL = nil;
    self.amount = nil;
}

- (instancetype)initWithFrame:(CGRect)frame AmountWith:(NSString *)amount Delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.delegate = delegate;
        //标题
        self.title_L = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 2 / 9)];
        self.title_L.textAlignment = NSTextAlignmentCenter;
        self.title_L.font = [UIFont systemFontOfSize:FontSize];
        self.title_L.textColor = [UIColor whiteColor];
        self.title_L.backgroundColor = [UIColor colorWithRed:60 / 255.0 green:61 / 255.0 blue:62/ 255.0 alpha:1];
        self.title_L.text = @"请输入支付密码";
        [self addSubview:self.title_L];
        
        //取消键
        self.cancel_BTN = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.height * 2 / 9, frame.size.height * 2 / 9)];
        [_cancel_BTN setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        _cancel_BTN.imageEdgeInsets = UIEdgeInsetsMake(frame.size.height * 2 / 9 / 3, frame.size.height * 2 / 9 / 3, frame.size.height * 2 / 9 / 3, frame.size.height * 2 / 9 / 3);
        [self addSubview:self.cancel_BTN];
        //文字"金额"
        self.amount_textL = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 4, frame.size.height / 3, frame.size.width * 0.15, frame.size.height / 9)];
        self.amount_textL.textAlignment = NSTextAlignmentCenter;
        self.amount_textL.font = [UIFont systemFontOfSize:FontSize];
        self.amount_textL.text = @"金额:";
        [self addSubview:self.amount_textL];
        //金额的数字部分
        NSString *count = [NSString stringWithFormat:@"¥ %@", amount];
        self.amount = [[UILabel alloc] initWithFrame:CGRectMake(DEF_RIGHT_VIEW(_amount_textL) + 10, frame.size.height / 3, frame.size.width * 0.5, frame.size.height / 9)];
        self.amount.textAlignment = NSTextAlignmentLeft;
        self.amount.textColor = [UIColor redColor];
        self.amount.font = [UIFont systemFontOfSize:FontSize];
        self.amount.text = count;
        [self addSubview:self.amount];
        //密码输入区
        self.inputPasswordView = [[InputPasswordView alloc] initWithFrame:CGRectMake(frame.size.width / 2 - (frame.size.width * 0.88 / 2), frame.size.height * 0.57, frame.size.width * 0.88, frame.size.width * 0.88 / 6)];
        self.inputPasswordView.responsder.keyboardType = UIKeyboardTypeNumberPad;
        self.inputPasswordView.responsder.secureTextEntry = YES;
        [self.inputPasswordView.responsder becomeFirstResponder];
        [self addSubview:self.inputPasswordView];
        
        __weak PayFixedAmountPopView *weakself = self;
        [weakself.inputPasswordView setFinishedInputBlock:^(NSString * payPassword) {
            [weakself.delegate inputPasswordFinishWith:payPassword];
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
