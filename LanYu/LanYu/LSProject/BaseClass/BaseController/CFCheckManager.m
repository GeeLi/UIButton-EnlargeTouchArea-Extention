//
//  CFCheckManager.m
//  CheckVersion
//
//  Created by kidstone on 16/4/8.
//  Copyright © 2016年 CF. All rights reserved.
//

#import "CFCheckManager.h"
#import <StoreKit/StoreKit.h>

#define CURRENT_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define BUNDLE_ID  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define URL_MODE_NORMAL  @"https://itunes.apple.com/lookup?bundleId=%@"
#define URL_MODE_SPECIAL  @"https://itunes.apple.com/lookup?country=%@&bundleId=%@"

#define APP_NEW_VERSION @"APPLastVersion"
#define APP_RELEASE_NOTES @"APPReleaseNotes"
#define APP_TRACK_VIEW_URL @"APPTrackViewUrl"
#define APP_TRACK_ID @"APPTrackId"
#define SKIP_CURRENT_VERSION @"SKIPCURRENTVERSION"
#define SKIP_VERSION @"SKIPVERSION"

#define SYSTEM_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))


@interface CFCheckManager ()<UIAlertViewDelegate,SKStoreProductViewControllerDelegate>
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *skipVersionTitle;

@end

@implementation CFCheckManager

static CFCheckManager *checkManager;
+ (instancetype)sharedCheckManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkManager = [[[self class] alloc] init];
        checkManager.cancelTitle    = @"下次再说";
        checkManager.confirmTitle   = @"前往更新";
        checkManager.alertTitle     = @"发现新版本";
        checkManager.skipVersionTitle = nil;
        checkManager.isDevelopTest        = NO;

    });
    
    return checkManager;
}

- (void)checkVersion{
    
    [self checkVersionWithAlertTitle:_alertTitle cancelTitle:_cancelTitle confirmTitle:_confirmTitle];
    
}

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle{
    
    [self checkVersionWithAlertTitle:_alertTitle cancelTitle:_cancelTitle confirmTitle:_confirmTitle skipVersionTitle:_skipVersionTitle];
}

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle skipVersionTitle:(NSString *)skipVersionTitle{
    
    self.alertTitle = alertTitle;
    self.cancelTitle = cancelTitle;
    self.confirmTitle = confirmTitle;
    self.skipVersionTitle = skipVersionTitle;
    [checkManager getInfoFromAPPStore];
    
}

- (void)getInfoFromAPPStore
{
    
    NSURL *requestURL;
    if (self.countryAbbreviation){
        requestURL = [NSURL URLWithString:[NSString stringWithFormat:URL_MODE_SPECIAL,_countryAbbreviation,BUNDLE_ID]];

    } else {
        requestURL = [NSURL URLWithString:[NSString stringWithFormat:URL_MODE_NORMAL,BUNDLE_ID]];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200){
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if ([responseDic[@"resultCount"] intValue] == 1){
                
                NSArray *results = responseDic[@"results"];
                NSDictionary *resultsDic = [results firstObject];
                NSString *trackId = resultsDic[@"trackId"];
                
                [userDefaults setObject:resultsDic[@"version"] forKey:APP_NEW_VERSION];
                [userDefaults setObject:resultsDic[@"releaseNotes"] forKey:APP_RELEASE_NOTES];
                [userDefaults setObject:resultsDic[@"trackViewUrl"] forKey:APP_TRACK_VIEW_URL];
                [userDefaults setObject:trackId forKey:APP_TRACK_ID];
                
                if ([resultsDic[@"version"] isEqualToString:CURRENT_VERSION] || ![[userDefaults objectForKey:SKIP_VERSION] isEqualToString:resultsDic[@"version"]]) {
                    [userDefaults setBool:NO forKey:SKIP_CURRENT_VERSION];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    if (![[userDefaults objectForKey:SKIP_CURRENT_VERSION] boolValue]) {
                       
                        if (self.isDevelopTest) {
                            [self compareWithCurrentVersion];
                        } else {
                            if ([resultsDic[@"version"] compare:CURRENT_VERSION] == NSOrderedDescending)
                            {
                                [self compareWithCurrentVersion];
                            }
                        }
    
                    }
                });
            }
//            DJLog(@"%@   %@",[userDefaults objectForKey:APP_NEW_VERSION],[userDefaults objectForKey:APP_RELEASE_NOTES]);
        }
    }];
    
    [dataTask resume];
}




- (void)compareWithCurrentVersion{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *updateMessage = [userDefault objectForKey:APP_RELEASE_NOTES];
    if (![[userDefault objectForKey:APP_NEW_VERSION] isEqualToString:CURRENT_VERSION]){
        
        if (SYSTEM_VERSION_8_OR_ABOVE){
        
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertControlle = [UIAlertController alertControllerWithTitle:self.alertTitle message:updateMessage preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:self.cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:self.confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf openAPPStore];
            }];
            
            [alertControlle addAction:cancelAction];
            [alertControlle addAction:confirmAction];
            
            if (self.skipVersionTitle != nil) {
                UIAlertAction *skipVersionAction = [UIAlertAction actionWithTitle:self.skipVersionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [userDefault setBool:YES forKey:SKIP_CURRENT_VERSION];
                    [userDefault setObject:[userDefault objectForKey:APP_NEW_VERSION] forKey:SKIP_VERSION];
                }];
                
                [alertControlle addAction:skipVersionAction];
            }
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertControlle animated:YES completion:^{
                
            }];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.alertTitle message:updateMessage delegate:self cancelButtonTitle:self.cancelTitle otherButtonTitles:self.confirmTitle, nil];
            [alertView show];
        }
      
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self openAPPStore];
    }
    
}

- (void)openAPPStore{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (!self.openAppStoreInsideApp){
        NSString *viewUrl = [userDefault objectForKey:APP_TRACK_VIEW_URL];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:viewUrl]];
    } else {
        SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
        storeViewController.delegate = self;
        
        NSDictionary *parametersDic = @{SKStoreProductParameterITunesItemIdentifier:[userDefault objectForKey:APP_TRACK_ID]};
        [storeViewController loadProductWithParameters:parametersDic completionBlock:^(BOOL result, NSError * _Nullable error) {
           
            if (result) {
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeViewController animated:YES completion:^{
                    
                }];
            }
        }];
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
