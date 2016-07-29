//
//  PayFixedAmountPopView.h
//  Num012&017
//
//  Created by 苑佳帅 on 15/9/8.
//  Copyright (c) 2015年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputPasswordView.h"
@protocol PayFixedAmountDelegate <NSObject>

@required
- (void)inputPasswordFinishWith:(NSString *)password;

@end

@interface PayFixedAmountPopView : UIView

@property (nonatomic, weak) id<PayFixedAmountDelegate> delegate;
@property (nonatomic, strong) InputPasswordView *inputPasswordView;
@property (nonatomic, strong) UIImageView *back_image;
@property (nonatomic, strong) UIButton *cancel_BTN;
@property (nonatomic, strong) UILabel *title_L;
@property (nonatomic, strong) UILabel *amount_textL;
@property (nonatomic, strong) UILabel *amount;
@property (nonatomic, weak) UIViewController *presentVC;

- (instancetype)initWithFrame:(CGRect)frame AmountWith:(NSString *)amount Delegate:(id)delegate;

@end
