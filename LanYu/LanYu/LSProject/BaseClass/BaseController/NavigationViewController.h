//
//  NavigationViewController.h
//  KuaiLaiLife
//
//  Created by 李帅 on 15/6/18.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController

@property (nonatomic, strong) id popdelegate;


+ (NavigationViewController *)defaultNavigation;

@end
