//
//  ZT_IndexBar.h
//  ZT_IndexBar
//
//  Created by _ziTai on 16/3/17.
//  Copyright © 2016年 _ziTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZT_IndexBar;

@protocol ZT_IndexBarrDelegate <NSObject>

- (void)tableViewIndexBar:(ZT_IndexBar*)indexBar didSelectSectionAtIndex:(NSInteger)index;

@end

@interface ZT_IndexBar : UIView

@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, weak) id <ZT_IndexBarrDelegate> delegate;
@property (nonatomic,retain)UIColor *textColor;

@end