//
//  WebCacheTool.m
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "WebCacheTool.h"

@implementation WebCacheTool
#pragma mark - h5的缓存相关
+ (NSString *)readFromWebCache:(NSString *)urlStr
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%u.html",(unsigned)[urlStr hash]]];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if (!(htmlString ==nil || [htmlString isEqualToString:@""])) {
        return htmlString;
    } else {
        return @"";
    }
}
+ (void)writeToWebCache:(NSString *)urlStr
{
    NSString * htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:Nil];
    //创建文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    //获取document路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"]withIntermediateDirectories:YES attributes:nil error:nil];
    
    //写入路径
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%u.html",(unsigned)[urlStr hash]]];
    
    [fileManager removeItemAtPath:path error:nil];
    
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
