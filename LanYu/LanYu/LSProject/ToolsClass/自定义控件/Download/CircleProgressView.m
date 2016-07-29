//
//  CircleProgressView.m
//  CircleProgressDemo
//
//  Created by 周际航 on 15/12/28.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "CircleProgressView.h"
//#import "UIColor+Extension.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * (degrees))/ 180)

@interface CircleProgressView ()
@property (nonatomic, weak) UILabel *percent;
@end

@implementation CircleProgressView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        UILabel *percent = [[UILabel alloc] init];
        percent.textAlignment = NSTextAlignmentCenter;
        percent.font = [UIFont systemFontOfSize:9];
        percent.textColor = [UIColor blackColor];
        [self addSubview:percent];
        _percent = percent;
    }
    return self;
}
- (void)setUp{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect{
    CGSize size = self.bounds.size; // 视图的size
    CGFloat headImgWidth = 20;      // 圆弧头部图片
    CGPoint arcCenter = CGPointMake(size.width/2, size.height/2);   // 圆心坐标
    CGFloat circleLineWidth = 2;    // 圆线宽
    CGFloat radius = size.width/2 - headImgWidth/2;  // 圆半径
    
    CGFloat startRadian = 0;         // 开始弧度
    CGFloat progressDegree = 0;      // 完成比的角度
    CGFloat endRadian = 0;           // 结束弧度
    
    // 画大圆
    startRadian = DEGREES_TO_RADIANS(-90);
    progressDegree = 1 * 360;
    endRadian = DEGREES_TO_RADIANS(progressDegree-90);
    
    UIBezierPath *whileCircle = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startRadian endAngle:endRadian clockwise:YES];
    [GRAY_LEVEL3 setStroke];
    whileCircle.lineCapStyle = kCGLineCapRound;
    whileCircle.lineWidth = circleLineWidth;
    [whileCircle stroke];
    
    // 画圆弧
    startRadian = DEGREES_TO_RADIANS(-90);
    progressDegree = self.progress * 360;
    endRadian = DEGREES_TO_RADIANS(progressDegree-90);
    
    UIBezierPath *arcCircle = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startRadian endAngle:endRadian clockwise:YES];
    [DEF_RGB_COLOR(104, 88, 169, 1) setStroke];
    arcCircle.lineCapStyle = kCGLineCapRound;
    arcCircle.lineWidth = circleLineWidth;
    [arcCircle stroke];
    
    // 画圆弧头部的图片
    CGFloat circleX = 0;
    CGFloat circleY = 0;
    CGFloat progressRadian = DEGREES_TO_RADIANS(progressDegree);    // 完成比的弧度
    circleX = radius * sin(progressRadian)-headImgWidth/2;
    circleY = -radius * cos(progressRadian)-headImgWidth/2;
    // 从圆心坐标系便宜到左上方原点坐标系
//    CGFloat headImgX = size.width/2 + circleX;
//    CGFloat headImgY = size.height/2 + circleY;
    
//    CGRect imgFrame = CGRectMake(headImgX, headImgY, headImgWidth, headImgWidth);
//    UIImage *headImg = [UIImage imageNamed:@""];//icon_schedule
//    [headImg drawInRect:imgFrame];
    
    // 设置限时进度
    self.percent.text = [NSString stringWithFormat:@"%.1f",self.progress*100];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress>1 ? 1 : (progress<0 ? 0 : progress);
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.percent.frame = self.bounds;
    
}

@end
