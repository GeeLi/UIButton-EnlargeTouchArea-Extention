//
//  CommentCell.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/4/26.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "CommentCell.h"
#import "CommentFrameModel.h"
#import "CommentModel.h"
#define baseMargin 10
@interface CommentCell ()
@property (nonatomic, weak) UIImageView *headIV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *starLabel;
@property (nonatomic, weak) UIButton *starBtn;
@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UIView *lineView;
@end
@implementation CommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    CGFloat headIVWH = 25;
    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(baseMargin * 2, baseMargin, headIVWH, headIVWH)];
    headIV.image = [UIImage imageNamed:@"wodetouxiang"];
    _headIV = headIV;
    [self addSubview:headIV];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIV.frame) +baseMargin, baseMargin, 200, 20)];
    nameLabel.textColor = BLACK_COLOR;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = H6_Font;
    _nameLabel = nameLabel;
    [self addSubview:nameLabel];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIV.frame) +baseMargin, CGRectGetMaxY(nameLabel.frame), 200, 15)];
    timeLabel.textColor = GRAY_LEVEL1;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = H7_Font;
    _timeLabel = timeLabel;
    [self addSubview:timeLabel];
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 50, baseMargin, 40, 20)];
    starLabel.textColor = GRAY_LEVEL1;
    starLabel.textAlignment = NSTextAlignmentCenter;
    starLabel.font = H6_Font;
    _starLabel = starLabel;
    [self addSubview:starLabel];
    UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starBtn.frame = CGRectMake(CGRectGetMinX(starLabel.frame) - 20, baseMargin, 20, 20);
    [starBtn setImage:[UIImage imageNamed:@"star.jpg"] forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(starAction:) forControlEvents:UIControlEventTouchUpInside];
    _starBtn = starBtn;
    [self addSubview:starBtn];
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIV.frame) + baseMargin, CGRectGetMaxY(timeLabel.frame) + 10, DEF_SCREEN_WIDTH - CGRectGetMaxX(headIV.frame) - 2 * baseMargin, 20)];
    commentLabel.textColor = BLACK_COLOR;
    commentLabel.textAlignment = NSTextAlignmentLeft;
    commentLabel.font = H5_Font;
    commentLabel.numberOfLines = 0;
    _commentLabel = commentLabel;
    [self addSubview:commentLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(baseMargin * 2, CGRectGetMaxY(commentLabel.frame), DEF_SCREEN_WIDTH - baseMargin * 4, 1)];
    lineView.backgroundColor = GRAY_LEVEL2;
    _lineView = lineView;
    [self addSubview:lineView];
}

- (void)starAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)setModel:(CommentFrameModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    if (model.model.headImgUrl) {
        
    }
    _nameLabel.text = model.model.userName;
    _nameLabel.frame = model.nameLabelF;
    _timeLabel.text = model.model.time;
    _timeLabel.frame= model.timeLabelF;
    _starLabel.text = [NSString stringWithFormat:@"%@",model.model.star];
    _starLabel.frame = model.starLabelF;
    _starBtn.frame = model.starBtnF;
    _commentLabel.text = model.model.commentContent;
    _commentLabel.frame = model.commentLabelF;
    _lineView.frame = model.lineViewF;
}
@end
