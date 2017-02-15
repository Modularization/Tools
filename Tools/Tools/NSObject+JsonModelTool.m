//
//  NSObject+JsonModelTool.m
//  MaZhan
//
//  Created by majianghai on 2017/1/10.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "NSObject+JsonModelTool.h"

@implementation NSObject (JsonModelTool)
+ (instancetype)modelWithJSON:(id)json
{
    return [self yy_modelWithJSON:json];
}
@end
