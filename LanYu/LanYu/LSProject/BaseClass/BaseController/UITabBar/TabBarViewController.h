//
//  TabBarViewController.h
//  WelfareClub
//
//  Created by 李帅 on 15/8/21.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchModel;
@interface TabBarViewController : UITabBarController

@property (nonatomic, strong) UIImageView *tabBarView;

/// 文字
@property (nonatomic, strong) NSArray *titles;

/// 图片 
@property (nonatomic, strong) NSArray *images;

/// 被选中的图片
@property (nonatomic, strong) NSArray *selectedImages;

/// 视图控制器
@property (nonatomic, strong) NSArray *controllerArray;

//@property (nonatomic, assign) BOOL isGoToTranslation;
@property (nonatomic, strong) SearchModel *model;

- (void)loadViewController;

- (void)loadTabBarView;

- (void)tabBarAction:(UIButton *)sender;

/**显示badge**/
- (void)showBadgeWithIndex:(NSInteger)index;

/**消除badge**/
- (void)hideBadgeWithIndex:(NSInteger)index;

@end
