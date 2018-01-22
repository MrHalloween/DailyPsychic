//
//  BUAFHttpRequest.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-11.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUAFHttpRequest.h"
#import "BUBaseResponseData.h"
#import "AppConfigure.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "RSAEncryptor.h"
#import "NSString+TimeFormat.h"

@interface BUAFHttpRequest ()
{
    NSString* m_strUrl;                     // record the url;
    NSString* m_strRequestTag;              // the variable to record the reqeust tag
    NSDictionary* m_dicParameters;          // the vairable to record the parameters
    NSDictionary* m_dicNotRsaParameters;          // the vairable to record the parameters
    NSDictionary* m_dicImageParas;          // The variable to record the parameters of type UIImage;
    BUBaseResponseData* m_pResponseData;                // The response data
    AFHTTPSessionManager* m_pRequestManager; // The AFHTTPrequest operation manager;
    NSURLSessionDataTask* m_pRequest;        // The post operation
}

@end


@implementation BUAFHttpRequest

@synthesize propUrl = m_strUrl;
@synthesize propParameters = m_dicParameters;
@synthesize propNotRsaParameters = m_dicNotRsaParameters;
@synthesize propResponseData = m_pResponseData;
@synthesize propRequestTag = m_strRequestTag;

- (void)Init
{
    m_dicNotRsaParameters = [[NSMutableDictionary alloc]init];
    m_dicParameters = [[NSMutableDictionary alloc] init];
    m_dicImageParas = [[NSMutableDictionary alloc] init];
    m_pRequestManager = [AFHTTPSessionManager manager];
     /*! 设置请求超时时间 */
    m_pRequestManager.requestSerializer.timeoutInterval = 30;
    m_pRequestManager.responseSerializer.acceptableContentTypes =  [m_pRequestManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    /*
    ZTLoginData *pUserData = [ModuleTool sharedModuleTool].proUserInfoData;
    if (pUserData)
    {
        [m_dicParameters setValue:pUserData.uid forKey:@"uid"];
        [m_dicParameters setValue:[[NSString stringWithFormat:@"%@_X&*jfUuAn(&jfdI=6",pUserData.token] md5] forKey:@"token"];
    }
     */

}

- (id)initWithShareUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    [self Init];
    m_strUrl = argUrl;
    m_strRequestTag = argTag;

    
    m_pRequestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return self;
}

-(id)initWithUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    [self Init];
    if ([argUrl hasPrefix:@"http"])
    {
        m_strUrl = argUrl;
    }
    else
    {
        m_strUrl = [NSString stringWithFormat:@"%@%@", [AppConfigure GetWebServiceDomain],argUrl];
    }
    m_strRequestTag = argTag;
    
    return self;
}

- (void)SetParamValue:(NSString*)argValue forKey:(NSString *)argKey;
{
    [m_dicParameters setValue:argValue forKey:argKey];
}

- (void)SetNotRsaParamValue:(NSString*)argValue forKey:(NSString *)argKey;
{
    [m_dicNotRsaParameters setValue:argValue forKey:argKey];
}

- (void)AddImageData:(UIImage*)argImage forKey:(NSString *)argKey;
{
    [m_dicImageParas setValue:argImage forKey:argKey];
}

-(void)PostAsynchronous
{
    [self Cancel];
    if([m_dicImageParas count] == 0)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:m_dicParameters options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *paramJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",paramJson);
        [self rsa];
        
        NSLog(@"实发参数-----%@",m_dicNotRsaParameters);
        
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicNotRsaParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
    else
    {
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSArray* arrKeys = m_dicImageParas.allKeys;
            for( NSString* strKey in arrKeys)
            {
                UIImage* pImage = [m_dicImageParas objectForKey:strKey];
                NSData *imageData = UIImageJPEGRepresentation(pImage, 0.7);
                [formData appendPartWithFileData:imageData
                                            name:strKey
                                        fileName:@"test.jpg"
                                        mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
}

- (void)rsa
{
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSMutableString *params = [NSMutableString stringWithFormat:@"appKey=%@&deviceId=%@&timestamp=%@",[@"X&*jfUuAn(&jfdI=6" md5],uuid,[NSString getCurrentTimestamp]];
    [m_dicParameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *param = [NSString stringWithFormat:@"&%@=%@",key,obj];
        [params appendString:param];
    }];
    
    ///利用公钥rsa加密
    NSString *encryptStr = [RSAEncryptor encryptString:params publicKey:@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw4wPLOnPFTcA87drH3H+6mvmAE9ZfbVEf+R2p2l5IkppcB9ag4NygmUzqCThLbZRJHgWFd2HJfXXvS9NGV1twb3Yhuu7oUtKhusxmuQXGXOqrhkcm1cPoBQNiqqWUCEGtXaAL9Bdu/5ydPZglBBcXnNQHGtegWKxxwNhSowimckG8r7Up1J+FEXH4+odGRhBqQSfXa/pGwKk+DdlI92xmWMbgSlSYO0CWHpQiUWuPxe6OtmOjbH1gdZGyAtRECFRWXlpu5/j+4WFQoeYe+k0NyFveBsoxgx0qAmgqpLp4OZnEitC1ynTZC/iB1YThbTpIpURION1Mo3KHa2+9GeY8QIDAQAB"];
    NSLog(@"加密前:%@", params);
//    NSLog(@"加密后:%@", encryptStr);
    [m_dicNotRsaParameters setValue:encryptStr forKey:@"params"];
}

-(void)GetAsynchronous
{
    [self Cancel];
    m_pRequest = [m_pRequestManager GET:m_strUrl parameters:m_dicParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self RequestSucceedWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self RequestFailureWithError:error];
    }];
}

-(void)Cancel
{
    if(m_pRequest != nil)
        [m_pRequest cancel];
}

- (BOOL)proRequestRunning
{
    if (m_pRequest.state == NSURLSessionTaskStateRunning) {
        return YES;
    } else {
        return NO;
    }
}

- (void)RequestSucceedWithResponseObject:(id)responseObject
{
    
    
    
    if ([m_strRequestTag isEqualToString:@"getPayStatus"])
    {
        if (self.propDelegate && [self.propDelegate respondsToSelector:@selector(RequestSucceeded:withResponseData:)])
        {
            NSString *strStatus = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:@[strStatus]];
        }
    }
    else
    {
        NSData *serializedData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        id responseJSON = [NSJSONSerialization JSONObjectWithData:serializedData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@---%@-----%@", responseObject, m_strRequestTag,m_strUrl);
        m_pResponseData =[RMMapper objectWithClass:[BUBaseResponseData class] fromDictionary:responseJSON];
        
        if (m_pResponseData.status == 1002)
        {
            [AlertManager ShowRelutWithMessage:@"该账号在异地登录" Dismiss:nil];
        }
        else if (m_pResponseData.status == 1011)
        {

        }
        
        if(m_pResponseData.status > 0)
        {
            //[[BUShowErrorMsg GetInstance] ShowErrorMessage:m_pResponseData.errorMsg];
            if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestErrorHappened:withErrorMsg:)])
            {
                [self.propDelegate RequestErrorHappened:self withErrorMsg:[NSString stringWithFormat:@"%i",m_pResponseData.status]];
            }
        }
        else if([m_pResponseData class] == [BUBaseResponseData class])
        {
            NSArray* arrData =  [m_pResponseData ParseDataArray:self.propDataClass];
            if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
            {
                [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
            }
        }
        else
        {
            NSArray* arrData = [[NSArray alloc] initWithObjects:m_pResponseData, nil];
            if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
            {
                [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
            }
        }
    }
}

- (void)RequestFailureWithError:(NSError *)error
{
    if (error.code == -1009  || error.code == -1005 || error.code == -1003 || error.code == -1001)
    {
        [AlertManager ShowRelutWithMessage:@"网络异常，请检查网络后重试" Dismiss:nil];
    }
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestErrorHappened:withErrorMsg:)])
    {
        NSLog(@"%@--%@", self.propUrl, error);
        [self.propDelegate RequestErrorHappened:self withErrorMsg:@""];
    }
}

@end
