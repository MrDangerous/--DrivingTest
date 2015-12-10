//
//  CYSecondSubjectController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSecondSubjectController.h"
#import "CYSecondSubjectController.h"
#import "CYHeaderView.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "CYLeftDrawerController.h"
#import "CYSettingViewController.h"
@interface CYSecondSubjectController ()

@end

@implementation CYSecondSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
    //加载xib
    CYHeaderView *headerView = [CYHeaderView headerView];
    self.tableView.tableHeaderView = headerView;

    //初始化数据
    //第一组数据
    CYSettingItem *item1 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"我"];
    CYSettingItem *item2 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"没"];
    CYSettingItem *item3 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"有"];
    CYSettingItem *item4 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"资"];
    CYSettingItem *item5 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"源"];
    CYSettingGroup *group1 = [[CYSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4,item5];
    [self.cellData addObject:group1];

}
-(void)setupLeftMenuButton
{
    //创建按钮
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    //为navigationItem添加LeftBarButtonItem
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(setting) image:@"Home_setting" highImage:nil];
}
-(void)leftDrawerButtonPress:(id)sender
{
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}
/** 设置 */
- (void)setting {
    //进入设置的控制器
    CYSettingViewController *settingVc = [[CYSettingViewController alloc]init];

    [self.navigationController pushViewController:settingVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}


@end
