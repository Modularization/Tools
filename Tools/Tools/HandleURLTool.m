//
//  URLTool.m
//  MaZhan
//
//  Created by majianghai on 2017/2/4.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "HandleURLTool.h"

@implementation HandleURLTool

+ (NSDictionary *)handleURL:(NSURL *)url withUserId:(NSString *)uId
{
    BOOL needRefresh = NO;
    NSString *urlStr = url.absoluteString;
    if (uId != nil && uId.length > 0) { // 本地登录了
        NSString *paramsStr = url.query;
        NSArray *array = [paramsStr componentsSeparatedByString:@"&"];
        NSString * h5UserId = nil;
        for (NSString *str in array) {
            
            NSRange userIdRange = [str rangeOfString:@"userId="];//匹配得到的下标
            if (userIdRange.location != NSNotFound) {
                
                h5UserId = [str substringWithRange:NSMakeRange(userIdRange.length, str.length - userIdRange.length)];
            }
        }
        
        if ([uId isEqualToString:h5UserId] == NO) { // 登录后h5的userId和本地的userId不相同
            NSString *replaceUserId = [NSString stringWithFormat:@"userId=%@", uId];
            urlStr = [urlStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"userId=%@", h5UserId] withString:replaceUserId options:0 range:NSMakeRange(0, urlStr.length)];
            needRefresh = YES;
        }
    } else { // 本地没有登录
        urlStr = [NSString stringWithFormat:@"%@0&src=ios",url.absoluteString];
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"url"] = urlStr;
    dict[@"needRefresh"] = [NSNumber numberWithBool:needRefresh];
    
    return dict;
}
@end
