//
//  LSButton.h
//  MyDemo
//
//  Created by  tsou117 on 15/5/8.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXTFONT [UIFont systemFontOfSize:13.0f]

typedef enum : NSUInteger {
    LSMarkAlignmentNone = 0,
    LSMarkAlignmentLeft,
    LSMarkAlignmentRight,
} LSMarkAlignment;

@interface LSButton : UIView

@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIImageView* markImgView;

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) UIImage* markImg;
@property (nonatomic,strong) UIImage* backgroundImage;
@property (nonatomic,assign) LSMarkAlignment markAlignment; // 默认 LSMarkAlignmentRight

- (void)settitleColor:(UIColor*)color;

@end
