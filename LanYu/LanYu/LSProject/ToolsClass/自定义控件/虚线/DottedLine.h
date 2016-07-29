//
//  DottedLine.h
//  Dashed
//
//  Created by 苑佳帅 on 15/12/8.
//  Copyright © 2015年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    HorizontalDottedLine = 1, //横
    VerticalDottedLine = 2  //竖
}DottedLineType;

@interface DottedLine : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) DottedLineType type;

+ (instancetype)dottenLineWithFrame:(CGRect)frame LineColor:(UIColor *)color Type:(DottedLineType)dottedType InView:(UIView *)view;

@end
