//
//  ListTableViewCell.m
//  下拉菜单
//
//  Created by 李帅 on 15/6/23.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.contentLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
        [_contentLabel setTextColor:GRAY_LEVEL1];
        [_contentLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
