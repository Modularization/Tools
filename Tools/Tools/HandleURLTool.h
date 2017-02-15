//
//  URLTool.h
//  MaZhan
//
//  Created by majianghai on 2017/2/4.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleURLTool : NSObject
+ (NSDictionary *)handleURL:(NSURL *)url withUserId:(NSString *)uId;
@end
