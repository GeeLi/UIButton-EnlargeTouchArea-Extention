//
//  BaseScrollView.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView
@synthesize keyboardHeight = keyboardHeight;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        canInit = YES;
        
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notify
{
    if (canInit) {
        contentSizeHeight = self.contentSize.height;
        canInit = NO;
    }
    CGRect keyboardRect = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardHeight = keyboardRect.size.height;
    self.contentSize = CGSizeMake(0, contentSizeHeight + keyboardHeight);
}

- (void)keyboardWillHide:(NSNotification *)notify
{
    self.contentSize = CGSizeMake(0, self.contentSize.height - keyboardHeight);
    canInit = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
