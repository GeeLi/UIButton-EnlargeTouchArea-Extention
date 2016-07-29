//
//  ReadingViewController.m
//  SocialWorkDict
//
//  Created by 李帅 on 16/3/20.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "ReadingViewController.h"
#import "TranslationViewController.h"
#import "VocabViewController.h"
#import "SettingViewController.h"
#define baseMargin 20
@interface ReadingViewController ()
@property (nonatomic, weak) UIImageView *containIV;

@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle: AUTO_CONVERT_LANGUAGEWITHTEXT(@"阅读")];
//    self.view.backgroundColor = WHITE_COLOR;
    [self addBackButton];
    //界面
    [self configUI];
    [self addFunctionView];
}

- (void)configUI{
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, DEF_SCREEN_WIDTH - 40, (DEF_SCREEN_WIDTH - 40)/518*406)];
    iv.image = [UIImage imageNamed:@"story"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iv];
}

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
