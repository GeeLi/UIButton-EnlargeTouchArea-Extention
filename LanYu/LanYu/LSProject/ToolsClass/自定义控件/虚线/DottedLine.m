//
//  DottedLine.m
//  Dashed
//
//  Created by 苑佳帅 on 15/12/8.
//  Copyright © 2015年 chaziyjs. All rights reserved.
//

#import "DottedLine.h"

@implementation DottedLine

@synthesize lineColor;
@synthesize type;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

+ (instancetype)dottenLineWithFrame:(CGRect)frame LineColor:(UIColor *)color Type:(DottedLineType)dottedType InView:(UIView *)view
{
    DottedLine *dotted = [[DottedLine alloc] initWithFrame:frame LineColor:color Type:dottedType InView:(UIView *)view];
    return dotted;
}

- (instancetype)initWithFrame:(CGRect)frame LineColor:(UIColor *)color Type:(DottedLineType)dottedType InView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = color;
        self.type = dottedType;
        self.backgroundColor = [UIColor clearColor];
        [view addSubview:self];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [shapeLayer setPosition:CGPointMake(rect.size.width / 2, rect.size.height / 2)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[lineColor CGColor]];
    
    // 3.0f设置虚线的宽度
//    [shapeLayer setLineWidth:1.f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithFloat:2], // 线宽
      [NSNumber numberWithFloat:2],nil]]; // 间距
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (type == VerticalDottedLine) {
//         Setup the path
        int count = rect.size.height / 4;
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, 0, count * 4);
    } else if (type == HorizontalDottedLine) {
        // Setup the path
        // 0,10代表初始坐标的x，y
        // 320,10代表初始坐标的x，y
        CGPathMoveToPoint(path, NULL, 0, 0);
        int count = rect.size.width / 4;
        CGPathAddLineToPoint(path, NULL, count * 4, 0);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView
    [[self layer] addSublayer:shapeLayer];
}


@end
