//
//  TransferViewController.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "TranslationViewController.h"
#import "SearchViewController.h"
#import "SearchModel.h"
#import <AVFoundation/AVFoundation.h>
#import "SettingViewController.h"
#import "TabBarViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "VocabViewController.h"
#import "ReadingViewController.h"
#define baseMargin 10
#define searchIVX 25
#define searchIVH IPAD_DEVICE?80:40
@interface TranslationViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) NSString *currentContent;
@property (nonatomic, strong) NSString *currentId;
@property (nonatomic, weak) UIScrollView *containSV;
@property (nonatomic, weak) UILabel *placeHoldLabel;
@property (nonatomic, weak) UILabel *wordsLabel;
@property (nonatomic, weak) UIButton *pronounceBtn;
@property (nonatomic, weak) UIButton *exPronounceBtn;
@property (nonatomic, weak) UIButton *favorBtn;
@property (nonatomic, weak) UILabel *explanationLabel;
@property (nonatomic, weak) UILabel *exampleLabel;
@property (nonatomic, weak) UILabel *exampleExplanationLabel;
@property (nonatomic, weak) UIButton *readBtn;
@property (nonatomic, weak) UIButton *rightItem;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *animateBtn;
@property (nonatomic, weak) UIImageView *translateIV;
@end
@implementation TranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle:@"翻译"];
    [self addBackButton];
    [self configUI];
    self.navigationController.navigationBar.tintColor = BLACK_COLOR;
    [self addTranslateView];
    [self addFunctionView];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addEdging{
    UIImage *edgImg = [UIMethod create_BgImageFromColors:@[DEF_RGB_COLOR(122, 136, 191, 1),DEF_RGB_COLOR(104, 90, 167, 1)] withFrame:CGRectMake(0, 0, 10, DEF_SCREEN_HEIGHT - 64 - 49) direction:BgImgColorDirectionVertical];
    UIImageView *leftIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, DEF_SCREEN_HEIGHT - 64 - 49)];
    leftIV.image = edgImg;
    [self.view addSubview:leftIV];
    UIImageView *rightIV = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 10, 0, 10, DEF_SCREEN_HEIGHT - 64 - 49)];
    rightIV.image = edgImg;
    [self.view addSubview:rightIV];
}

- (void)backButtonAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)configUI{
    //
    UIScrollView *containSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - 64 - 49 - 10)];
//    containSV.backgroundColor = DEF_RGB_COLOR(115, 60, 250, 1);
    containSV.userInteractionEnabled = YES;
    containSV.alwaysBounceVertical = YES;
    _containSV = containSV;
    [self.view addSubview:containSV];
    //搜索框
    
    CGFloat searchIVW = DEF_SCREEN_WIDTH - searchIVX * 2;
    UIButton *searchBackGround = [[UIButton alloc]initWithFrame:CGRectMake(searchIVX * 2, 10, searchIVW - searchIVX * 4, 30)];
    searchBackGround.backgroundColor = WHITE_COLOR;//GRAY_LEVEL2;
//    searchBackGround.alpha = 0.7;
//    searchBackGround.layer.borderWidth = 1;
//    searchBackGround.layer.borderColor = [GRAY_LEVEL3 CGColor];
//    searchBackGround.layer.cornerRadius = 3;
//    searchBackGround.layer.masksToBounds = YES;
    searchBackGround.tag = 1006;
    [self.view addSubview:searchBackGround];
    UILabel *placeHoldLabel = [[UILabel alloc]initWithFrame:CGRectMake(baseMargin, 0, searchIVW - searchIVX * 4, 30)];
    placeHoldLabel.text = AUTO_CONVERT_LANGUAGEWITHTEXT(@"请输入单词");
//    placeHoldLabel.textAlignment = NSTextAlignmentCenter;
    placeHoldLabel.textColor = BLACK_COLOR;
    placeHoldLabel.font = DEF_SCREEN_WIDTH <= 320 ? H6_Font : H5_Font;
    _placeHoldLabel = placeHoldLabel;
    [searchBackGround addSubview:placeHoldLabel];
    UIButton *searchImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [searchImgBtn setImage:[UIImage imageNamed:@"search1"] forState:UIControlStateNormal];
    searchImgBtn.userInteractionEnabled = NO;
    [searchBackGround addSubview:searchImgBtn];
    searchImgBtn.center = CGPointMake(searchBackGround.bounds.size.width + 20, searchBackGround.bounds.size.height * 0.5);
//    UIImageView *wordsIV = [UIMethod create_ImageView_Frame:CGRectMake(searchIVX, searchIVY + baseMargin, DEF_SCREEN_WIDTH * 0.5 - searchIVX - 5, searchIVH) image:nil urlImage:nil inView:self.containSV];
//    wordsIV.backgroundColor = WHITE_COLOR;//GRAY_LEVEL2;
////    wordsIV.layer.cornerRadius = 5;
////    wordsIV.layer.masksToBounds = YES;
//    wordsIV.userInteractionEnabled = YES;
    //个人
    //    CGFloat loginBtnW = [GlobalMethod widthOfStr:@"登录" font:H2_Font height:60] + 20;
}

- (void)addTranslateView{
    UIImageView *translateIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, DEF_SCREEN_HEIGHT * 0.2, DEF_SCREEN_WIDTH - 10 - 30, (DEF_SCREEN_WIDTH - 10 - 30) / 880 * 200)];
    _translateIV = translateIV;
    translateIV.image = [UIImage imageNamed:@"word0"];
    [self.view addSubview:translateIV];
    //控制条
    
    CGFloat funcIVH = 80;
    UIImageView *functionIV = [UIMethod create_ImageView_Frame:CGRectMake(0, CGRectGetMaxY(translateIV.frame) + 80, DEF_SCREEN_WIDTH, funcIVH) image:nil urlImage:nil inView:self.view];
    functionIV.userInteractionEnabled = YES;
    //    functionIV.backgroundColor = DEF_RGB_COLOR(78, 68, 233, 1);
    CGFloat funcWH = 80;
    CGFloat funcMarginX = (DEF_SCREEN_WIDTH - funcWH * 4) / 8.0;
    CGFloat funcMarginY = 0;
    for (NSInteger i = 0; i < 4; i ++) {
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
    UIImageView *functionIV = [UIMethod create_ImageView_Frame:CGRectMake(0, DEF_SCREEN_HEIGHT - 64 - 49 - 10, DEF_SCREEN_WIDTH, funcIVH) image:nil urlImage:nil inView:self.view];
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
    for (NSInteger i = 0; i < 4; i ++) {
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
            [self.navigationController pushViewController:[[TranslationViewController alloc] init] animated:NO];
            break;
        }
        case 1:
        {
            [self.navigationController pushViewController:[[ReadingViewController alloc]init] animated:NO];
            break;
        }
        case 2:
        {
            [self.navigationController pushViewController:[[VocabViewController alloc]init] animated:NO];
            break;
        }
            
        case 3:
        {
            [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:NO];
            break;
        }
            
        default:
        {
            [self.navigationController pushViewController:[[TranslationViewController alloc] init] animated:NO];
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationBar.hidden = YES;
//    self.navigationController.navigationBarHidden = NO;
//}

@end
