//
//  CommentModel.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/4/26.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSValue *star;
@property (nonatomic, assign) BOOL isLiked;//赞
@end
