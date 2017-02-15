//
//  DeviceTool.m
//  MaZhan
//
//  Created by majianghai on 2017/1/16.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "DeviceTool.h"
#import <AdSupport/AdSupport.h>

@implementation DeviceTool

+(NSString *)idfa
{
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
    
    //for no arc
    //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
    //for arc
    ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
    
    if (asIM == nil) {
        return @"";
    }
    else{
        
        if(asIM.advertisingTrackingEnabled){
            return [asIM.advertisingIdentifier UUIDString];
        }
        else{
            return [asIM.advertisingIdentifier UUIDString];
        }
    }
}



+(NSString *)appVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleVersion"];
    return version;
}

@end
