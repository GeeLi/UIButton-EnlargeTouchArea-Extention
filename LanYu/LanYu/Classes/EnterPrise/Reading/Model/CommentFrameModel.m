//
//  CommentFrameModel.m
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/4/26.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "CommentFrameModel.h"
#import "CommentModel.h"
#define baseMargin 10
@implementation CommentFrameModel
- (void)setModel:(CommentModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    
    CGFloat headIVWH = 30;
    _headIVF = CGRectMake(baseMargin * 2, baseMargin, headIVWH, headIVWH);
    _nameLabelF = CGRectMake(CGRectGetMaxX(_headIVF) +baseMargin, baseMargin, 200, 20);
    _timeLabelF = CGRectMake(CGRectGetMaxX(_headIVF) +baseMargin, CGRectGetMaxY(_nameLabelF), 200, 15);
    _starLabelF = CGRectMake(DEF_SCREEN_WIDTH - [GlobalMethod widthOfStr:[NSString stringWithFormat:@"%@",model.star] font:H6_Font height:20] - 20, baseMargin, [GlobalMethod widthOfStr:[NSString stringWithFormat:@"%@",model.star] font:H6_Font height:20] + 10, 20);
    _starBtnF = CGRectMake(_starLabelF.origin.x - 20, baseMargin, 20, 20);
    _commentLabelF =CGRectMake(CGRectGetMaxX(_headIVF) + baseMargin, CGRectGetMaxY(_timeLabelF) + baseMargin * 0.5, DEF_SCREEN_WIDTH - CGRectGetMaxX(_headIVF) - 2 * baseMargin, [GlobalMethod heightOfStr:model.commentContent font:H5_Font width:DEF_SCREEN_WIDTH - CGRectGetMaxX(_headIVF) - 2 * baseMargin]);
    _lineViewF = CGRectMake(baseMargin * 2, CGRectGetMaxY(_commentLabelF) + baseMargin, DEF_SCREEN_WIDTH - baseMargin * 4, 1);
    _cellHeight = CGRectGetMaxY(_lineViewF);
}
@end
