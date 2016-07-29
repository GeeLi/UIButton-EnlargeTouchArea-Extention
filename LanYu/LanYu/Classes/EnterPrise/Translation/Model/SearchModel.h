//
//  SearchModel.h
//  SocialWorkDict
//
//  Created by iOS-李帅 on 16/3/23.
//  Copyright © 2016年 topwaysoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property (nonatomic, copy) NSString *wordId;
@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *explanation;
@property (nonatomic, copy) NSString *example;
@property (nonatomic, copy) NSString *exampleExplanation;
@property (nonatomic, assign) BOOL showClear;
@property (nonatomic, strong) NSArray *relations;
@property (nonatomic, copy) NSString *favorTime;
@property (nonatomic, assign) BOOL showNoResult;
@property (nonatomic, assign) BOOL showMeans;
@end
