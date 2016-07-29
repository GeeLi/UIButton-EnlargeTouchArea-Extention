//
//  VocabCell.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/5/4.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "VocabCell.h"
#import "SearchModel.h"
@interface VocabCell()
@property (nonatomic, weak) UILabel *wordLabel;
@property (nonatomic, weak) UILabel *explanationLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@end


@implementation VocabCell

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
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configSubViews{
    UILabel *wordLabel = [UILabel new];
    wordLabel.textColor = BLACK_COLOR;
    wordLabel.font = H3_Font;
    wordLabel.textAlignment = NSTextAlignmentLeft;
    wordLabel.numberOfLines = 0;
    _wordLabel = wordLabel;
    [self.contentView addSubview:wordLabel];
    [wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(1);
        
    }];
    UILabel *explanationLabel = [UILabel new];
    explanationLabel.textColor = GRAY_LEVEL1;
    explanationLabel.font = H4_Font;
    explanationLabel.numberOfLines = 0;
    _explanationLabel = explanationLabel;
    [self.contentView addSubview:explanationLabel];
    [explanationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
//        make.left.equalTo(wordLabel.mas_right).offset(10);
        make.left.mas_offset(DEF_SCREEN_WIDTH * 0.5 + 10);//* 0.35 + 30
        make.bottom.equalTo(self.mas_bottom).offset(1);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
//    UILabel *timeLabel = [UILabel new];
//    timeLabel.textColor = BLACK_COLOR;
//    timeLabel.font = H6_Font;
//    _timeLabel = timeLabel;
//    [self.contentView addSubview:timeLabel];
//    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.bottom.equalTo(self.mas_bottom).offset(1);
//    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GRAY_LEVEL2;
    _lineView = lineView;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_bottom).offset(-1);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToShowMeans)];
//    _tap = tap;
//    [self addGestureRecognizer:tap];
}

//- (void)tapToShowMeans{
//    self.explanationLabel.hidden = !self.explanationLabel.isHidden;
//    if (self.showMeansBlock) {
//        self.showMeansBlock(self.explanationLabel.hidden);
//    }
//}

- (void)setModel:(SearchModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    _wordLabel.text = model.words;
    _explanationLabel.text = model.explanation;
    _timeLabel.text = model.favorTime;
    if ([GlobalMethod widthOfStr:model.words font:H3_Font height:self.bounds.size.height -1] > DEF_SCREEN_WIDTH * 0.45 - 20) {
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(20);
            make.bottom.equalTo(self.mas_bottom).offset(1);
            make.width.mas_equalTo(DEF_SCREEN_WIDTH * 0.45);
            
        }];
    }else {
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(20);
            make.bottom.equalTo(self.mas_bottom).offset(1);
            make.width.mas_equalTo([GlobalMethod widthOfStr:model.words font:H3_Font height:self.bounds.size.height -1] + 10);
        }];
    }
    if ([[GlobalMethod objectForKey:@"REVEALEXPLAIN"] integerValue] == 1) {
        _explanationLabel.hidden = YES;
        _tap.enabled = NO;
    }else if ([[GlobalMethod objectForKey:@"REVEALEXPLAIN"] integerValue] == 2) {
//        _explanationLabel.hidden = YES;
        _tap.enabled = YES;
        self.explanationLabel.hidden = !self.model.showMeans;
    }else{
        _explanationLabel.hidden = NO;
        _tap.enabled = NO;
    }
}

@end
