//
//  SettingViewController.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "SettingViewController.h"
#import "SDImageCache.h"
#import "TranslationViewController.h"
#import "ReadingViewController.h"
#import "VocabViewController.h"
#define ITEM_HEIGHT (IPAD_DEVICE?80:(DEF_SCREEN_WIDTH / 8.5))
@interface SettingCell ()
@end

@implementation SettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, ITEM_HEIGHT)];
    bgView.backgroundColor = GRAY_BACKGROUND;
    [self.contentView addSubview:bgView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, DEF_SCREEN_WIDTH - 40, 1)];
    lineView.backgroundColor = GRAY_LEVEL2;
    [bgView addSubview:lineView];
    //图片
    _imageV = [UIMethod create_ImageView_Frame:CGRectMake(15, 10, 20, ITEM_HEIGHT - 20) image:nil urlImage:nil inView:bgView];
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    //文字
    _textLab = [UIMethod create_Label_Frame:CGRectMake(20, 10, DEF_SCREEN_WIDTH - 60, ITEM_HEIGHT - 20) text:@"" textColor:BLACK_COLOR font:Font15 inView:bgView];
    //未登录按钮
    _loginLab = [UIMethod create_Label_Frame:CGRectMake(DEF_SCREEN_WIDTH - 100, 10, 80, ITEM_HEIGHT - 20) text:AUTO_CONVERT_LANGUAGEWITHTEXT(@"未登录") textColor:GRAY_LEVEL1 font:H4_Font inView:bgView];
    _loginLab.textAlignment = NSTextAlignmentRight;
    //按钮
    _cus_switch = [[UISwitch alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 80, 5, 40, ITEM_HEIGHT - 10)];
    _cus_switch.onTintColor = DEF_RGB_COLOR(241, 241, 241, 1);
    _cus_switch.on = YES;
    [_cus_switch addTarget:self action:@selector(changeWitchState:) forControlEvents:UIControlEventValueChanged];
    [bgView addSubview:_cus_switch];
    _cus_switch.center = CGPointMake(DEF_SCREEN_WIDTH - 50, bgView.center.y);
}

- (void)changeWitchState:(UISwitch *)cus_switch{
    NSLog(@"switchType:%u,switchState:%@",_cus_switchType,cus_switch.isOn?@"Open":@"Close");
    if (_cus_switchType == SwitchTypeDefaultOnline) {
        [GlobalMethod setBool:!cus_switch.isOn forKey:DEF_DEFAULT_ONLINE];
    }else if (_cus_switchType == SwitchTypeAutoRecordVocab) {
        [GlobalMethod setBool:cus_switch.isOn forKey:DEF_AUTO_RECORD_VOCAB];
    }else if (_cus_switchType == SwitchTypeSaveSearchHistory) {
        [GlobalMethod setBool:!cus_switch.isOn forKey:DEF_SAVE_SEARCH_HISTORY];
    }
}

@end

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic, weak) UITableView *settingTableView;
@property (nonatomic, strong) NSArray *settingArr;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle:@"设置"];
//    self.view.backgroundColor = GRAY_BACKGROUND;
    [self addBackButton];
    [self loadData];
    [self configUI];
    [self addFunctionView];
}

- (void)backButtonAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadData{
    _settingArr = @[@[@[AUTO_CONVERT_LANGUAGEWITHTEXT(@"查询后自动加入生词本"),@"shengciben"],
                    @[AUTO_CONVERT_LANGUAGEWITHTEXT(@"默认联网"),@"lianwang"],@[AUTO_CONVERT_LANGUAGEWITHTEXT(@"保存搜索记录"),@"jilu"]]
//                    @[@[@"清除缓存",@"qingchuhuancun"]]
                    ];
}

- (void)configUI{
    UITableView *settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.backgroundColor = GRAY_BACKGROUND;
    settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingTableView = settingTableView;
    [self.view addSubview:settingTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _settingArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_settingArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ITEM_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (!cell) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
    }
    cell.textLab.text = _settingArr[indexPath.section][indexPath.row][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.loginLab.hidden = YES;
        cell.cus_switch.hidden = NO;
        if (indexPath.row == 0) {
            cell.cus_switch.on = [GlobalMethod boolForKey:DEF_DEFAULT_ONLINE] ? NO : YES;
            cell.cus_switchType = SwitchTypeDefaultOnline;
        }else if (indexPath.row == 1) {
            cell.cus_switch.on = [GlobalMethod boolForKey:DEF_AUTO_RECORD_VOCAB] ? YES : NO;
            cell.cus_switchType = SwitchTypeAutoRecordVocab;
        }else if (indexPath.row == 2) {
            cell.cus_switch.on = [GlobalMethod boolForKey:DEF_SAVE_SEARCH_HISTORY] ? NO : YES;
            cell.cus_switchType = SwitchTypeSaveSearchHistory;
        }
    }else{
        cell.cus_switch.hidden = YES;
        cell.loginLab.hidden = YES;
    }
    return cell;
}


#pragma mark 解决跳转时延问题，唤醒主线程
- (void)push{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 5000) {//去登录
        }else if (alertView.tag == 5001) {//清除缓存
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"清除中...";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                [MBProgressHUD showSuccess:@"清除成功！" toView:self.view];
            });
        }
    }
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
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [_downloader start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

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
