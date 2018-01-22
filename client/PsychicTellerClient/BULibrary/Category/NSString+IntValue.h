//
//  NSString+IntValue.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by 周杰 on 15/7/23.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(IntValue)

+(NSString*)IntString:(int)argIntValue;

+(NSString*)IntergerString:(NSInteger)argInterger;

+(NSInteger)GetStringCharSize:(NSString*)argString;

- (BOOL)IsTheCombinationLettersAndNumbers;

@end
