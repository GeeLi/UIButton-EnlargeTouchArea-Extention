//
//  DWImageView.m
//  YeHeApp
//
//  Created by 李帅 on 15/11/3.
//  Copyright © 2015年 李帅. All rights reserved.
//

#import "DWImageView.h"

@implementation DWImageView


- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        [self setImage:_selectedImage];
    } else {
        [self setImage:_normalImage];
    }
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIImageState)state
{
    if (state == UIImageStateNormal) {
        self.normalImage = image;
    } else if (state == UIImageStateSelected) {
        self.selectedImage =image;
    }
}

@end
