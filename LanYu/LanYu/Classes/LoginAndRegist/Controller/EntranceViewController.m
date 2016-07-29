//
//  EntranceViewController.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/18.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//  应用的入口界面

#import "EntranceViewController.h"
#import "ReadingViewController.h"
#import "TranslationViewController.h"
#import "VocabViewController.h"
#import "SettingViewController.h"
#import "ForumViewController.h"
#import "SearchViewController.h"
#import "SDCycleScrollView.h"
#import "TabBarViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "YYText.h"
#import "UIView+YYAdd.h"
#define FUNCNUM 4
@interface EntranceViewController ()<UIAlertViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (nonatomic, weak) UIImageView *tipsIV;
@property (nonatomic, weak) UIImageView *translateIV;
@end

@implementation EntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.hidden = YES;
//    self.navigationBar.hidden = YES;
//    self.statusBar.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = WHITE_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DEF_RGB_COLOR(215, 215, 215, 1);
//    self.view.backgroundColor = WHITE_COLOR;
    [self addHeaderView];
    [self addTranslateView];
    [self addFunctionView];
//    [self addBottomView];
}

- (void)addHeaderView{
    //本地加载banner
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT * 0.35) imagesGroup:@[[UIImage imageNamed:@"bg0.jpg"],[UIImage imageNamed:@"bg1.jpg"],[UIImage imageNamed:@"bg2.jpg"],[UIImage imageNamed:@"bg3.jpg"],[UIImage imageNamed:@"bg4.jpg"],[UIImage imageNamed:@"bg5.jpg"]]];
        cycleScrollView.showPageControl = NO;
        cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _cycleScrollView = cycleScrollView;
    [self.view addSubview:cycleScrollView];
    //积分(未登录时不显示)
    
//    //标题
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((DEF_SCREEN_WIDTH - 200) * 0.5, 20, 200, 60)];
//    titleLabel.text = AUTO_CONVERT_LANGUAGEWITHTEXT(@"踏瑞社工");
//    titleLabel.textColor = WHITE_COLOR;
//    titleLabel.font = H2_Font;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:titleLabel];
    //个人/登陆
//    CGFloat loginBtnW = [GlobalMethod widthOfStr:@"登录" font:H2_Font height:60] + 20;
//    UIButton *userBtn = [UIMethod create_Button_Frame:CGRectMake(DEF_SCREEN_WIDTH - 40, 40, 20, 20) title:@"" titleColor:WHITE_COLOR font:H2_Font backgroundColor:[UIColor clearColor] backgroundImage:nil backgroundColorHighlighted:nil inView:self.view];
//    [userBtn setImage:[UIImage imageNamed:@"Home_icon.png"] forState:UIControlStateNormal];
//    userBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [userBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
//    [userBtn addTarget:self action:@selector(jumpToUser) forControlEvents:UIControlEventTouchUpInside];
    //搜索框
    CGFloat searchIVX = 40;
    CGFloat searchIVH = 30;
    CGFloat searchIVY = DEF_SCREEN_HEIGHT * 0.35 - searchIVH - 40;
    UIButton *searchBackGround = [[UIButton alloc]initWithFrame:CGRectMake(searchIVX * 1.5, searchIVY, DEF_SCREEN_WIDTH - searchIVX * 4, searchIVH)];
    searchBackGround.backgroundColor = WHITE_COLOR;
    searchBackGround.alpha = 0.6;
    searchBackGround.tag = 1006;
    searchBackGround.layer.cornerRadius = 5;
    searchBackGround.layer.masksToBounds = YES;
    [searchBackGround addTarget:self action:@selector(funcBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBackGround];
    
    UILabel *placeHoldLabel = [[UILabel alloc]initWithFrame:CGRectMake(searchIVX + 30, searchIVY, [GlobalMethod widthOfStr:AUTO_CONVERT_LANGUAGEWITHTEXT(@"请输入单词") font:H3_Font height:searchIVH], searchIVH)];
    placeHoldLabel.text = AUTO_CONVERT_LANGUAGEWITHTEXT(@"请输入单词");
    placeHoldLabel.textColor = BLACK_COLOR;
    placeHoldLabel.font = H3_Font;
    [self.view addSubview:placeHoldLabel];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(searchBackGround.frame) + searchIVH, searchIVY , searchIVH, searchIVH);
    [searchBtn setImage:[UIImage imageNamed:@"search2.png"] forState:UIControlStateNormal];
//    searchBtn.layer.cornerRadius = 0.5 * searchIVH;
//    searchBtn.layer.masksToBounds = YES;
    searchBtn.tag = 1007;
    [searchBtn addTarget:self action:@selector(funcBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:searchBtn];
}

- (void)addTranslateView{
    UIImageView *translateIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, DEF_SCREEN_HEIGHT * 0.45, DEF_SCREEN_WIDTH - 10 - 30, (DEF_SCREEN_WIDTH - 10 - 30) / 880 * 200)];
    _translateIV = translateIV;
    translateIV.image = [UIImage imageNamed:@"word0"];
    [self.view addSubview:translateIV];
    //控制条
    
    CGFloat funcIVH = 80;
    UIImageView *functionIV = [UIMethod create_ImageView_Frame:CGRectMake(0, CGRectGetMaxY(translateIV.frame) + 60, DEF_SCREEN_WIDTH, funcIVH) image:nil urlImage:nil inView:self.view];
    functionIV.userInteractionEnabled = YES;
    //    functionIV.backgroundColor = DEF_RGB_COLOR(78, 68, 233, 1);
    CGFloat funcWH = 80;
    CGFloat funcMarginX = (DEF_SCREEN_WIDTH - funcWH * 4) / 8.0;
    CGFloat funcMarginY = 0;
    for (NSInteger i = 0; i < FUNCNUM; i ++) {
        NSInteger row = i / 4;//行
        NSInteger col = i % 4;//列
        NSString *title = @"";
        if (i == 0) {
            title = @"social worker";
        }else if (i == 1){
            title = @"sociology";
        }else if (i == 2) {
            title = @"helping";
        }else {
            title = @"profession";
        }
        UIButton *funcBtn = [UIMethod create_Button_Frame:CGRectMake(funcMarginX + (funcWH + funcMarginX * 2) * col,funcMarginY + row * (funcWH + funcMarginY), funcWH, funcWH) title:title titleColor:BLACK_COLOR font:H5_Font backgroundColor:nil backgroundImage:nil backgroundColorHighlighted:nil inView:functionIV];
        [funcBtn setBackgroundColor:WHITE_COLOR forState:UIControlStateNormal];
        funcBtn.tag = 2000 + i;
        funcBtn.adjustsImageWhenHighlighted = NO;
        funcBtn.layer.cornerRadius = 0.5 * funcWH;
        funcBtn.layer.masksToBounds = YES;
        [funcBtn addTarget:self action:@selector(controlBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            funcBtn.selected = YES;
            funcBtn.layer.borderColor = [BLACK_COLOR CGColor];
            funcBtn.layer.borderWidth = 1;
        }
    }
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10 + 40, 40, DEF_SCREEN_WIDTH - 100, 1)];
    lineView.backgroundColor = GRAY_LEVEL1;
    [functionIV insertSubview:lineView atIndex:0];

}

- (void)controlBtnAction:(UIButton *)btn{
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:2000 + i];
        btn.selected = NO;
        btn.layer.borderWidth = 0;
    }
    btn.selected = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [BLACK_COLOR CGColor];
    _translateIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"word%ld",btn.tag - 2000]];
}

- (void)addFunctionView{
    CGFloat funcIVH = 49;
    UIImageView *functionIV = [UIMethod create_ImageView_Frame:CGRectMake(0, DEF_SCREEN_HEIGHT - 64  - 10, DEF_SCREEN_WIDTH, funcIVH) image:nil urlImage:nil inView:self.view];
    functionIV.userInteractionEnabled = YES;
//    functionIV.backgroundColor = DEF_RGB_COLOR(78, 68, 233, 1);
    CGFloat funcWH = 49;
//    if (IPAD_DEVICE) {
//        funcWH = DEF_SCREEN_WIDTH * 0.14 ;//> 70 ? 70:(DEF_SCREEN_WIDTH * 0.2);
//
//    }else{
//        funcWH = DEF_SCREEN_WIDTH * 0.2 > 70 ? 70:(DEF_SCREEN_WIDTH * 0.2);
//
//    }
    CGFloat funcMarginX = (DEF_SCREEN_WIDTH - funcWH * 4) / 8.0;
    CGFloat funcMarginY = 0;
    for (NSInteger i = 0; i < FUNCNUM; i ++) {
        NSInteger row = i / 4;//行
        NSInteger col = i % 4;//列
        UIButton *funcBtn = [UIMethod create_Button_Frame:CGRectMake(funcMarginX + (funcWH + funcMarginX * 2) * col,funcMarginY + row * (funcWH + funcMarginY), funcWH, funcWH) title:nil titleColor:WHITE_COLOR font:H2_Font backgroundColor:nil backgroundImage:[NSString stringWithFormat:@"icon%ld",i+1] backgroundColorHighlighted:nil inView:functionIV];
        [funcBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%ld",i+1]] forState:UIControlStateHighlighted];
        funcBtn.tag = 1000 + i;
        funcBtn.adjustsImageWhenHighlighted = NO;
        [funcBtn addTarget:self action:@selector(funcBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        funcBtn.layer.shadowOffset =  CGSizeMake(3, 5);
        funcBtn.layer.shadowOpacity = 0.8;
        funcBtn.layer.shadowColor =  BLACK_COLOR.CGColor;
//        funcBtn.layer.cornerRadius = 10;
//        funcBtn.layer.masksToBounds = YES;
//        funcBtn.layer.borderWidth = 1;
//        funcBtn.layer.borderColor = [WHITE_COLOR CGColor];
    }
}

- (void)funcBtnAction:(UIButton *)btn{
    switch (btn.tag - 1000) {
        case 0:
        {
            [self.navigationController pushViewController:[[TranslationViewController alloc] init] animated:YES];
            break;
        }
        case 1:
        {
            [self.navigationController pushViewController:[[ReadingViewController alloc]init] animated:YES];
            break;
        }
        case 2:
        {
            [self.navigationController pushViewController:[[VocabViewController alloc]init] animated:YES];
            break;
        }
        
        case 3:
        {
            [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
            break;
        }
        
        default:
        {
            [self.navigationController pushViewController:[[TranslationViewController alloc] init] animated:YES];
            break;
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.cycleScrollView.autoScroll = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.cycleScrollView.autoScroll = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
