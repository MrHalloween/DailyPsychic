//
//  BUBaseResponseData.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-6.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUBaseResponseData.h"

@implementation BUBaseResponseData

@synthesize  propParsedDatas;

-(instancetype)init
{
    self = [super init];
    self.errorMsg = @"";
    self.propParsedDatas = [NSArray array];
    return self;
}

-(NSArray*)ParseDataArray:(Class)argDataClass
{
    if([self.data isKindOfClass:[NSArray class]])
    {
        self.propParsedDatas = [self ParseJSONArray:self.data WithDataClass:argDataClass];
        return self.propParsedDatas;
    }
    if([self.data isKindOfClass:[NSDictionary class]])
    {
        id pObject = [RMMapper objectWithClass:argDataClass fromDictionary:self.data];
        self.propParsedDatas = [NSArray arrayWithObject:pObject];
        return self.propParsedDatas;
    }
    if ([self.data isKindOfClass:[NSString class]])
    {
        NSString *strData = (NSString *)self.data;
        if (![strData isEqualToString:@""])
        {
            self.propParsedDatas = [NSArray arrayWithObject:strData];
            return self.propParsedDatas;
        }
    }
    return nil;
}

-(NSArray*)ParseJSONArray:(NSArray*)argJSONArray
            WithDataClass:(Class)argDataClass
{
    NSArray* arrResult = [RMMapper arrayOfClass:argDataClass fromArrayOfDictionary:argJSONArray];
    
    return arrResult;
}



@end
