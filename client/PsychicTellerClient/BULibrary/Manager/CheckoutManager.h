//
//  CheckoutManager.h
//  pbuBaseLibrary
//
//  Created by zhanghe on 2018/1/20.
//  Copyright © 2018年 1bu2bu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckoutManager : NSObject

//email
+ (BOOL) isEmail:(NSString *)email;

//phone number
+ (BOOL) isPhoneNumber:(NSString *)mobile;

//bank card number
+ (BOOL) IsBankCard:(NSString *)cardNumber;

@end
