//
//  BaseViewController.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"
#import "BaseScrollView.h"

@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
/// 内容视图, 所有视图都加载到contentView上
@property (nonatomic, strong) BaseScrollView *contentView;

/// 自定义状态栏
@property (nonatomic, strong) UIView *statusBar;

/// 自定义NavigationBar
@property (nonatomic, strong) UIView *navigationBar;

- (void)loadContentView;
/**
 *  创建自定义的navigationBar (用于多个页面拥有不同的navigationBar)
 */
- (void)loadNavigationBar;
/**
 *  用图片设置搜navigationBar的背景
 */
- (void)setNavigationBarBackgroundStyleWithImg:(UIImage *)image;
/**
 *  将所有的其它控件添加到contentView上
 */
- (void)addSubview:(UIView *)view;

/**
 *  添加标题
 */
- (void)addTitle:(NSString *)title;

/**
 *  添加返回按钮
 */
- (void)addBackButton;

/**
 *  添加返回按钮(有返回箭头和文字)
 */
- (void)addBackButtonWithText:(NSString *)text;

/**
 *  添加左按钮
 */
- (UIButton *)addLeftButtonWithImage:(NSString *)image imageSize:(CGSize)size;

/**
 *  添加两个左按钮
 */
- (NSArray *)addTwoLeftButtonWithImage1:(NSString *)image1 imageSize1:(CGSize)size1 
                                 image2:(NSString *)image2 imageSize2:(CGSize)size2;

/**
 *  添加右按钮
 */
- (UIButton *)addRightButtonWithImage:(NSString *)image imageSize:(CGSize)size;

/**
 *  添加两个右按钮
 */
- (NSArray *)addTwoRightButtonWithImage1:(NSString *)image1 imageSize1:(CGSize)size1 
                                  image2:(NSString *)image2 imageSize2:(CGSize)size2;

/**
 *  添加一个只有文字的左按钮
 */
- (UIButton *)addLeftButtonWithTitle:(NSString *)title;

/**
 *  添加一个只有文字的右按钮
 */
- (UIButton *)addRightButtonWithTitle:(NSString *)title;

/**
 *  返回按钮点击事件
 */
- (void)backButtonAction:(UIButton *)sender;

/**
 *  左按钮点击事件
 */
- (void)leftButtonAction:(UIButton *)sender;

/**
 *  右按钮点击事件
 */
- (void)rightButtonAction:(UIButton *)sender;

- (void)registTableView:(UITableView *)tableView class:(Class)class cellName:(NSString *)cellName;

/**
 *  判断对象是否为空或NSNull, 或字符串是否为空
 */
- (BOOL)isEffectiveObject:(id)object;

/**
 *  添加一个上面是图片下面是文字的leftButton
 */
- (FZButton *)addLeftFZButtonWithTitle:(NSString *)title
                                 image:(NSString *)image highlighted:(NSString *)highLighted;

/**
 *  添加一个上面是图片下面是文字的rightButton
 */
- (FZButton *)addRightFZButtonWithTitle:(NSString *)title
                                  image:(NSString *)image highlighted:(NSString *)highLighted;
/**
 *  消息提示框
 */
- (void)showMessage:(NSString *)message;

/**
 *  点击回收键盘
 */
- (void)returnKeyboardWithView:(UIView *)inView;

///**
// *  刷新加载
// */
//- (void)addRefreshHeader:(UIScrollView *)scrollView refreshingBlock:(void(^)())refreshingBlock;
//
//- (void)addRefreshFooter:(UIScrollView *)scrollView refreshingBlock:(void(^)())refreshingBlock;



@end
