//  GalleryViewDemo
//
//  Created by line0 on 13-5-27.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomScrollView : UIScrollView <UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@property (nonatomic, strong, readonly) UIImageView   *imageView;
//@property (nonatomic, assign, readonly) BOOL          doubleTapped;

//@property (nonatomic, strong, readonly) UITapGestureRecognizer *doubleTapGesture;


@end
