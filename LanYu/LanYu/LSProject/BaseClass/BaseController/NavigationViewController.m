//
//  NavigationViewController.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/18.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation NavigationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //    隐藏导航栏下面的分割线
//        [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//        self.navigationBar.shadowImage = [[UIImage alloc] init];
    }
    return self;
}

+ (NavigationViewController *)defaultNavigation
{
    static NavigationViewController *nav = nil;
    static dispatch_once_t predictor;
    dispatch_once(&predictor, ^{
        nav = [[NavigationViewController alloc] init];
    });
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.popdelegate = self.interactivePopGestureRecognizer.delegate;
    // 开启手势返回
    self.interactivePopGestureRecognizer.delegate = nil;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popdelegate;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }

}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [super pushViewController:viewController animated:animated];
//    });
//    
//}

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
