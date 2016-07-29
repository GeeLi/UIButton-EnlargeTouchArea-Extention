//
//  InputPasswordView.m
//  PayPassword
//
//  Created by Joel on 15/8/20.
//  Copyright (c) 2015年 Joel. All rights reserved.
//

#import "InputPasswordView.h"

#define kInputNumCount 6

@interface InputPasswordView ()<UITextFieldDelegate>


// 输入的个数
@property (assign, nonatomic) NSInteger inputNum;

@end

@implementation InputPasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (UITextField *)responsder {
    if (!_responsder) {
        _responsder = [[UITextField alloc] init];
        _responsder.delegate = self;
        _responsder.keyboardType = UIKeyboardTypeNumberPad;
        _responsder.secureTextEntry = YES;
        [_responsder addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_responsder];
    }
    return _responsder;
}

- (void)textFieldEditingChanged:(UITextField *)sender {
    self.inputNum = sender.text.length;
    if (self.inputNum == kInputNumCount) {
        !self.finishedInputBlock?:self.finishedInputBlock(self.responsder.text);
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
   
    // 输入背景图
    UIImage *inputBackImage = [UIImage imageNamed:@"input_trade_background"];
    [inputBackImage drawInRect:self.bounds];
    
    // 画点
    UIImage *pointImage = [UIImage imageNamed:@"black_dot"];
    
    CGFloat pointWH = pointImage.size.width;
    CGFloat perInputViewW = self.bounds.size.width/kInputNumCount;
    CGFloat perInputViewH = self.bounds.size.height;
    CGFloat firstCenterPointX = (perInputViewW-pointWH)*0.5;
    CGFloat pointY = (perInputViewH-pointWH)*0.5;
    CGFloat pointX = firstCenterPointX;
    
    for (NSInteger i = 0; i < self.inputNum; i++) {
        pointX = firstCenterPointX+i*perInputViewW;
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointWH, pointWH)];
    }
}

- (void)tap {
    [self.responsder becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length > 0) {
        if (textField.text.length + string.length > kInputNumCount) {
            return NO;
        }
    }
    return YES;
}

@end
