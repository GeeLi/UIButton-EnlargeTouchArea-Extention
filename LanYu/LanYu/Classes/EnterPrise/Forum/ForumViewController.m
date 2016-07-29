//
//  ForumViewController.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "ForumViewController.h"

@interface ForumViewController ()

@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"讨论区";
    [self addBackButton];
}

- (void)backButtonAction:(UIButton *)sender{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
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
