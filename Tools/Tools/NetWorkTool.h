//
//  NetWork.h
//  MaZhan
//
//  Created by majianghai on 2017/1/5.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


#define netWorkTool [NetWorkTool sharedNetwork]

@interface NetWorkTool : NSObject


/**
 请求网络工具的单例

 @return 请求网络工具的单例
 */
+ (instancetype)sharedNetwork;


/**
 *  合成 URL String 的方法。
 *
 *  @param host URL 的 host 字段，不能为 nil
 *  @param port URL 的 port，可为 nil
 *  @param path URL 的 path 字段
 *
 *  @return 将3个字段合成为一个完整的 URL 字符串。
 */
+ (NSString *)URLStringWithHost:(NSString *)host port:(NSString *)port path:(NSString *)path;


/**
 生成 GET 请求
 
 @param URLString  请求的URL
 @param parameters 请求参数字典
 @param showError  是否呈现给用户错误信息和加载状
 @param success    请求成功后回调block
 @param failure    请求失败后回调block
 */
+ (void)getURL:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     showError:(BOOL)showError
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error,NSString *msg))failure;



+ (void)getURL:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     showError:(BOOL)showError
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error,NSString *msg))failure
        handle:(void (^)(id source))handle;


















@end


@interface NSOperation (Extension)

- (void)run;

@end
