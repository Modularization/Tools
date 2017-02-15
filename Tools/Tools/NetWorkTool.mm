//
//  NetWork.m
//  MaZhan
//
//  Created by majianghai on 2017/1/5.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "NetWorkTool.h"
#import "DeviceTool.h"
#import "ProgressHUD.h"


@interface NetWorkTool ()
@property   (nonatomic, strong)       AFJSONRequestSerializer     *requestSerializer;
@property   (nonatomic, strong)       AFJSONResponseSerializer    *jsonResponseSerializer;
@property   (nonatomic, readwrite)    NSOperationQueue            *operationQueue;
@property   (nonatomic, strong)       AFSecurityPolicy            *securityPolicy;
@end

@implementation NetWorkTool

+ (instancetype)sharedNetwork
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


- (id)init
{
    if (self = [super init]) {
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [self.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
        [self.requestSerializer setValue:[DeviceTool idfa] forHTTPHeaderField:@"udid"];
        [self.requestSerializer setValue:[DeviceTool appVersion] forHTTPHeaderField:@"version"];
        
        self.jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        self.operationQueue = [[NSOperationQueue alloc]init];
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        self.jsonResponseSerializer.removesKeysWithNullValues  = NO;
        self.securityPolicy.allowInvalidCertificates           = YES;
        
    }
    
    return self;
}




#pragma mark - Methods
+ (NSString *)URLStringWithHost:(NSString *)host port:(NSString *)port path:(NSString *)path
{
    if (!host) {
        return nil;
    }
    NSString *str1 = port ? [NSString stringWithFormat:@":%@", port] : @"";
    NSString *str2 = path ? [NSString stringWithFormat:@"/%@", path] : @"";
    
    NSString *ret  = [NSString stringWithFormat:@"%@%@%@", host, str1, str2];
    return ret;
}



+ (void)getURL:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     showError:(BOOL)showError
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error,NSString *msg))failure
{
    [[netWorkTool operation:URLString
                method:@"GET"
            parameters:parameters
             showError:showError
           showLoading:NO
               success:success
               failure:failure
                handle:nil]
     run];
}


+(void)getURL:(NSString *)URLString
   parameters:(NSDictionary *)parameters
    showError:(BOOL)showError
      success:(void (^)(id))success
      failure:(void (^)(NSError *, NSString *))failure
       handle:(void (^)(id))handle {
    
    [[netWorkTool operation:URLString
                method:@"GET"
            parameters:parameters
             showError:showError
           showLoading:NO
               success:success
               failure:failure
                handle:handle]
     run];
}



- (AFHTTPRequestOperation *)operation:(NSString *)URLString
                               method:(NSString *)method
                           parameters:(NSDictionary *)parameters
                            showError:(BOOL)showError
                          showLoading:(BOOL)show
                              success:(void (^)(id result))success
                              failure:(void (^)(NSError *error,NSString *msg))failure
                               handle:(void (^)(id source))handle


{
    AFHTTPResponseSerializer *responseSerializer = nil;
    AFHTTPRequestOperation   *operation          = nil;
    NSError *error                               = nil;
    
    responseSerializer                           = _jsonResponseSerializer;
    responseSerializer.acceptableContentTypes    = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    if (show)
    {
        [[ProgressHUD shareHUD] showLoading];
    }
    
//    URLString = [NSString stringWithFormat:@"%@%@", HOST, URLString];
    NSMutableURLRequest *request = [_requestSerializer requestWithMethod:method
                                                               URLString:URLString
                                                              parameters:parameters
                                                                   error:&error];
    
    operation                    = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = responseSerializer;
    
//    TELog(@"request url -> %@",self.requestSerializer.HTTPRequestHeaders);
//    TELog(@"request url -> %@\n %@",URLString,parameters);
//    TELog(@"request url -> %@\n",request.URL.absoluteString);
    
    
    request.timeoutInterval = 8.0f;

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        if (success)
        {
            if (show)
            {
                [[ProgressHUD shareHUD] loadingFinish];
            }
            
            BOOL isFailure = NO;
            BOOL isHandle  = true;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                switch ([responseObject[@"code"] integerValue]) {
                    case 100: // 请求成功
                    {
                        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"TIME"]) {
                            [[NSUserDefaults standardUserDefaults] setObject:[responseObject[@"time"] stringValue] forKey:@"TIME"];
                        }
                        success (responseObject[@"data"]);
                        isHandle = false;
                    }
                        break;
                        
                    case 400: // 请求错误
                    {
                        if (showError) {
                            [[ProgressHUD shareHUD] showMessage:@"出问题了，请重新操作试试"];
                        }
                    }
                        break;
                        
                    default:
                        NSString *message = responseObject[@"message"];
                        if (message != nil && message.length > 0) {
                            [[ProgressHUD shareHUD] showMessage:message];
                        }
                        break;
                    
                }
                
                if (handle && isHandle) {
                    handle (responseObject);
                }
                else {
                    if (isFailure && failure) {
                        failure (nil,[NSString stringWithFormat:@"%@",responseObject]);
                    }
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (show) {
            [[ProgressHUD shareHUD] loadingFinish];
        }
        
        if (failure) {
            
            if (showError) {
                errorExected(operation.response.statusCode, error);
            };
            
            failure(error,error.localizedDescription);
        }
    }];
    
    return operation;
}



/// AFNetWork系统的code
inline void errorExected(NSInteger errorCode, NSError * error)
{
    NSString *message = @"";
    
    switch (errorCode) {
        case 404:
        case 400:
        case 403:
        case 405:
        case 408:
        {
            message = @"出问题了，请重新操作试试";
            [[ProgressHUD shareHUD] showMessage:message];
        }
            break;
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 505:
        {
            message = @"服务器错误！";
            [[ProgressHUD shareHUD] showMessage:message];
            
        }
            break;
            
        case 12002:
        {
            message = @"网络超时！";
            [[ProgressHUD shareHUD] showMessage:message];
            
        }
            break;
            
        default:
            break;
    }
    
    if (!errorCode && error) {
        //        [[UJPProgressHUD shareHUD] showMessage:error.userInfo[@"NSLocalizedDescription"]];
        [[ProgressHUD shareHUD] showMessage:@"您的网络不给力，请刷新重试"];
    }
}






@end






@implementation NSOperation (UJPExtension)

- (void)run
{
    [netWorkTool.operationQueue addOperation:self];
}

@end
