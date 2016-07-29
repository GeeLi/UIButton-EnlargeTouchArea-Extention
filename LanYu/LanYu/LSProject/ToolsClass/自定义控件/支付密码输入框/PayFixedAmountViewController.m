//
//  PayFixedAmountViewController.m
//  Num012&017
//
//  Created by 苑佳帅 on 15/9/8.
//  Copyright (c) 2015年 chaziyjs. All rights reserved.
//

#import "PayFixedAmountViewController.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationSpring.h"
#import "PayFixedAmountPopView.h"

@interface PayFixedAmountViewController ()<PayFixedAmountDelegate>

@end

@implementation PayFixedAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] init];
    button.bounds = CGRectMake(0, 0, self.view.frame.size.width / 2, 50);
    button.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [button setTitle:@"点击弹出视图" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)popToView
{
    PayFixedAmountPopView *pay = [[PayFixedAmountPopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.74, self.view.frame.size.height * 0.24) AmountWith:@"1576.00" Delegate:self];
    [pay.cancel_BTN addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    pay.presentVC = self;
    [self lew_presentPopupView:pay animation:[LewPopupViewAnimationSpring new]];
}

- (void)cancelAction
{
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
}

- (void)inputPasswordFinishWith:(NSString *)password
{
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
