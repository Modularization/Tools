//
//  ValidateTool.h
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateTool : NSObject
/**
 *  @author 马江海
 *
 *  判断输入的手机号是否符合要求
 *
 *  @return 返回是或否
 */
+ (BOOL)validateMobile:(NSString *)mobile;
@end
