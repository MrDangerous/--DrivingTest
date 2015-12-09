//
//  CYSettingViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSettingViewController.h"
#import "CYSettingCell.h"
#import "MBProgressHUD+MJ.h"
#import "AboutMeViewController.h"
#import "CYEncourageController.h"
#import "CYProductShareViewController.h"
#import "CYPopSelectView.h"
#import "CYSettingLabelItem.h"
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
    CYSettingItem *item6 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"鼓励我"vcClass:[CYEncourageController class]];
    CYSettingItem *item7 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"检查版本更新"];
    //版本更新是一个特殊的操作，把这个操作存放在block属性中
    item7.operation = ^(){
        //给一个假象
        [MBProgressHUD showMessage:@"正在检查版本更新中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"当前已经是最新版本"];
        });
    };
    CYSettingItem *item8 = [CYSettingArrowItem itemWithIcon:@"MoreHelp" title:@"产品推荐" vcClass:[CYProductShareViewController class]];
    CYSettingItem *item9 = [CYSettingLabelItem itemWithIcon:@"MoreHelp" title:@"答错题后自动移除"];
    item9.operation = ^(){
        //创建大小与self.view一样的按钮，把按钮作为一个阴影
        UIButton *btnCover = [[UIButton alloc]init];
        //设置按钮大小
        btnCover.frame = self.view.bounds;
        //设置按钮的背景色
        btnCover.backgroundColor = [UIColor blackColor];
        //设置按钮的透明度
        btnCover.alpha = 0.6;

        //把按钮加到self.view中
        [self.view addSubview:btnCover];

        CYPopSelectView *popView = [[CYPopSelectView alloc]init];
        //设置popView的尺寸
        CGFloat viewW = self.view.frame.size.width;
        CGFloat viewH = self.view.frame.size.height;
        CGFloat popViewW = 200;
        CGFloat popViewH = 300;
        CGFloat popViewX = (viewW - popViewW) * 0.5;
        CGFloat popViewY = (viewH - popViewH) * 0.5;
        popView.frame = CGRectMake(popViewX, popViewY, popViewW, popViewH);
    };

    
    CYSettingGroup *group2 = [[CYSettingGroup alloc] init];
    group2.items = @[item5,item6,item7,item8,item9];
    [self.cellData addObject:group2];
}


@end
