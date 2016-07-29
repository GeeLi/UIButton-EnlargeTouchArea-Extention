//
//  DWSearchBar.h
//  SearchBar
//
//  Created by 李帅 on 15/9/2.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DWSearchBar : UISearchBar

@property (nonatomic, strong) UIButton *backView;


- (void)addBackView;

- (void)backButtonAction:(UIButton *)sender;


@end
