//
//  MJRefreshGifHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshGifHeader.h"

@interface MJRefreshGifHeader()
{
    __unsafe_unretained UIImageView *_gifView;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation MJRefreshGifHeader
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) { 
        UIImageView *gifView = [[UIImageView alloc] init]; 
        [self addSubview:_gifView = gifView]; 
    } 
    return _gifView; 
}

- (NSMutableDictionary *)stateImages 
{ 
    if (!_stateImages) { 
        self.stateImages = [NSMutableDictionary dictionary]; 
    } 
    return _stateImages; 
}

- (NSMutableDictionary *)stateDurations 
{ 
    if (!_stateDurations) { 
        self.stateDurations = [NSMutableDictionary dictionary]; 
    } 
    return _stateDurations; 
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state 
{ 
    if (images == nil) return; 
    
    self.stateImages[@(state)] = images; 
    self.stateDurations[@(state)] = @(duration); 
    
    /* 根据图片设置控件的高度 */ 
    UIImage *image = [images firstObject]; 
    if (image.size.height > self.mj_h) { 
        self.mj_h = 50; 
    } 
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state 
{
    [self setImages:images duration:images.count * 0.1 forState:state]; 
}

#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];

    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
    if (pullingPercent > 1) {
        pullingPercent = 1;
    }
    CGFloat height = pullingPercent * 50;
    self.gifView.frame = CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height);
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        [self.gifView stopAnimating];
    }
}

- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%zd", i]];
        [refreshingImages addObject:image];
    }
    //    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
