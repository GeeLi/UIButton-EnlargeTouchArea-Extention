//
//  GuideViewController.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/7/16.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *enterButton;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.statusBar.hidden = YES;
    self.navigationBar.hidden = YES;
    self.contentView.frame = self.view.bounds;
    
    [self createEnterButton];
    [self loadGuideImage];
//    [self createPageControl];
}

- (void)loadGuideImage
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH * 3, DEF_SCREEN_HEIGHT);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * DEF_SCREEN_WIDTH, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"guide%d", i + 1] ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imgView setImage:image];
        
        imgView.userInteractionEnabled = YES;
        [_scrollView addSubview:imgView];
        
        if (i == 2) {
            [imgView addSubview:_enterButton];
        }
    }
    [self.contentView addSubview:_scrollView];
    
}

- (void)createPageControl
{
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT - 60, DEF_SCREEN_WIDTH, 40)];
    if (iPhone4) {
        _pageControl.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - 40, DEF_SCREEN_WIDTH, 30);
    }
    _pageControl.numberOfPages = 2;
    _pageControl.currentPageIndicatorTintColor = nil;
    _pageControl.pageIndicatorTintColor = DEF_RGB_COLOR(220, 220, 220, 1);

    [self.contentView addSubview:_pageControl];
    

}

- (void)createEnterButton
{
    self.enterButton = [UIMethod create_Button_Frame:CGRectMake(DEF_SCREEN_WIDTH / 2 - 50, DEF_SCREEN_HEIGHT - 70, 100, 40) title:nil titleColor:nil font:nil backgroundColor:nil backgroundImage:nil backgroundColorHighlighted:nil inView:self.contentView];
    if (iPhone4) {
        _enterButton.frame = CGRectMake(DEF_SCREEN_WIDTH / 2 - 50, DEF_SCREEN_HEIGHT - 80, 100, 42);
    } else if (iPhone5) {
        _enterButton.frame = CGRectMake(DEF_SCREEN_WIDTH / 2 - 50, DEF_SCREEN_HEIGHT - 100, 100, 42);
    } else if (iPhone6Plus) {
        _enterButton.frame = CGRectMake(DEF_SCREEN_WIDTH / 2 - 50, DEF_SCREEN_HEIGHT - 120, 100, 42);
    }
    [_enterButton setImage:[UIImage imageNamed:@"ic_record"] forState:UIControlStateNormal];
    [_enterButton setBackgroundImage:[UIImage imageNamed:@"ic_record1"] forState:UIControlStateHighlighted];

    
    [_enterButton addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = 1;
    }
}

- (void)enterButtonAction:(UIButton *)sender
{
    [UserDefaults setBool:YES forKey:@"firstLaunch"];
//    NavigationViewController *nav = (NavigationViewController *)self.navigationController;

    // 判断是否登录
    if ([[UserDefaults objectForKey:@"login"] isEqualToString:@"true"]) {

        
    } else {

    }
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
