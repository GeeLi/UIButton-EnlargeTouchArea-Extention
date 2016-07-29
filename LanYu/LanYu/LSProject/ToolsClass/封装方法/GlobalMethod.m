//
//  GlobalMethod.m
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/17.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "GlobalMethod.h"
#define UserDefaults [NSUserDefaults standardUserDefaults]
#import "ZoomScrollView.h"
@implementation GlobalMethod

#pragma mark - 获取字符串自适应后所占高度
+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width
{
    CGSize rect;
        NSDictionary *dic=@{NSFontAttributeName:font};
        rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic context:nil].size;
    
    return ceilf(rect.height);
}

#pragma mark - 获取字符串自适应后所占宽度
+ (CGFloat)widthOfStr:(NSString *)str
                  font:(UIFont *)font
                 height:(CGFloat)height
{
    CGSize rect;
    NSDictionary *dic=@{NSFontAttributeName:font};
    rect = [str boundingRectWithSize:CGSizeMake(10000, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic context:nil].size;
    
    return rect.width;
}

#pragma mark - 获取uuid
+ (NSString *)getUUID
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    identifierForVendor = [identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return identifierForVendor;
}

#pragma mark - 添加下划线
+ (void)addUnderline:(UIView *)inView
{
    if ([inView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)inView;
        // 下划线
        NSMutableAttributedString *underline = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
        [underline addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, underline.length)];
        button.titleLabel.attributedText = underline;

    } else if ([inView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)inView;
        // 下划线
        NSMutableAttributedString *underline = [[NSMutableAttributedString alloc] initWithString:label.text];
        [underline addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, underline.length)];
        label.attributedText = underline;
    }

}

#pragma mark - 添加无数据图
+ (UIView *)showTipsOfNoData:(NSString *)tipsStr inView:(UIView *)inView
{
    UIView *superView = [UIMethod create_View_Frame:inView.bounds backgroundColor:WHITE_COLOR inView:inView];
    superView.tag = 99;
    
    UIImageView *imgView = [UIMethod create_ImageView_Frame:CGRectMake(inView.frame.size.width / 2 - 40, inView.frame.size.height / 4, 80, 80) image:@"noData"urlImage:nil inView:superView];
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height + 15, inView.frame.size.width, 20)];
    [tipsLabel setText:tipsStr];
    [tipsLabel setTextColor:LIGHT_GREEN_COLOR];
    [tipsLabel setFont:H4_Font];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:tipsLabel];
    return superView;
}

#pragma mark - 移除无数据提示
+ (void)removeTipsViewOfNoData:(UIView *)inView;
{
    UILabel *tipsLabel = (UILabel *)[inView viewWithTag:99];
    [tipsLabel removeFromSuperview];
    tipsLabel = nil;
}

#pragma mark - 数据本地存储
+ (void)setObject:(id)obj forKey:(NSString *)key{
//    if ([obj isKindOfClass:[NSDictionary class]]) {
//        for (NSString *key in obj) {
//            if ([[obj objectForKey:@"key"] isEqualToString:@"<null>"] || [[obj objectForKey:@"key"] isKindOfClass:[NSNull class]]) {
//                []
//            }
//        }
//    }
    [UserDefaults setObject:obj forKey:key];
    [UserDefaults synchronize];
}
+ (void)setBool:(BOOL)b forKey:(NSString *)key{
    [UserDefaults setBool:b forKey:key];
    [UserDefaults synchronize];
    
}

+ (id)objectForKey:(NSString *)key{
    return [UserDefaults objectForKey:key];// != nil?[WFUserDefaults objectForKey:key]:@""
}

+ (BOOL)boolForKey:(NSString *)key{
    return [UserDefaults boolForKey:key];
}

@end
