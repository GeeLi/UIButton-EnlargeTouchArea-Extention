//
//  UIMethod.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "UIMethod.h"

@implementation UIMethod

#pragma mark - 创建一个UIView
+ (UIView *)create_View_Frame:(CGRect)frame
              backgroundColor:(UIColor *)color
                   inView:(UIView *)inView
{
    UIView *newView = [[UIView alloc] initWithFrame:frame];
    newView.backgroundColor = color;
    [inView addSubview:newView];
    return newView;
}

#pragma mark - 创建一个UILabel
+ (UILabel *)create_Label_Frame:(CGRect)frame
                           text:(NSString *)text
                      textColor:(UIColor *)textColor
                           font:(UIFont *)font
                         inView:(UIView *)inView
{
    UILabel *newLabel = [[UILabel alloc] initWithFrame:frame];
    [newLabel setText:text];
    [newLabel setTextColor:textColor];
    [newLabel setFont:font];
    [inView addSubview:newLabel];
    return newLabel;
} 

#pragma mark - 创建一个UIButton
+ (UIButton *)create_Button_Frame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                             font:(UIFont *)font
                  backgroundColor:(UIColor *)color
                  backgroundImage:(NSString *)image
       backgroundColorHighlighted:(UIColor *)highlightedColor
                         inView:(UIView *)inView
{
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setFrame:frame];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setTitleColor:titleColor forState:UIControlStateNormal];
    [newButton.titleLabel setFont:font];
    [newButton setBackgroundColor:color];
    if (image) {
        [newButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedColor) {
        [newButton setBackgroundColor:highlightedColor forState:UIControlStateHighlighted];
        newButton.layer.masksToBounds = YES;
    }
    newButton.adjustsImageWhenHighlighted = NO;
    if(inView){
        [inView addSubview:newButton];
    }
    return newButton;
}   

#pragma mark - 创建一个UIImageView
+ (UIImageView *)create_ImageView_Frame:(CGRect)frame
                                  image:(NSString *)image
                               urlImage:(NSString *)urlImage
                                 inView:(UIView *)inView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (image) {
        [imageView setImage:[UIImage imageNamed:image]];
    }
    if (urlImage) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    [inView addSubview:imageView];
    return imageView;
}  

#pragma mark - 创建一个UITextField
+ (DWTextField *)create_TextField_Frame:(CGRect)frame
                            placeHolder:(NSString *)placeHolder
                                   font:(UIFont *)font
                                 inView:(UIView *)inView
{
    DWTextField *textField = [[DWTextField alloc] initWithFrame:frame];
    [textField setFont:font];
    textField.layer.cornerRadius = 3;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = GRAY_LEVEL1.CGColor;
    if (placeHolder) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: GRAY_LEVEL1}];
    }
//    UIButton *clearButton = [textField valueForKey:@"_clearButton"];
//    [clearButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
//    [clearButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateHighlighted];
//    clearButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    [inView addSubview:textField];
    return textField;
}   

#pragma mark - 创建一个有图片和文字的button- 
+ (FZButton *)create_FZButton_Frame:(CGRect)frame
                              image:(NSString *)image
                            imgSize:(CGSize)imgSize
                              title:(NSString *)title
                          titleSize:(CGSize)titleSize
                       bottomHeight:(CGFloat)bottomHeight
                           fontSize:(CGFloat)fontSize
                             inView:(UIView *)inView
{
    FZButton *fzButton = [FZButton buttonWithType:UIButtonTypeCustom];
    fzButton.frame = frame;
    fzButton.titleFrame = CGRectMake((DEF_WIDTH_VIEW(fzButton) - titleSize.width) / 2, DEF_HEIGHT_VIEW(fzButton) - bottomHeight - titleSize.height, titleSize.width, titleSize.height);
    fzButton.imgFrame = CGRectMake((DEF_WIDTH_VIEW(fzButton) - imgSize.width) / 2, DEF_HEIGHT_VIEW(fzButton) - bottomHeight - titleSize.height - imgSize.height, imgSize.width, imgSize.height);
    if (image) {
        [fzButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    fzButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    fzButton.adjustsImageWhenHighlighted = NO;
    if (title) {
        [fzButton setTitle:title forState:UIControlStateNormal];
    }
    fzButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    fzButton.fontSize = fontSize;
    [fzButton setNeedsLayout];
    [inView addSubview:fzButton];
    return fzButton;
}

#pragma mark - 创建请求结束后的提示AlertView
+ (void)createAlertWithStr:(NSString *)str
{
    CGFloat width = [GlobalMethod widthOfStr:str font:H3_Font height:28];
    UILabel *alertView =  [[UILabel alloc] initWithFrame:CGRectMake(30, 0, width > (DEF_SCREEN_WIDTH - 60) ? (DEF_SCREEN_WIDTH - 80) : (width + 40), width > (DEF_SCREEN_WIDTH - 60) ? 38 : 28)];
    alertView.center = CGPointMake(DEF_SCREEN_WIDTH / 2, DEF_SCREEN_HEIGHT - 80);
    alertView.alpha = 0;
    alertView.backgroundColor = [UIColor blackColor];
    [alertView setText:str];
    [alertView setTextColor:[UIColor whiteColor]];
    [alertView setFont:H3_Font];
    alertView.textAlignment = NSTextAlignmentCenter;
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 4;
    alertView.numberOfLines = 0;
    [[[UIApplication sharedApplication].delegate window] addSubview:alertView];
    [UIView animateWithDuration:0.3 animations:^{
        alertView.alpha = 1;
    }];
    __weak __typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:weakSelf selector:@selector(timerAction:) userInfo:@{@"alertView": alertView} repeats:NO];
    
    
}

#pragma mark - 2秒钟后alertView消失
+ (void)timerAction:(NSTimer *)timer
{
    UILabel *alertView = [[timer userInfo] objectForKey:@"alertView"];
    // 移除alertView
    [alertView removeFromSuperview];
    alertView = nil;
    
}

#pragma mark - 创建单选按钮
+ (id)create_RadioButton_Frame:(CGRect)frame
                                  type:(NSInteger)type
                                 inView:(UIView *)inView
{
    if (type == 0) {
        UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置选中和不选中状态下的颜色
        radioButton.frame = CGRectMake(frame.origin.x - 13, frame.origin.y - 13, frame.size.width + 26, frame.size.height + 26);
        [radioButton setImage:[UIImage imageNamed:@"cycle2"] forState:UIControlStateNormal];
        [radioButton setImage:[UIImage imageNamed:@"cycle2"] forState:UIControlStateNormal | UIControlStateHighlighted];

        [radioButton setImage:[UIImage imageNamed:@"cycle1"] forState:UIControlStateSelected];
        [radioButton setImage:[UIImage imageNamed:@"cycle1"] forState:UIControlStateSelected | UIControlStateHighlighted];

        [radioButton setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
        [radioButton addTarget:self action:@selector(radioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [inView addSubview:radioButton];
        return radioButton;
    } else {
        DWImageView *radioImage = [[DWImageView alloc] initWithFrame:frame];
        [radioImage setBackgroundImage:[UIImage imageNamed:@"cycle2"] forState:UIImageStateNormal];
        [radioImage setBackgroundImage:[UIImage imageNamed:@"cycle1"] forState:UIImageStateSelected];
        radioImage.selected = NO;
        [inView addSubview:radioImage];
        return radioImage;
    }
}

+ (void)radioButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark - 创建复选按钮
+ (id)create_CheckboxButton_Frame:(CGRect)frame
                                      type:(NSInteger)type
                                     image:(NSString *)image
                             imageSelected:(NSString *)imageSelected
                                    inView:(UIView *)inView
{
    if (type == 0) {
        UIButton *checkboxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置选中和不选中状态下的颜色
        checkboxButton.frame = CGRectMake(frame.origin.x - 13, frame.origin.y - 13, frame.size.width + 26, frame.size.height + 26);
        [checkboxButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal | UIControlStateHighlighted];
        
        [checkboxButton setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected | UIControlStateHighlighted];

        checkboxButton.adjustsImageWhenHighlighted = NO;
        [checkboxButton setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
        [checkboxButton addTarget:self action:@selector(checkboxAction:) forControlEvents:UIControlEventTouchUpInside];
        [inView addSubview:checkboxButton];
        return checkboxButton;
    } else {
        DWImageView *radioImage = [[DWImageView alloc] initWithFrame:frame];
        [radioImage setBackgroundImage:[UIImage imageNamed:image] forState:UIImageStateNormal];
        [radioImage setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIImageStateSelected];
        radioImage.selected = NO;
        [inView addSubview:radioImage];
        return radioImage;
    }

}

+ (void)checkboxAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark - 创建提交按钮
+ (UIButton *)create_SubmitButton_Origin:(CGPoint)point
                                   title:(NSString *)title
                                   color:(UIColor *)color
                        highlightedColor:(UIColor *)highlightedColor
                                  inView:(UIView *)inView
{
    UIButton *submitButton = [UIMethod create_Button_Frame:CGRectMake(point.x, point.y, DEF_WIDTH_VIEW(inView) - point.x * 2, 40) title:title titleColor:[UIColor whiteColor] font:H3_Font backgroundColor:color backgroundImage:nil backgroundColorHighlighted:highlightedColor inView:inView];
    submitButton.layer.cornerRadius = 4;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitBt:) forControlEvents:UIControlEventTouchUpInside];
    return submitButton;
}

+ (void)submitBt:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - 创建searchBar
- (DWSearchBar *)createSearchBar
{    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH - 95, 44)];
    
    DWSearchBar *searchBar = [[DWSearchBar alloc] initWithFrame:CGRectMake(0, 3, DEF_WIDTH_VIEW(titleView), 38)];
    searchBar.placeholder = @"输入搜索内容";
    [titleView addSubview:searchBar];
        
    return  searchBar;
}


+ (UIImage*)create_BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame direction:(BgImgColorDirection)direction

{
    
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        
        [ar addObject:(id)c.CGColor];
        
    }
    
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    if (direction == BgImgColorDirectionHorizontal) {
        
        start = CGPointMake(0.0, frame.size.height);
        
        end = CGPointMake(frame.size.width, 0.0);
        
    }else if (direction == BgImgColorDirectionVertical) {
        
        start = CGPointMake(0.0, 0.0);
        
        end = CGPointMake(0.0, frame.size.height);
    }
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
