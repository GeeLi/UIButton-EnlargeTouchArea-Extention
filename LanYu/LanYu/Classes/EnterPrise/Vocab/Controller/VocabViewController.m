//
//

//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "VocabViewController.h"
#import "SearchModel.h"
#import "VocabCell.h"
#import "TabBarViewController.h"
#import "TranslationViewController.h"
#import "SettingViewController.h"
#import "ReadingViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#define kSORTTYPE @"SORTTYPE"
#define kREVEALEXPLAIN @"REVEALEXPLAIN"
#define kSHOWMEANSTYPE @"SHOWMEANSTYPE"
typedef enum{
    ShowMeansTypeRegularTime,
    ShowMeansTypeReverseTime,
    ShowMeansTypeAlphabet
}ShowMeansType;
@interface VocabViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_sectionArr;
    NSMutableArray     *_sectionHeadArr;
//    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
}
@property (nonatomic, strong) NSMutableArray *vocabArr;
@property (nonatomic, strong) NSMutableArray *showArr;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UILabel *notiLabel;

@end

@implementation VocabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle: AUTO_CONVERT_LANGUAGEWITHTEXT(@"单词本")];
    [self addBackButton];
//    [self initShows];
    [self initData];
    [self configUI];
    [self addFunctionView]; 
}

- (void)initData{

}

- (void)configUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = GRAY_BACKGROUND;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    _tableView = tableView;
//    [self.view addSubview:tableView];
    CGFloat IVH = DEF_SCREEN_WIDTH * 0.85 * 585 / 553;
    UIImageView *vocabIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, DEF_SCREEN_WIDTH *0.85, IVH)];
    vocabIV.image = [UIImage imageNamed:@"vocab"];
    [self.view addSubview:vocabIV];
    CGFloat btnH = IVH / 6;
    for (NSInteger i = 0; i < 6; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0 , 35, 35);
        [btn setImage:[UIImage imageNamed:@"favor"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"unfavor"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setEnlargeEdgeWithTop:5 right:10 bottom:5 left:10];
        btn.adjustsImageWhenHighlighted = NO;
        [self.view addSubview:btn];
        btn.center = CGPointMake(CGRectGetMaxX(vocabIV.frame) + 20, 50 + (0.5 + i) * btnH * 0.96);
    }
}

- (void)btnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

        return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.vocabArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_SCREEN_HEIGHT / 12.0;
}

#pragma mark

- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.tableView reloadData];
    //保存至服务器

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
