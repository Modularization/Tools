//
//  ValidateTool.m
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "ValidateTool.h"

@implementation ValidateTool

+ (BOOL)validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^(1)[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
@end
