//
//  CommentFrameModel.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/4/26.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentModel;
@interface CommentFrameModel : NSObject
/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect headIVF;
/**
 *  姓名的frame
 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/**
 *  时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/**
 *  赞数字的frame
 */
@property (nonatomic, assign, readonly) CGRect starLabelF;
/**
 *  赞图片的frame
 */
@property (nonatomic, assign, readonly) CGRect starBtnF;
/**
 *  评论的frame
 */
@property (nonatomic, assign, readonly) CGRect commentLabelF;
/**
 *  分割线的frame
 */
@property (nonatomic, assign, readonly) CGRect lineViewF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, strong) CommentModel *model;
@end
