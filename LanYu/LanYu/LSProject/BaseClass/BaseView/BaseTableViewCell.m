//
//  BaseTableViewCell.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/24.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置所有子类选中时，不显示背景色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.leftImg =  [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_leftImg];
        
        self.leftLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
        [_leftLabel setFont:Font15];
        [_leftLabel setTextColor:DEEP_GREEN_COLOR];
        [self.contentView addSubview:_leftLabel];
        
        self.rightImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_rightImg];
        
        self.rightLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
        [_rightLabel setFont:Font15];
        [_rightLabel setTextColor:GRAY_LEVEL1];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLabel];

        // 头像
        self.headerButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        _headerButton.hidden = YES;
        _headerButton.layer.masksToBounds = YES;
        [_headerButton addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_headerButton];
                
        self.rightField = [[UITextField alloc] initWithFrame:CGRectZero];
        _rightField.hidden = YES;
        [_rightField setFont:Font15];
        [_rightField setTextColor:GRAY_LEVEL1];
        _rightField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightField];
    
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.leftImg.image) {
        self.leftImg.frame = CGRectMake(15, DEF_HEIGHT_VIEW(self) / 2 - 12.5, 25, 25);
        self.leftLabel.frame = CGRectMake(DEF_RIGHT_VIEW(_leftImg) + 15, 0, (DEF_WIDTH_VIEW(self) - 40) / 2.8, DEF_HEIGHT_VIEW(self));
    } else {
        self.leftLabel.frame = CGRectMake(15, 0, (DEF_SCREEN_WIDTH - 40) / 2.8, DEF_HEIGHT_VIEW(self));
    }
    if (self.rightImg.image) {
        self.rightImg.frame = CGRectMake(DEF_WIDTH_VIEW(self) - 15 - 12, DEF_HEIGHT_VIEW(self) / 2 - 6, 12, 12);
        self.rightLabel.frame = CGRectMake(DEF_RIGHT_VIEW(_leftLabel), 0, DEF_WIDTH_VIEW(self) - DEF_RIGHT_VIEW(_leftLabel) - 15 - 12 - 10, DEF_HEIGHT_VIEW(self));
    }else {
        self.rightLabel.frame = CGRectMake(DEF_RIGHT_VIEW(_leftLabel), 0, DEF_WIDTH_VIEW(self) - DEF_RIGHT_VIEW(_leftLabel) - 15, DEF_HEIGHT_VIEW(self));
    }
    self.headerButton.frame = CGRectMake(15, 15, DEF_HEIGHT_VIEW(self) - 30, DEF_HEIGHT_VIEW(self) - 30);
    self.rightField.frame = CGRectMake(DEF_X_VIEW(_rightLabel), 0, DEF_WIDTH_VIEW(self.rightLabel) - 25, DEF_HEIGHT_VIEW(self));
}

#pragma mark - 头像按钮点击事件
- (void)headerButtonAction:(UIButton *)sender
{
    [self.delegate clickHeaderButton];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
