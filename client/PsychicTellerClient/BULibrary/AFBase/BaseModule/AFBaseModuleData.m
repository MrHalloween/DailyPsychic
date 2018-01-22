//
//  AFBaseModuleData.m
//  pbuYaLianWuYeClient
//
//  Created by  on 16/7/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "AFBaseModuleData.h"

@implementation AFBaseModuleData

- (id)init
{
    self = [super init];
    if (self)
    {
        unsigned int outCount = 0;
        objc_property_t *arrProperty = class_copyPropertyList(self.class, &outCount);
        for (NSInteger i = 0; i < outCount; i ++)
        {
            const char *propertyName = property_getName(arrProperty[i]);
            NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
            SEL setterSEL = [self CreatSetterSEL:strPropertyName];
            unsigned int count = 0;
            objc_property_attribute_t *atts = property_copyAttributeList(arrProperty[i], &count);
            objc_property_attribute_t att = atts[0];
            NSString *strAttributeName = [NSString stringWithUTF8String:att.value];
            if ([[strAttributeName uppercaseString] isEqualToString:@"Q"] || [[strAttributeName uppercaseString] isEqualToString:@"I"] || [[strAttributeName uppercaseString] isEqualToString:@"L"])
            {
                ((void (*) (id , SEL , id))objc_msgSend)(self , setterSEL , 0);
            }
            else if ([[strAttributeName uppercaseString] isEqualToString:@"D"] || [[strAttributeName uppercaseString] isEqualToString:@"F"])
            {
                ((void (*) (id , SEL , CGFloat))objc_msgSend)(self , setterSEL , 0.0f);
            }
            else if ([[strAttributeName uppercaseString] isEqualToString:@"B"] || [[strAttributeName uppercaseString] isEqualToString:@"C"])
            {
                ((void (*) (id , SEL , BOOL))objc_msgSend)(self , setterSEL , NO);
            }
            else
            {
                NSArray *arrAttribute = [strAttributeName componentsSeparatedByString:@"\""];
                if (arrAttribute.count < 2){
                    continue;
                }
                NSString *strAttribute = arrAttribute[1];
                Class class = NSClassFromString(strAttribute);
                ((void (*) (id , SEL , id))objc_msgSend)(self , setterSEL , [[class alloc]init]);
            }
        }
        free(arrProperty);
    }
    return self;
}

#pragma mark -- 深复制
- (id)copyWithZone:(NSZone *)zone
{
    AFBaseModuleData *pBaseModuleData = [[self class] allocWithZone:zone];
    unsigned int outCount = 0;
    objc_property_t *arrProperty = class_copyPropertyList(self.class, &outCount);
    for (NSInteger i = 0; i < outCount; i ++)
    {
        const char *propertyName = property_getName(arrProperty[i]);
        NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
        unsigned int count = 0;
        objc_property_attribute_t *atts = property_copyAttributeList(arrProperty[i], &count);
        objc_property_attribute_t att = atts[0];
        NSString *strAttributeName = [NSString stringWithUTF8String:att.value];
        SEL getterSEL = [self CreatGetterSEL:strPropertyName];
        SEL setterSEL = [self CreatSetterSEL:strPropertyName];
        
        if ([[strAttributeName uppercaseString] isEqualToString:@"Q"] || [[strAttributeName uppercaseString] isEqualToString:@"I"] || [[strAttributeName uppercaseString] isEqualToString:@"L"])
        {
            NSInteger obj = ((NSInteger (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , NSInteger))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"D"] || [[strAttributeName uppercaseString] isEqualToString:@"F"])
        {
            CGFloat obj = ((CGFloat (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , CGFloat))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"B"] || [[strAttributeName uppercaseString] isEqualToString:@"C"])
        {
            BOOL obj = ((BOOL (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , BOOL))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else
        {
            id obj = ((id (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id ,SEL , id))objc_msgSend)(pBaseModuleData,setterSEL,[obj copy]);
            }
        }
    }
    free(arrProperty);
    return pBaseModuleData;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    AFBaseModuleData *pBaseModuleData = [[self class] allocWithZone:zone];
    unsigned int outCount = 0;
    objc_property_t *arrProperty = class_copyPropertyList(self.class, &outCount);
    for (NSInteger i = 0; i < outCount; i ++)
    {
        const char *propertyName = property_getName(arrProperty[i]);
        NSString *strPropertyName = [NSString stringWithUTF8String:propertyName];
        unsigned int count = 0;
        objc_property_attribute_t *atts = property_copyAttributeList(arrProperty[i], &count);
        objc_property_attribute_t att = atts[0];
        NSString *strAttributeName = [NSString stringWithUTF8String:att.value];
        SEL getterSEL = [self CreatGetterSEL:strPropertyName];
        SEL setterSEL = [self CreatSetterSEL:strPropertyName];
        
        if ([[strAttributeName uppercaseString] isEqualToString:@"Q"] || [[strAttributeName uppercaseString] isEqualToString:@"I"] || [[strAttributeName uppercaseString] isEqualToString:@"L"])
        {
            NSInteger obj = ((NSInteger (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , NSInteger))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"D"] || [[strAttributeName uppercaseString] isEqualToString:@"F"])
        {
            CGFloat obj = ((CGFloat (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , CGFloat))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"B"] || [[strAttributeName uppercaseString] isEqualToString:@"C"])
        {
            BOOL obj = ((BOOL (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id , SEL , BOOL))objc_msgSend)(self , setterSEL , obj);
            }
        }
        else
        {
            id obj = ((id (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (obj)
            {
                ((void (*) (id ,SEL , id))objc_msgSend)(pBaseModuleData,setterSEL,[obj copy]);
            }
        }
    }
    free(arrProperty);
    return pBaseModuleData;
}

#pragma mark -- 解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(self.class, &outCount);
        for (NSInteger i = 0; i < outCount; i ++)
        {
            const char *ivarName = ivar_getName(ivars[i]);
            NSString *strIvarName = [NSString stringWithUTF8String:ivarName];
            NSString *strPropName = [strIvarName substringFromIndex:1];
            const char *ivarAttri = ivar_getTypeEncoding(ivars[i]);
            NSString *strAttributeName = [NSString stringWithUTF8String:ivarAttri];
            SEL setterSEL = [self CreatSetterSEL:strPropName];
            if ([[strAttributeName uppercaseString] isEqualToString:@"Q"] || [[strAttributeName uppercaseString] isEqualToString:@"I"] || [[strAttributeName uppercaseString] isEqualToString:@"L"])
            {
                NSInteger obj = [aDecoder decodeIntegerForKey:strPropName];
                if (obj)
                {
                    ((void (*) (id , SEL , NSInteger))objc_msgSend)(self , setterSEL , obj);
                }
            }
            else if ([[strAttributeName uppercaseString] isEqualToString:@"D"] || [[strAttributeName uppercaseString] isEqualToString:@"F"])
            {
                CGFloat obj = [aDecoder decodeFloatForKey:strPropName];
                if (obj)
                {
                    ((void (*) (id , SEL , CGFloat))objc_msgSend)(self , setterSEL , obj);
                }
            }
            else if ([[strAttributeName uppercaseString] isEqualToString:@"B"] || [[strAttributeName uppercaseString] isEqualToString:@"C"])
            {
                BOOL obj = [aDecoder decodeBoolForKey:strPropName];
                if (obj)
                {
                    ((void (*) (id , SEL , BOOL))objc_msgSend)(self , setterSEL , obj);
                }
            }
            else
            {
                id obj = [aDecoder decodeObjectForKey:strPropName];
                if (obj)
                {
                    ((void (*) (id , SEL , id))objc_msgSend)(self , setterSEL , obj);
                }
            }
        }
        free(ivars);
    }
    return self;
}

#pragma mark -- 编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    for (NSInteger i = 0; i < outCount; i ++)
    {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *strIvarName = [NSString stringWithUTF8String:ivarName];
        NSString *strPropName = [strIvarName substringFromIndex:1];
        SEL getterSEL = [self CreatGetterSEL:strPropName];
        
        
        const char *ivarAttri = ivar_getTypeEncoding(ivars[i]);
        NSString *strAttributeName = [NSString stringWithUTF8String:ivarAttri];
        if ([[strAttributeName uppercaseString] isEqualToString:@"Q"] || [[strAttributeName uppercaseString] isEqualToString:@"I"] || [[strAttributeName uppercaseString] isEqualToString:@"L"])
        {
            NSInteger value =  ((NSInteger (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (value)
            {
                [aCoder encodeInteger:value forKey:strPropName];
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"D"] || [[strAttributeName uppercaseString] isEqualToString:@"F"])
        {
            CGFloat value =  ((CGFloat (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (value)
            {
                [aCoder encodeFloat:value forKey:strPropName];
            }
        }
        else if ([[strAttributeName uppercaseString] isEqualToString:@"B"] || [[strAttributeName uppercaseString] isEqualToString:@"C"])
        {
            BOOL value =  ((BOOL (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (value)
            {
                [aCoder encodeBool:value forKey:strPropName];
            }
        }
        else
        {
            id value = ((id (*) (id , SEL))objc_msgSend)(self , getterSEL);
            if (value)
            {
                [aCoder encodeObject:value forKey:strPropName];
            }
        }
    }
    free(ivars);
}

#pragma mark -- Creat Setter\Getter Method
- (SEL)CreatSetterSEL:(NSString *)propertyName
{
    NSString *strSEL = [NSString stringWithFormat:@"set%@%@:",[[propertyName substringToIndex:1]uppercaseString],[propertyName substringFromIndex:1]];
    SEL setterSEL = NSSelectorFromString(strSEL);
    return setterSEL;
}

- (SEL)CreatGetterSEL:(NSString *)propertyName
{
    NSString *strSEL = [NSString stringWithFormat:@"%@",propertyName];
    SEL getterSEL = NSSelectorFromString(strSEL);
    return getterSEL;
}

@end
