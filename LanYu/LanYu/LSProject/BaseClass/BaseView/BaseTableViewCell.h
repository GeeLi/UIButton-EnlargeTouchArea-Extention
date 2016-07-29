//
//  BaseTableViewCell.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/24.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewCellDelegate <NSObject>

- (void)clickHeaderButton;

@end

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImg;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UILabel *rightLabel;

// 头像
@property (nonatomic, strong) UIButton *headerButton;

@property (nonatomic, strong) UITextField *rightField;


@property (nonatomic, weak) id<BaseTableViewCellDelegate> delegate;




@end
