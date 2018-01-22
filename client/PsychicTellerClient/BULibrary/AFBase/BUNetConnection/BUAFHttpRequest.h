//
//  BUAFHttpRequest.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-11.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface BUShowErrorMsg : NSObject

/**
 *  app的token值
 */
@property(nonatomic,copy)NSString *propToken;

+ (instancetype)GetInstance;

- (void)ShowErrorMessage:(NSString*)argError;

@end

@class BUAFHttpRequest;
@class BUBaseResponseData;

@protocol BUAFHttpRequestDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param argRequestTag 请求的标示符
 *  @param argData       返回的数据
 */
-(void)RequestSucceeded:(NSString*)argRequestTag withResponseData:(NSArray*)argData;
@optional

/**
 *  请求出错
 *
 *  @param argRequest 请求对象
 *  @param argMsg     错误原因
 */
-(void)RequestErrorHappened:(BUAFHttpRequest*)argRequest withErrorMsg:(NSString*)argMsg;

@end

@interface BUAFHttpRequest : NSObject

@property (weak, nonatomic) id<BUAFHttpRequestDelegate> propDelegate;

@property (readonly, nonatomic, assign) BOOL proRequestRunning;

/**
 *  请求url
 */
@property (readonly, strong, nonatomic) NSString* propUrl;

/**
 *  需要rsa加密的请求参数
 */
@property (strong, nonatomic ) NSDictionary* propParameters;   // record the parameters

/**
 *  不需要rsa加密的请求参数
 */
@property (strong, nonatomic ) NSDictionary* propNotRsaParameters;   // record the parameters

/**
 *  图片请求参数
 */
@property (strong,nonatomic,readonly) NSDictionary *propImageParameters;

/**
 *  设置返回具体data的类型
 */
@property (assign) Class propDataClass;

/**
 *  请求的标识符
 */
@property (readonly, strong, nonatomic) NSString* propRequestTag;

/**
 *  请求返回的基础解析数据
 */
@property (readonly, nonatomic) BUBaseResponseData* propResponseData;


// Initialization
- (id)initWithShareUrl:(NSString *)argUrl andTag:(NSString *)argTag;
- (id)initWithUrl:(NSString*)argUrl andTag:(NSString*)argTag;

// Start the asynchronous request
- (void)PostAsynchronous;

// use Get request
-(void)GetAsynchronous;

// Set the rsa parameters for the request
- (void)SetParamValue:(NSString*)argValue forKey:(NSString *)argKey;

// Set the not rsa parameters for the request
- (void)SetNotRsaParamValue:(NSString*)argValue forKey:(NSString *)argKey;

// Set the image data parameter for the request
- (void)AddImageData:(UIImage*)argImage forKey:(NSString *)argKey;

// Cancel the request
- (void)Cancel;


@end
