//
//  SettingViewController.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController

@property (nonatomic, assign) NSInteger jumpState;
@end

typedef enum{
    SwitchTypeDefaultOnline,
    SwitchTypeAutoRecordVocab,
    SwitchTypeSaveSearchHistory
}SwitchType;


typedef void (^ChooseLoginBlock)();
@interface SettingCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UILabel *loginLab;
@property (nonatomic, strong) UISwitch *cus_switch;
@property (nonatomic, assign) SwitchType cus_switchType;
@property (nonatomic, copy) ChooseLoginBlock chooseLoginBlock;
@end