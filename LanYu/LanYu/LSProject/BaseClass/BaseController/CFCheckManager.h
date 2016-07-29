//
//  CFCheckManager.h
//  CheckVersion
//
//  Created by kidstone on 16/4/8.
//  Copyright © 2016年 CF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFCheckManager :   NSObject

/**
 open APPStroe inside your APP, default is NO.
 */
@property (nonatomic, assign) BOOL openAppStoreInsideApp;

/**
 if you can't get the update info of your APP, please set countryAbbreviation of the shelf area. like the countryAbbreviation = @"cn" or countryAbbreviation = @"us".
 General, you don't need to set this property.
 */
@property (nonatomic, copy) NSString *countryAbbreviation;

/**
 default is NO, but if you need to test, please set to yes.
 */
@property (nonatomic, assign) BOOL isDevelopTest;

/**
 get a singleton of the CheckManager
 */
+ (instancetype)sharedCheckManager;

/**
 start check version with default param.
 */
- (void)checkVersion;

/**
 start check version with AlertTitle、CancelTitle、ConfirmTitle.
 */
- (void)checkVersionWithAlertTitle:(NSString *)alertTitle cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle;

/**
 start check version with AlertTitle、CancelTitle、ConfirmTitle、skipVersionTitle.
 */
- (void)checkVersionWithAlertTitle:(NSString *)alertTitle cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle skipVersionTitle:(NSString *)skipVersionTitle;

@end
