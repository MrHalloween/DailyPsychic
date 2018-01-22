//
//  NSString+IntValue.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by 周杰 on 15/7/23.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "NSString+IntValue.h"

@implementation NSString(IntValue)

+(NSString*)IntString:(int)argIntValue
{
    return [NSString stringWithFormat:@"%d",argIntValue];
}

+(NSString*)IntergerString:(NSInteger)argInterger
{
    return [NSString stringWithFormat:@"%d", (int)argInterger];
}

+(NSInteger)GetStringCharSize:(NSString*)argString
{
    NSInteger strlength = 0;
    char* p = (char*)[argString cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[argString lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (BOOL)IsTheCombinationLettersAndNumbers
{
    for (NSInteger iIndex = 0; iIndex < self.length; iIndex ++)
    {
        char p = [self characterAtIndex:iIndex];
        
        if (('a' <= p && p <= 'z') || ('A' <= p && p <= 'Z') || ('0' <= p && p <= '9'))
        {
            
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

@end
