//
//  DWImageView.h
//  YeHeApp
//
//  Created by 李帅 on 15/11/3.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, UIImageState)
{
    UIImageStateNormal,
    UIImageStateSelected
};
@interface DWImageView : UIImageView

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, strong) UIImage *selectedImage;


- (void)setBackgroundImage:(UIImage *)image forState:(UIImageState)state;

@end
