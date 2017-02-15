//
//  WebCacheTool.h
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebCacheTool : NSObject
/*** 网页读取缓存*/
+ (NSString *)readFromWebCache:(NSString *)urlStr;
/*** 网页缓存写入文件*/
+ (void)writeToWebCache:(NSString *)urlStr;
@end
