//
//  Utils.h
//  MaZhan
//
//  Created by majianghai on 2017/1/5.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ControllerTool : NSObject

/**
 *  @author 马江海
 *
 *  获取当前的导航控制器
 */
+ (UINavigationController *)setupNavController;
/**
 *  @author 马江海
 *
 *  获取当前的tabBarController
 */
+ (UITabBarController *)setupTabBarController;
/**
 *  @author 马江海
 *
 *  获取当前显示的控制器
 */
+ (UIViewController *)getCurrentVC;



/**
 切换导航控制器的根控制器
 */
+ (void)changeRootViewController:(UIViewController *)viewController;



@end
