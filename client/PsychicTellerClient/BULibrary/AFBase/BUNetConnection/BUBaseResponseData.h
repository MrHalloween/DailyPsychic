//
//  BUBaseResponseData.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-6.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMapper.h"

///
/// Request返回的解析Data

@interface BUBaseResponseData : NSObject


@property (assign) int status;                                  ///请求状态 0正常 1用户错误 2系统错误
@property (strong,nonatomic) NSString * errorMsg;                  ///错误信息 error_msg
@property (strong,nonatomic) id data;                               ///返回值中的data json array
@property (nonatomic,strong) NSArray * propParsedDatas;             ///data数组解析过的数据对象的数组


/*
 * Parse data from 'data' array
 * @param argDataClass parsed object's class
 */
-(NSArray*)ParseDataArray:(Class)argDataClass;

/*
 * Parse data from 'data' array
 * @param argJSONArray json array
 * @param argDataClass parsed object's class
 * @retrun parsed object array
 */
-(NSArray*)ParseJSONArray:(NSArray*)argJSONArray
            WithDataClass:(Class)argDataClass;

@end

