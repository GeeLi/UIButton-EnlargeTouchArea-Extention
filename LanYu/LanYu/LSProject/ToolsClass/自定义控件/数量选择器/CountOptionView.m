//
//  CountOptionView.m
//  test
//
//  Created by 李帅 on 15/8/25.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "CountOptionView.h"

@implementation CountOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:1];
        self.layer.borderWidth = 0.8;
        self.layer.borderColor = [UIColor colorWithRed:180 / 255.0 green:180 / 255.0 blue:180 / 255.0 alpha:1].CGColor;
        
        imgWidth = frame.size.height / 3;
        
        self.initialValue = 1; // 默认初始值为1
        self.changeNumber = 1; // 默认每次改变的数量为1
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _reduceButton.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    _reduceButton.backgroundColor = [UIColor whiteColor];
    [_reduceButton setImage:[UIImage imageNamed:@"-@2x.png"] forState:UIControlStateNormal];
    CGFloat topGap = (self.frame.size.height - imgWidth) / 2;
    [_reduceButton setImageEdgeInsets:UIEdgeInsetsMake(topGap, topGap, topGap, topGap)];
    _reduceButton.adjustsImageWhenHighlighted = NO;
    _reduceButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _reduceButton.tag = 1;
    [_reduceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceButton];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    _addButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [_addButton setImage:[UIImage imageNamed:@"+@2x.png"] forState:UIControlStateNormal];
    [_addButton setImageEdgeInsets:UIEdgeInsetsMake(topGap, topGap, topGap, topGap)];
    _addButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _addButton.adjustsImageWhenHighlighted = NO;
    _addButton.tag = 2;
    [_addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addButton];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(_reduceButton.frame.size.width + 0.8, 0, self.frame.size.width - self.frame.size.height * 2 - 1.6, self.frame.size.height)];
    _textField.backgroundColor = [UIColor whiteColor];
    [_textField setEnabled:NO];
    _textField.text = [NSString stringWithFormat:@"%ld", _initialValue];
    _textField.textAlignment = NSTextAlignmentCenter;   
    [_textField setFont:[UIFont systemFontOfSize:16.0]];
    [_textField setTextColor:[UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:150 / 255.0 alpha:1]];
    [self addSubview:_textField];
    
}

//- (void)setInitialValue:(NSInteger)initialValue
//{
//    _initialValue = initialValue;
//    _textField.text = [NSString stringWithFormat:@"%ld", _initialValue];
//}

- (void)buttonAction:(UIButton *)sender
{
    NSInteger text = [_textField.text integerValue];
    if (sender.tag == 1) {
        if (text == _changeNumber && _reduceToZero) {
            // 删除为0
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除这件商品吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertView show];  
        } else if (text >= _changeNumber * 2) {
            _textField.text = [NSString stringWithFormat:@"%ld", text - _changeNumber];
            // 当数值发生改变时调用代理方法
            [self.delegate changeCount_Text:_textField.text buttonTag:sender.tag];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买数量不能少于起订量" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertView show]; 
        }
        
    } else {
        _textField.text = [NSString stringWithFormat:@"%ld", text + _changeNumber];
        // 当数值发生改变时调用代理方法
        [self.delegate changeCount_Text:_textField.text buttonTag:sender.tag];
    }

    
}

#pragma mark - 减到0
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSInteger text = [_textField.text integerValue];
        _textField.text = [NSString stringWithFormat:@"%ld", text - _changeNumber];
        [self.delegate changeCount_Text:_textField.text buttonTag:1];

    }
}

@end
