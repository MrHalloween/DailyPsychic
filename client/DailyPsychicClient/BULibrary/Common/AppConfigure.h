//
//  AppConfigure.h
//  pbuWorldMysteryLite
//
//  Created by Yan Xue on 12-2-13.
//  Copyright (c) 2012年 ShootingChance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppConfigure : NSObject

+ (NSString*)GetWebServiceDomain;
+ (NSString*)GetHtmlDomain;
+ (NSString*)GetFileDomain;
+ (NSString*)GetPayDomain;
+ (NSString*)GetShareDomain;
+ (NSString *)GetEnvironment;

#pragma mark - screen adaption
+(CGFloat) GetLengthAdaptRate;

@end
