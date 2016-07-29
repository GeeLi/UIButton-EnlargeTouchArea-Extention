//
//  RegularExpression.h
//  Regular
//
//  Created by 苑佳帅 on 15/12/16.
//  Copyright © 2015年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpression : NSObject

+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateMobile:(NSString *)mobile;
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

@end
