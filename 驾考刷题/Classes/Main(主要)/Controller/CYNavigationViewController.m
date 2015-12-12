//
//  CYNavigationViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYNavigationViewController.h"
#import "CYLeftDrawerController.h"

@interface CYNavigationViewController ()

@end

@implementation CYNavigationViewController

+(void)initialize
{
    //设置整个项目所有的item样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

    //设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];

    //UIApplication设置状态栏的样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    //设置导航条标题的字体及颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    //设置导航条背景颜色
    CGFloat r = 55/255.0;
    CGFloat g = 189/255.0;
    CGFloat b = 243/255.0;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1];
    [navBar setBarTintColor:color];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/**
 *  拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(setting) image:@"Home_setting" highImage:nil];
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        // 统一更改导航栏返回按钮样式
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navi_back" highImage:@"navi_back"];

    }

    [super pushViewController:viewController animated:YES];
}

///** 设置 */
//- (void)setting {
//
//}
- (void)back {
    [self popViewControllerAnimated:YES];
}
/**
 *  设置状态栏样式
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
