//
//  TabBarViewController.m
//  WelfareClub
//
//  Created by 李帅 on 15/8/21.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#define BarButton_Width [UIScreen mainScreen].bounds.size.width / _controllerArray.count // button宽
#define IconHeight 24.5 / 1.2
@interface TabBarViewController ()//<LoginViewControllerDelegate>
{
    UIButton *lastButton;
}

@end

@implementation TabBarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 加载tabBar所管理的视图控制器
//    [self loadViewController];
//    
//    // 创建自定义的button
//    [self loadTabBarView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 删除系统的tabBarButton
    for (UIView *subView in self.tabBar.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:@"UITabBarButton"]) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - 创建TabBar所管理的视图控制器
- (void)loadViewController
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _controllerArray.count; i++) {
        id class = NSClassFromString(_controllerArray[i]);
        UIViewController *controller = [[class alloc] init];
        NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:controller];
        controller.hidesBottomBarWhenPushed = NO;
        [array addObject:nav];
    }
    
    self.viewControllers = array;
}

#pragma mark - 创建自定义button
- (void)loadTabBarView
{
    // 初始化tabBarView
    self.tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 49)];
    _tabBarView.backgroundColor = GRAY_LEVEL3;//WHITE_COLOR
    _tabBarView.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabBarView];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    [self.tabBar setShadowImage:[[UIImage alloc]init]];
    // 自定义tabBarButton
    for (int i = 0; i < _controllerArray.count; i++) {
        FZButton *button = [UIMethod create_FZButton_Frame:CGRectMake(i * BarButton_Width, 0, BarButton_Width, 49) image:_images[i] imgSize:CGSizeMake(BarButton_Width, IconHeight) title:_titles[i] titleSize:CGSizeMake(BarButton_Width, 49 / 2 - 2) bottomHeight:0 fontSize:11 inView:_tabBarView];        
        [button setBackgroundColor:DEF_RGB_COLOR(104, 90, 167, 1)];//WHITE_COLOR
        // titleLabel
        [button setTitleColor:GRAY_LEVEL1 forState:UIControlStateNormal];
        [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected | UIControlStateHighlighted];
        // imageView
        [button setImage:[UIImage imageNamed:_selectedImages[i]] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:_selectedImages[i]] forState:UIControlStateSelected | UIControlStateHighlighted];
        // 创建角标
        [button createBadge];

        // 默认第一个button被选中
        if (i == 0) {
            button.selected = YES;
            lastButton = button;
        }
        button.tag = i + 1;
        [button addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 测试
        if (i == 1 || i == _controllerArray.count - 1) {
            button.showBadge = YES;
        }
    }
}

- (void)tabBarAction:(UIButton *)sender
{

        self.selectedIndex = sender.tag - 1;
        lastButton.selected = NO;
        sender.selected = YES;
        lastButton = sender;
}

//- (void)loginSuccess
//{
//    self.selectedIndex = 1;
//    lastButton.selected = NO;
//    UIButton *clickButton = (UIButton *)[self.tabBarView viewWithTag:2];
//    clickButton.selected = YES;
//    lastButton = clickButton;
//
//}

#pragma mark - 显示badge
- (void)showBadgeWithIndex:(NSInteger)index
{
    FZButton *button = (FZButton *)[self.tabBarView viewWithTag:index + 1];
    button.showBadge = YES;
}

#pragma mark - 消除badge
- (void)hideBadgeWithIndex:(NSInteger)index
{
    FZButton *button = (FZButton *)[self.tabBarView viewWithTag:index + 1];
    button.showBadge = NO;
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
