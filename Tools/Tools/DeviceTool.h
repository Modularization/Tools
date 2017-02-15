//
//  DeviceTool.h
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceTool : NSObject

/**
 获取用户的idfa唯一标识

 @return 返回idfa唯一标识
 */
+(NSString *)idfa;


/**
 获取app的版本号

 @return 返回app的版本号
 */
+(NSString *)appVersion;
@end
