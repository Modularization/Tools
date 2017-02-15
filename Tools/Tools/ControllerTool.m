//
//  Utils.m
//  MaZhan
//
//  Created by majianghai on 2017/1/5.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "ControllerTool.h"


@implementation ControllerTool

#pragma mark - 获得tabBarController、setupTabBarController、当前控制器
+ (UINavigationController *)setupNavController
{
    UITabBarController *tabBarController  = (UITabBarController *)[self getCurrentVC];
    return tabBarController.selectedViewController;
}

+ (UITabBarController *)setupTabBarController
{
    UITabBarController *tabBarController  = (UITabBarController *)[self getCurrentVC];
    return tabBarController;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



+ (void)changeRootViewController:(UIViewController *)viewController
{
    UINavigationController *navController = [ControllerTool setupTabBarController].viewControllers.lastObject;
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:viewController];
    [navController setViewControllers:tempArray];
}



@end
