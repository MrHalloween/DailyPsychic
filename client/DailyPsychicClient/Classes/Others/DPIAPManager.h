//
//  DPIAPManager.h
//  DailyPsychicClient
//
//  Created by zhanghe on 2018/2/9.
//  Copyright © 2018年 h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void (^block)(void);

typedef void(^CheckReceipt)(id object);


@interface DPIAPManager : NSObject

@property(nonatomic,copy)CheckReceipt propCheckReceipt;

+ (instancetype)sharedManager;

///判断本地沙盒是否存储了receiptData数据
- (BOOL)isHaveReceiptInSandBox;

///请求商品数据
- (void)requestProductWithProductId:(NSString *)productId;

///验证购买，避免越狱软件模拟苹果请求达到非法购买问题
- (void)checkReceiptIsValid:(NSString *)environment firstBuy:(block)firstBuy outDate:(block)outDate inDate:(block)inDate;

@end
