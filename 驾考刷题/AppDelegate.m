//
//  AppDelegate.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import "AppDelegate.h"
#import "CYTabbarViewController.h"
#import "CYNavigationViewController.h"
#import "CYLeftDrawerController.h"
#import "MMDrawerController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    //2.设置根控制器

    //初始化左视图
    CYLeftDrawerController *leftTVC = [[CYLeftDrawerController alloc]init];
    CYNavigationViewController *leftNC = [[CYNavigationViewController alloc]initWithRootViewController:leftTVC];
    //    leftNC.view.backgroundColor = [UIColor redColor];
    CYTabbarViewController *tabarVc = [[CYTabbarViewController alloc] init];
    //初始化抽屉视图控制器
    MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabarVc leftDrawerViewController:leftNC];

    //设置抽屉抽出的宽度
    drawerController.maximumLeftDrawerWidth = 250;
    //滑动手势开关抽屉
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    self.window.rootViewController = drawerController;
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

@end
