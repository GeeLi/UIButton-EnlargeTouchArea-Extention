//
//  BRScrollBarController.h
//  BRScrollBarDemo
//
//  Created by Basheer on 5/2/13.
//  Copyright (c) 2013 Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRScrollBarView.h"
#import "BRCommonMethods.h"

@protocol BRScrollBarControllerDelegate ;
@interface BRScrollBarController : UIViewController  <BRScrollBarProtocol>
{
    UIScrollView *_scrollView;
}
@property (nonatomic, assign) BRScrollBarPostions scrollBarPostion;     //left or right
@property (nonatomic, readonly) BRScrollBarView *scrollBar;
@property (nonatomic, assign) id<BRScrollBarControllerDelegate> delegate;

- (id)initForScrollView:(UIScrollView *)scrollView HandleColor:(UIColor *)color;
- (id)initForScrollView:(UIScrollView *)scrollView inPosition:(BRScrollBarPostions)position Handle:(UIColor *)color;
+ (id)initForScrollView:(UIScrollView *)scrollView onPosition:(BRScrollBarPostions)position delegate:(id<BRScrollBarControllerDelegate>)delegate HandleColor:(UIColor *)color;


@end

//=================================Protocol===============================================//
@protocol BRScrollBarControllerDelegate <NSObject>
@optional
- (NSString *)brScrollBarController:(BRScrollBarController *)controller textForCurrentPosition:(CGPoint)position;

@end
//=========================================================================================