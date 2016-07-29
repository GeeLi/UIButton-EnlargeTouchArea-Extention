//
//  FZButton.h
//  WelfareClub
//
//  Created by 李帅 on 15/8/23.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZButton : UIButton

@property (nonatomic, assign) CGRect imgFrame;

@property (nonatomic, assign) CGRect titleFrame;

@property (nonatomic, assign) float fontSize;

@property (nonatomic, assign) BOOL showBadge;


/**角标**/
- (void)createBadge;


@end
