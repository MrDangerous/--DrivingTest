//
//  CYTabbarViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYTabbarViewController.h"
#import "CYFirstSubjectViewController.h"
#import "CYSecondSubjectTableViewController.h"
#import "CYThirdSubjectTableViewController.h"
#import "CYForthSubjectViewController.h"
#import "CYNavigationViewController.h"
#import "CYTabBar.h"
@interface CYTabbarViewController ()

@end

@implementation CYTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.初始化子控制器
    CYFirstSubjectViewController *firstSubject = [[CYFirstSubjectViewController alloc]init];
    firstSubject.view.backgroundColor = CYRandomColor;
    [self addChildVc:firstSubject title:@"科目一" image:@"home_icon_1" selectedImage:@"home_icon_1"];

    CYSecondSubjectTableViewController *secondSubject = [[CYSecondSubjectTableViewController alloc]init];
      secondSubject.view.backgroundColor = CYRandomColor;
    [self addChildVc:secondSubject title:@"科目二" image:@"home_icon_2" selectedImage:@"home_icon_2"];

    CYThirdSubjectTableViewController *thirdSubject = [[CYThirdSubjectTableViewController alloc]init];
      thirdSubject.view.backgroundColor = CYRandomColor;
    [self addChildVc:thirdSubject title:@"科目三" image:@"home_icon_3" selectedImage:@"home_icon_3"];

    CYForthSubjectViewController *forthSubject = [[CYForthSubjectViewController alloc]init];
      forthSubject.view.backgroundColor = CYRandomColor;
    [self addChildVc:forthSubject title:@"科目四" image:@"home_icon_4" selectedImage:@"home_icon_4"];

    //更换系统自带的tabbar
}





-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置控制器的文字
    childVc.title = title;//设置tabbar的文字

    //设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = CYColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

    //先给外面传进来的小控制器 包装一个导航控制器
    CYNavigationViewController *nav = [[CYNavigationViewController alloc]initWithRootViewController:childVc];

    //添加为子控制器
    [self addChildViewController:nav];

}

@end
