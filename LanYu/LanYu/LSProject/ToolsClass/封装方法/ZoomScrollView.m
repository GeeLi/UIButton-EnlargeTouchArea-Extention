//  GalleryViewDemo
//
//  Created by line0 on 13-5-27.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "ZoomScrollView.h"

@interface ZoomScrollView ()
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, assign) BOOL          doubleTapped;

@end

@implementation ZoomScrollView

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [self initWithFrame:frame];
    if (self)
    {

        [self setMinimumZoomScale:1];
        [self setMaximumZoomScale:3];
        [self setZoomScale:1];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setDelegate:self];
        
        CGFloat height = frame.size.width / image.size.width * image.size.height;
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self.imageView setFrame:CGRectMake(0, (self.frame.size.height - height) / 2, self.frame.size.width, height)];
        [self.imageView setUserInteractionEnabled:YES];
        [self addSubview:self.imageView];
        
//        self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//        [self.doubleTapGesture setNumberOfTapsRequired:2];
//        [self.imageView addGestureRecognizer:self.doubleTapGesture];
    }
    return self;
}


#pragma mark - Zoom methods

//- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
//{
//    self.doubleTapped = !self.doubleTapped;
//
//    float newScale = 1;
//    if (self.doubleTapped)
//        newScale = self.zoomScale * 3;
//    else
//        newScale = 1;
//    CGPoint center = [gesture locationInView:gesture.view];
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:center];
//    [self zoomToRect:zoomRect animated:YES];
//}
//
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

- (void)relayoutImageView
{
    CGPoint imageCenter = CGPointZero;
    if (self.contentSize.height <= self.frame.size.height)
        imageCenter = CGPointMake(self.contentSize.width/2, self.frame.size.height/2);
    else
        imageCenter = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
    
    [self.imageView setCenter:imageCenter];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(double)scale
{
    [scrollView setZoomScale:scale animated:NO];
    
    [self relayoutImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self relayoutImageView];
}


@end
