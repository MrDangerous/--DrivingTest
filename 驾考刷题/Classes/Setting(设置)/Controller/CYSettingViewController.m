//
//  CYSettingViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSettingViewController.h"
#import "CYSettingItem.h"
#import "CYSettingArrowItem.h"
#import "CYSettingSwitchItem.h"
#import "CYSettingCell.h"
#import "TestViewController.h"
#import "MBProgressHUD+MJ.h"
#import "CYSettingGroup.h"
#import "AboutMeViewController.h"

@implementation CYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    //初始化数据
    //第一组数据
    CYSettingItem *item1 = [CYSettingSwitchItem itemWithIcon:@"handShake" title:@"是否自动跳转下一题"];
    CYSettingItem *item2 = [CYSettingSwitchItem itemWithIcon:@"handShake" title:@"是否默认展开解释"];
    CYSettingItem *item3 = [CYSettingSwitchItem itemWithIcon:@"handShake" title:@"是否开启声音"];
    CYSettingItem *item4 = [CYSettingSwitchItem itemWithIcon:@"handShake" title:@"是否切换夜间模式"];
    CYSettingGroup *group1 = [[CYSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4];
    [self.cellData addObject:group1];
    //显示数据

    CYSettingItem *item5 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"关于我" vcClass:[AboutMeViewController class]];
    CYSettingItem *item6 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"鼓励我"];
    CYSettingItem *item7 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"检查版本更新"];
    //版本更新是一个特殊的操作，把这个操作存放在block属性中
    item7.operation = ^(){
        NSLog(@"正在检查版本更新");
        //给一个假象
        [MBProgressHUD showMessage:@"正在检查版本更新中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"当前已经是最新版本"];
        });
    };

    CYSettingGroup *group2 = [[CYSettingGroup alloc] init];
    group2.items = @[item5,item6,item7];
    [self.cellData addObject:group2];
}


@end
