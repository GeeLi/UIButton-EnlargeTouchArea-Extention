//
//  CUTextField.m
//  TextFieldTest
//
//  Created by 李帅 on 15/6/30.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "DWTextField.h"

@implementation DWTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeHolderGap = 12;
        self.editGap = 10;
        self.textRectGap = 10;
    }
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + _placeHolderGap, bounds.origin.y, bounds.size.width, bounds.size.height);

}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + _editGap, bounds.origin.y, bounds.size.width, bounds.size.height);

}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + _textRectGap, bounds.origin.y, bounds.size.width, bounds.size.height);
}


@end
