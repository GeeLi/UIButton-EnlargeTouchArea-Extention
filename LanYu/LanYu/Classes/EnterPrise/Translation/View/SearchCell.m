//
//  SearchCell.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/23.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "SearchCell.h"
#import "SearchModel.h"
@interface SearchCell ()
@property (nonatomic, weak) UILabel *wordLabel;
@property (nonatomic, weak) UILabel *explanationLabel;
@property (nonatomic, weak) UILabel *clearLabel;
@property (nonatomic, weak) UILabel *noResultLabel;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, strong) MASConstraint *wordWidthCons;
@end

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    UILabel *wordLabel = [UILabel new];
    wordLabel.textColor = BLACK_COLOR;
    wordLabel.font = H3_Font;
    _wordLabel = wordLabel;
    [self.contentView addSubview:wordLabel];
    [wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(1);
        make.width.mas_lessThanOrEqualTo(DEF_SCREEN_WIDTH * 0.5);
    }];
    UILabel *explanationLabel = [UILabel new];
    explanationLabel.textColor = GRAY_LEVEL1;
    explanationLabel.font = H4_Font;
    _explanationLabel = explanationLabel;
    [self.contentView addSubview:explanationLabel];
    [explanationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(wordLabel.mas_right).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(1);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
    explanationLabel.textAlignment = NSTextAlignmentLeft;
    UILabel *clearLabel = [UILabel new];
    clearLabel.text = AUTO_CONVERT_LANGUAGEWITHTEXT(@"清除历史记录");
    clearLabel.textColor = GRAY_LEVEL1;
    clearLabel.font = H3_Font;
    clearLabel.textAlignment = NSTextAlignmentCenter;
//    clearLabel.hidden = YES;
    _clearLabel = clearLabel;
    [self.contentView addSubview:clearLabel];
    [clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right).offset(10);
    }];
    UILabel *noResultLabel = [UILabel new];
    noResultLabel.text = AUTO_CONVERT_LANGUAGEWITHTEXT(@"暂无搜索词汇");
    noResultLabel.textColor = GRAY_LEVEL1;
    noResultLabel.font = H3_Font;
    noResultLabel.textAlignment = NSTextAlignmentCenter;
    //    clearLabel.hidden = YES;
    _noResultLabel = noResultLabel;
    [self.contentView addSubview:noResultLabel];
    [noResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right).offset(10);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GRAY_LEVEL2;
    _lineView = lineView;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(SearchModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    _wordLabel.text = model.words;
    _explanationLabel.text = model.explanation;
    _clearLabel.hidden = !model.showClear;
    _noResultLabel.hidden = !model.showNoResult;
    _lineView.hidden = (model.words.length || model.explanation.length) ? NO : YES;
}
@end
