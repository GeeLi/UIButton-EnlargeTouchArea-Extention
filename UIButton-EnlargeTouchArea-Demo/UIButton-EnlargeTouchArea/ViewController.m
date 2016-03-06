//
//  ViewController.m
//  UIButton-EnlargeTouchArea
//
//  Created by 李帅 on 16/3/4.
//  Copyright © 2016年 company. All rights reserved.
//

#import "ViewController.h"
#define WINDOWRECT [UIScreen mainScreen].bounds
#import "UIButton+LSEnlargeTouchArea.h"
@interface ViewController ()
//消息提示框
{
    UIView *_showView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(self.view.bounds.size.width * 0.5 - 50, self.view.bounds.size.height * 0.5 - 30, 100, 60);
    [testButton setTitle:@"点击测试" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [testButton setBackgroundColor:[UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1.0]];
    [testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    //设置button的额外响应区域
    [testButton setEnlargeEdgeWithTop:100 right:100 bottom:100 left:100];
}

- (void)testButtonAction{
    [self showMessage:@"系统响应了按钮的点击事件"];
}

//消息提示框
- (void)showMessage:(NSString *)message{
    if(_showView == nil)
    {
        _showView =  [[UIView alloc]init];
    }
    else
    {
        [_showView removeFromSuperview];
        _showView = [[UIView alloc] init];
    }
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 0.9f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [self.view.window addSubview:showView];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake(290, 9000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size;
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    showView.frame = CGRectMake((WINDOWRECT.size.width - LabelSize.width - 20)/2, WINDOWRECT.size.height,LabelSize.width+20, LabelSize.height+10);
    [showView addSubview:label];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        showView.frame = CGRectMake((WINDOWRECT.size.width - LabelSize.width - 20)/2, WINDOWRECT.size.height - 80, LabelSize.width+20, LabelSize.height+10);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.0 animations:^{
            showView.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [showView removeFromSuperview];
            }
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
