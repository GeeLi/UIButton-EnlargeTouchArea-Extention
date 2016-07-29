//
//  ZT_IndexBar.m
//  ZT_IndexBar
//
//  Created by _ziTai on 16/3/17.
//  Copyright © 2016年 _ziTai. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ZT_IndexBar.h"


//#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

@interface ZT_IndexBar (){
    BOOL isLayedOut;
    BOOL isPan;
    CGFloat letterHeight;
}

@end


@implementation ZT_IndexBar


- (id)init{
    if (self = [super init]){

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){

    }
    return self;
}


- (void)setIndexes:(NSArray *)idxs{
    _indexes = idxs;
    isLayedOut = NO;
//    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (!isLayedOut){
        
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        letterHeight = self.frame.size.height / [_indexes count];
        CGFloat fontSize = 14;
        if (letterHeight < 14){
            fontSize = 11;
        }
        
        [_indexes enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * letterHeight;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, letterHeight)];
            [self.layer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        

        isLayedOut = YES;
    }
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    if (!_textColor) {
        [tl setForegroundColor:[UIColor grayColor].CGColor];
    }
    else
    {
        [tl setForegroundColor:_textColor.CGColor];
    }
    [tl setString:string];
    return tl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    isPan = NO;
    [self sendEventToDelegate:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    isPan = YES;
    [self sendEventToDelegate:event];
}
- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger indx = (NSInteger) floorf(fabs(point.y) / letterHeight);
    indx = indx < [_indexes count] ? indx : [_indexes count] - 1;
    if (isPan) {
        [self animateLayerAtIndex:indx];
    }
    
    __block NSInteger scrollIndex;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, indx+1)];
    [_indexes enumerateObjectsAtIndexes:indexSet options:NSEnumerationReverse usingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
        scrollIndex = [_indexes indexOfObject:letter];
        *stop = scrollIndex != NSNotFound;
    }];
    if ([_delegate respondsToSelector:@selector(tableViewIndexBar:didSelectSectionAtIndex:)]) {
        [_delegate tableViewIndexBar:self didSelectSectionAtIndex:scrollIndex];
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self goback];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self goback];
}
- (void)animateLayerAtIndex:(NSUInteger)index{
    if ([self.layer.sublayers count] - 1 > index)
    {
        
        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {

             NSUInteger a =  abs(index - idx);
             
             if (a < 4)
             {
                 
                 obj.transform = CATransform3DMakeScale(0.5 *(4 -a) *1 , 0.5 *(4 -a)*1, 1);
                 
                 obj.position = CGPointMake(-letterHeight * 4 * sin(M_PI/180*90*((4 - a)/4.0)),letterHeight*idx );
                 
             }
             else
             {
                 obj.transform = CATransform3DMakeScale(1  , 1 , 1);
                 obj.position = CGPointMake( 10,letterHeight*idx );
                 
             }
         }];
        
    }
}
-(void)goback
{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         obj.transform = CATransform3DMakeScale(1  , 1 , 1);
         obj.position = CGPointMake( 10,letterHeight*idx );
         
         
     }];
    
}

@end
