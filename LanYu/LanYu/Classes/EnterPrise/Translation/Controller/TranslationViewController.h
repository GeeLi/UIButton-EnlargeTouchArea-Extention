//
//  TransferViewController.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/21.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import "BaseViewController.h"
typedef enum{
    TranslateTypeLocal,
    TranslateTypeDataBase,
}TranslateType;

@class SearchModel;
@interface TranslationViewController : BaseViewController
//@property (nonatomic, assign) BOOL isGoToTranslation;
@property (nonatomic, assign) BOOL isDailyLearning;
@property (nonatomic, strong) SearchModel *model;
@property (nonatomic, strong) NSMutableArray *resultArr;
@property (nonatomic, strong) NSMutableArray *testArr;
//- (void)beginSearching;
@end
