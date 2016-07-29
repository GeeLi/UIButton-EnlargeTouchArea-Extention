//
//  VocabCell.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/5/4.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void (^ShowMeansBlock) (BOOL show);
@class SearchModel;
@interface VocabCell : UITableViewCell
@property (nonatomic, strong) SearchModel *model;
@property (nonatomic, weak) UITapGestureRecognizer *tap;
@property (nonatomic, weak) UIView *lineView;
//@property (nonatomic, copy) ShowMeansBlock showMeansBlock;
@end
