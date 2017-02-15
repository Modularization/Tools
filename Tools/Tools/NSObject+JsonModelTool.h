//
//  NSObject+JsonModelTool.h
//  MaZhan
//
//  Created by majianghai on 2017/1/10.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>


@interface NSObject (JsonModelTool)

+ (instancetype)modelWithJSON:(id)json;
@end
