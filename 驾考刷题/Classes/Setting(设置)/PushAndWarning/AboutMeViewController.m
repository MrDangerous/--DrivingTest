//
//  CYSettingViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "AboutMeViewController.h"
#import "CYSettingItem.h"
#import "CYSettingArrowItem.h"
#import "CYSettingSwitchItem.h"
#import "CYSettingCell.h"
#import "CYSettingGroup.h"


@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我";
    //初始化数据
    //第一组数据
    CYSettingItem *item1 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"我"];
    CYSettingItem *item2 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"是"];
    CYSettingItem *item3 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"火"];
    CYSettingItem *item4 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"车"];
    CYSettingItem *item5 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"王"];
    CYSettingGroup *group1 = [[CYSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4,item5];
    [self.cellData addObject:group1];
}


@end
