//
//  UIMethod.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BgImgColorDirectionHorizontal=0,//水平方向
    BgImgColorDirectionVertical//竖直方向
} BgImgColorDirection;

@class FZButton;
@class DWTextField;
@class DWSearchBar;
@interface UIMethod : NSObject

/**
 *  创建一个UIView
 */
+ (UIView *)create_View_Frame:(CGRect)frame
              backgroundColor:(UIColor *)color
                       inView:(UIView *)inView;

/**
 *  创建一个UILabel
 */
+ (UILabel *)create_Label_Frame:(CGRect)frame
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                           font:(UIFont *)font
                         inView:(UIView *)inView;

/**
 *  创建一个UIButton
 */
+ (UIButton *)create_Button_Frame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                             font:(UIFont *)font
                  backgroundColor:(UIColor *)color
                  backgroundImage:(NSString *)image
       backgroundColorHighlighted:(UIColor *)highlightedColor
                           inView:(UIView *)inView;

/**
 *  创建一个UIImageView
 */
+ (UIImageView *)create_ImageView_Frame:(CGRect)frame
                                   image:(NSString *)image
                                urlImage:(NSString *)urlImage
                                  inView:(UIView *)inView;

/**
 *  创建一个UITextField
 */
+ (DWTextField *)create_TextField_Frame:(CGRect)frame
                            placeHolder:(NSString *)placeHolder
                                   font:(UIFont *)font
                                 inView:(UIView *)inView;

#pragma mark - 创建一个有图片和文字的button
+ (FZButton *)create_FZButton_Frame:(CGRect)frame
                              image:(NSString *)image
                            imgSize:(CGSize)imgSize
                              title:(NSString *)title
                          titleSize:(CGSize)titleSize
                       bottomHeight:(CGFloat)bottomHeight
                           fontSize:(CGFloat)fontSize
                             inView:(UIView *)inView;

/**
 *  创建1秒钟后alertView消失
 */
+ (void)createAlertWithStr:(NSString *)str;


/**
 *  创建单选按钮
 */
+ (id)create_RadioButton_Frame:(CGRect)frame
                                  type:(NSInteger)type
                                inView:(UIView *)inView;

/**
 *  创建复选按钮
 */
+ (id)create_CheckboxButton_Frame:(CGRect)frame
                             type:(NSInteger)type
                            image:(NSString *)image
                    imageSelected:(NSString *)imageSelected
                           inView:(UIView *)inView;

/**
 *  创建提交按钮
 */
+ (UIButton *)create_SubmitButton_Origin:(CGPoint)point
                                   title:(NSString *)title
                                   color:(UIColor *)color
                        highlightedColor:(UIColor *)highlightedColor
                                  inView:(UIView *)inView;

/**
 *  创建搜索框
 */
- (DWSearchBar *)createSearchBar;

/**
 *  创建渐变背景图片
 */
+ (UIImage*)create_BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame direction:(BgImgColorDirection)direction;

@end
