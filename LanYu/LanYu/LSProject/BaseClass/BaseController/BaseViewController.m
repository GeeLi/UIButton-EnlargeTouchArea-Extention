//
//  BaseViewController.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBarViewController.h"
#define WINDOWRECT [UIScreen mainScreen].bounds
@interface BaseViewController ()

//消息提示框
{
    UIView *_showView;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];        
//    [self setNavigationBarAttribute];
    //创建导航栏
//    [self loadNavigationBar];
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController.navigationBar setHidden:YES];
//    [self loadNavigationBar];
//    self.contentView.hidden = YES;
//    self.navigationBar.hidden = NO;
//    self.statusBar.hidden = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UINavigationBar appearance] setTintColor:BLACK_COLOR];
//    self.navigationController.navigationBar.backgroundColor = BLACK_GROUND;
//    self.navigationController.navigationBar.tintColor = BLACK_COLOR;
    // 创建contentView
//    [self loadContentView];
    self.view.backgroundColor = GRAY_BACKGROUND;
    self.navigationController.navigationBar.translucent = NO;
    //渐变导航栏
//    [self.navigationController.navigationBar setBackgroundImage:[UIMethod create_BgImageFromColors: @[DEF_RGB_COLOR(122, 136, 191, 1),DEF_RGB_COLOR(155, 161, 208, 1),DEF_RGB_COLOR(122, 136, 191, 1)] withFrame: CGRectMake(0, 0, DEF_SCREEN_WIDTH, 64) direction:BgImgColorDirectionHorizontal] forBarMetrics:UIBarMetricsDefault];
}

/********************默认基类方法********************/

#pragma mark - 创建contentView
- (void)loadContentView
{
    self.contentView = [[BaseScrollView alloc] init];
    _contentView.frame = CGRectMake(0, self.navigationController.navigationBarHidden ? (DEF_STATUSBARHEIGHT + DEF_STATUSBARHEIGHT) : 0, DEF_SCREEN_WIDTH, DEF_CONTENT_HEIGHT);
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.scrollEnabled = NO;
    _contentView.bounces = NO;
    _contentView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, _contentView.frame.size.height);
    [self.view addSubview:_contentView];

}

#pragma mark - 创建自定义的navigationBar (用于多个页面拥有不同的navigationBar)
- (void)loadNavigationBar
{
    //创建状态栏和导航栏
    self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_STATUSBARHEIGHT)];
    _statusBar.backgroundColor = BLACK_GROUND;
    [self.view addSubview:_statusBar];
    
    self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, DEF_HEIGHT_VIEW(_statusBar), DEF_SCREEN_WIDTH, DEF_NAVBARHEIGHT)];
    _navigationBar.backgroundColor = BLACK_GROUND;
    [self.view addSubview:_navigationBar];
}
#pragma mark 用图片设置搜navigationBar的背景
- (void)setNavigationBarBackgroundStyleWithImg:(UIImage *)image{
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:self.statusBar.bounds];
    [backIV setImage:image];
    [self.statusBar insertSubview:backIV atIndex:0];
    UIImageView *backNavIV = [[UIImageView alloc]initWithFrame:self.navigationBar.bounds];
    [backNavIV setImage:image];
    [self.navigationBar insertSubview:backNavIV atIndex:0];

}

#pragma mark - 设置navigationBar的属性
- (void)setNavigationBarAttribute
{
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationItem setHidesBackButton:YES];
//    self.navigationController.navigationBar.barTintColor = DEEP_GREEN_COLOR;

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 添加标题
- (void)addTitle:(NSString *)title
{
    // 自定义navigationBar的情况
    if (self.navigationController.navigationBarHidden == YES) {
        UILabel *titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(88, 0, DEF_SCREEN_WIDTH - 88 * 2, 44)];
        [titleLabel setText:title];
        [titleLabel setTextColor:BLACK_COLOR];
        [titleLabel setFont:H2_Font];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationBar addSubview:titleLabel];
    } else {
        // 使用系统的navigationBar的情况
        self.title = title;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: BLACK_COLOR,
              NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]
             };
    }
}

#pragma mark - 添加返回按钮(只有图片)
- (void)addBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"fanhui2"] forState:UIControlStateHighlighted];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tintColor = BLACK_COLOR;
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:backButton];

    } else {
        // 添加barButtonItem
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];
    }
}

#pragma mark - 添加返回按钮(有返回箭头和文字)
- (void)addBackButtonWithText:(NSString *)text
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80, 44);
    // 设置图片和文字的位置
    [backButton setImage:[UIImage imageNamed:@"ic_button_left"] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(11, 8, 11, 40)];
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton setTitle:text forState:UIControlStateNormal];
    [backButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 10)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:backButton];

    } else {
        // 添加barButtonItem
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];
    }
    
}

#pragma mark - 添加子视图
- (void)addSubview:(UIView *)view
{
    // 将所有的其它控件添加到contentView上, 而不是self.view上
    [self.contentView addSubview:view];
}

#pragma mark - 添加一个左按钮
- (UIButton *)addLeftButtonWithImage:(NSString *)image imageSize:(CGSize)size
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
    [leftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (size.width != 0 && size.height != 0) {
        CGFloat topGap = (44 - size.height) / 2;
        CGFloat leftGap = (44 - size.width) / 2;
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        leftButton.adjustsImageWhenHighlighted = NO;
    }
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:leftButton];

    } else {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = - 16;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];

    }
    return leftButton;
}

#pragma mark - 添加2个左按钮
- (NSArray *)addTwoLeftButtonWithImage1:(NSString *)image1 imageSize1:(CGSize)size1 
                            image2:(NSString *)image2 imageSize2:(CGSize)size2
{
    // 从左往右依次为按钮1, 按钮2
    UIButton *leftButton1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton1.frame = CGRectMake(0, 0, 44, 44);
    [leftButton1 setImage:[UIImage imageNamed:image1] forState:UIControlStateNormal];
    if (size1.width != 0 && size1.height != 0) {
        CGFloat topGap = (44 - size1.height) / 2;
        CGFloat leftGap = (44 - size1.width) / 2;
        [leftButton1 setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        leftButton1.imageView.contentMode = UIViewContentModeScaleAspectFit;
        leftButton1.adjustsImageWhenHighlighted = NO;
    }
    leftButton1.tag = 1;
    [leftButton1 addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftButton2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton2.frame = CGRectMake(DEF_WIDTH_VIEW(leftButton1), 0, 44, 44);
    [leftButton2 setImage:[UIImage imageNamed:image2] forState:UIControlStateNormal];
    if (size2.width != 0 && size2.height != 0) {
        CGFloat topGap = (44 - size2.height) / 2;
        CGFloat leftGap = (44 - size2.width) / 2;
        [leftButton2 setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        leftButton2.imageView.contentMode = UIViewContentModeScaleAspectFit;
        leftButton2.adjustsImageWhenHighlighted = NO;
    }
    leftButton2.tag = 2;
    [leftButton2 addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:leftButton1];
        [self.navigationBar addSubview:leftButton2];
    } else {
        // 该视图放两个button
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
        [barView addSubview:leftButton1];
        [barView addSubview:leftButton2];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];
    }
    return @[leftButton1, leftButton2];
}

#pragma mark - 添加一个右按钮
- (UIButton *)addRightButtonWithImage:(NSString *)image imageSize:(CGSize)size
{
    UIButton *rightButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(DEF_SCREEN_WIDTH - 44, 0, 44, 44);    
    [rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (size.width != 0 && size.height != 0) {
        CGFloat topGap = (44 - size.height) / 2;
        CGFloat leftGap = (44 - size.width) / 2;
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        rightButton.adjustsImageWhenHighlighted = NO;
    }
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:rightButton];
        
    } else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.rightBarButtonItems = @[space, rightItem];
    }
    return rightButton;
}

#pragma mark - 添加2个右按钮
- (NSArray *)addTwoRightButtonWithImage1:(NSString *)image1 imageSize1:(CGSize)size1 
                                 image2:(NSString *)image2 imageSize2:(CGSize)size2
{
    // 从左往右依次为按钮1, 按钮2
    UIButton *rightButton1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton1.frame = CGRectMake(0, 0, 44, 44);
    [rightButton1 setImage:[UIImage imageNamed:image1] forState:UIControlStateNormal];
    if (size1.width != 0 && size1.height != 0) {
        CGFloat topGap = (44 - size1.height) / 2;
        CGFloat leftGap = (44 - size1.width) / 2;
        [rightButton1 setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        rightButton1.imageView.contentMode = UIViewContentModeScaleAspectFit;
        rightButton1.adjustsImageWhenHighlighted = NO;
    }   
    rightButton1.tag = 1;
    [rightButton1 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton2.frame = CGRectMake(DEF_RIGHT_VIEW(rightButton1), 0, 44, 44);
    [rightButton2 setImage:[UIImage imageNamed:image2] forState:UIControlStateNormal];
    if (size2.width != 0 && size2.height != 0) {
        CGFloat topGap = (44 - size2.height) / 2;
        CGFloat leftGap = (44 - size2.width) / 2;
        [rightButton2 setImageEdgeInsets:UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap)];
        rightButton2.imageView.contentMode = UIViewContentModeScaleAspectFit;
        rightButton2.adjustsImageWhenHighlighted = NO;
    }  
    rightButton2.tag = 2;
    [rightButton2 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        rightButton1.frame = CGRectMake(DEF_SCREEN_WIDTH - 88, 0, 44, 44);
        rightButton2.frame = CGRectMake(DEF_RIGHT_VIEW(rightButton1), 0, 44, 44);
        [self.navigationBar addSubview:rightButton1];
        [self.navigationBar addSubview:rightButton2];
    } else {
        // 该视图放两个button
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 44)];
        [barView addSubview:rightButton1];
        [barView addSubview:rightButton2];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.rightBarButtonItems = @[space, rightItem];
    }
    return @[rightButton1, rightButton2];
}

#pragma mark - 创建一个只有文字的左按钮
- (UIButton *)addLeftButtonWithTitle:(NSString *)title {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [GlobalMethod widthOfStr:title font:H4_Font height:16];
    leftButton.frame = CGRectMake(10, 0, width, 44);
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:H4_Font];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:leftButton];
        
    } else {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -5;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];
    }
    return leftButton;
}

#pragma mark - 创建一个只有文字的右按钮
- (UIButton *)addRightButtonWithTitle:(NSString *)title {
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [GlobalMethod widthOfStr:title font:H3_Font height:16] + 10;
    rightButton.frame = CGRectMake(DEF_SCREEN_WIDTH - 10 - width, 0, width, 44);
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:H3_Font];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 判断是否是自定义的navigationBar
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:rightButton];
        
    } else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -5;
        self.navigationItem.rightBarButtonItems = @[space, rightItem];
    }
    return rightButton;
}

#pragma mark - 返回按钮点击事件
- (void)backButtonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    // 取消网络请求
    Singleton *single = [Singleton sharedSingleton];
    [single.sessionTask cancel];
    
    // 返回页面
    if (self.presentingViewController && self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 左按钮点击事件
- (void)leftButtonAction:(UIButton *)sender
{
    
}

#pragma mark - 右按钮点击事件
- (void)rightButtonAction:(UIButton *)sender
{
    
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

#pragma mark - 设置tableView的代理, 并注册cell重用池
- (void)registTableView:(UITableView *)tableView class:(Class)class cellName:(NSString *)cellName
{
    self.tableView = tableView;
    tableView.backgroundColor = GRAY_LEVEL3;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:class forCellReuseIdentifier:cellName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.tableView setSeparatorColor:GRAY_LEVEL2];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
         
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
         
}

#pragma mark - 判断字符串是否为空, 或全空格
- (BOOL)isEffectiveObject:(id)object
{
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return NO;
    } else if ([object isKindOfClass:[NSString class]] && [[object stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

#pragma mark - 创建一个有图片和文字的barButtonItem
- (FZButton *)addLeftFZButtonWithTitle:(NSString *)title
                           image:(NSString *)image highlighted:(NSString *)highLighted
{
    // 添加左按钮
    FZButton *leftButton = [UIMethod create_FZButton_Frame:CGRectMake(10, 0, 44, 44) image:image imgSize:CGSizeMake(18, 18) title:title titleSize:CGSizeMake(44, 22) bottomHeight:0 fontSize:12 inView:nil];
    [leftButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
//    [leftButton setTitleColor:BLACK_COLOR forState:UIControlStateHighlighted];
    [leftButton setImage:[UIImage imageNamed:highLighted] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:leftButton];
    } else {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.leftBarButtonItems = @[space, leftItem];
    }
    return leftButton;
}

- (FZButton *)addRightFZButtonWithTitle:(NSString *)title
                               image:(NSString *)image highlighted:(NSString *)highLighted
{
    // 添加右按钮
    FZButton *rightButton = [UIMethod create_FZButton_Frame:CGRectMake(DEF_SCREEN_WIDTH - 10 - 44, 0, 44, 44) image:image imgSize:CGSizeMake(18, 18) title:title titleSize:CGSizeMake(44, 22) bottomHeight:0 fontSize:12 inView:nil];
    [rightButton setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
//    [rightButton setTitleColor:BLACK_COLOR forState:UIControlStateHighlighted];
    [rightButton setImage:[UIImage imageNamed:highLighted] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationBar addSubview:rightButton];
    } else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = -16;
        self.navigationItem.rightBarButtonItems = @[space, rightItem]; 
    }
    return rightButton;
}

#pragma mark - 回收键盘
- (void)returnKeyboardWithView:(UIView *)inView
{
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGest.delegate = self;
    [inView addGestureRecognizer:tapGest];
}

- (void)tapAction:(UIGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//#pragma mark - 上拉加载, 下拉刷新控件
//- (void)addRefreshHeader:(UIScrollView *)scrollView refreshingBlock:(void(^)())refreshingBlock
//{
//    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{            
//            // 拿到当前的下拉刷新控件，结束刷新状态
//            [scrollView.header endRefreshing];
//            // 刷新完毕, 重置没有更多的数据
//            MJRefreshAutoGifFooter *gifFooter = (MJRefreshAutoGifFooter *)scrollView.footer;
//            gifFooter.stateLabel.hidden = YES;
//            gifFooter.gifView.hidden = NO;
//            [scrollView.footer resetNoMoreData];
//            
//            refreshingBlock();
//
//        });
//
//    }];
//    gifHeader.lastUpdatedTimeLabel.hidden = YES;
//    gifHeader.stateLabel.hidden = YES;
//    scrollView.header = gifHeader;
//    
//}

//- (void)addRefreshFooter:(UIScrollView *)scrollView refreshingBlock:(void(^)())refreshingBlock
//{    
//    __block MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{            
//            // 拿到当前的下拉刷新控件，结束刷新状态
//            gifFooter.stateLabel.hidden = NO;
//            [scrollView.footer endRefreshingWithNoMoreData];
//            
//            refreshingBlock();
//
//        });
//
//    }];
//    gifFooter.stateLabel.hidden = YES;
//    gifFooter.refreshingTitleHidden = YES;
//    scrollView.footer = gifFooter;
//
//}

- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicatorView setHidesWhenStopped:YES];
        
        //        if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationPortrait) {
        //            _activityIndicatorView.center = self.navigationController.view.center;
        //        }else
        //        {
        //            _activityIndicatorView.center = CGPointMake(WINDOWRECT.size.height/2, WINDOWRECT.size.width/2);
        //        }
        //        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _activityIndicatorView.center = CGPointMake(DEF_SCREEN_WIDTH * 0.5, DEF_SCREEN_HEIGHT - 64 - DEF_SCREEN_HEIGHT * 0.5);
        
        _activityIndicatorView.color = [UIColor blackColor];
        
        //        if (self.navigationController) {//针对导航栏透明做的
        //            [self.navigationController.view addSubview:_activityIndicatorView];
        //        }else
        //        {
        [self.view addSubview:_activityIndicatorView];
        //        }
        
    }
    return _activityIndicatorView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^
           {
               //跳转界面
               [super presentViewController:viewControllerToPresent animated:flag completion:completion];
           });
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
