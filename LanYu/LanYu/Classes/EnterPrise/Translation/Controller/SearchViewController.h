//
//  SearchViewController.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/23.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchModel.h"
typedef void (^SearchBlock)(SearchModel *model);
@interface SearchViewController : BaseViewController
@property (nonatomic, copy) SearchBlock searchBlock;
@end
