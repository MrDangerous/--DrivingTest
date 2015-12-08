//
//  CYSettingViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "BaseSettingViewController.h"
#import "CYSettingCell.h"
#import "MBProgressHUD+MJ.h"
#import "AboutMeViewController.h"
@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController
/**
 *  只要调用init 方法，就返回组样式表格
 */
-(instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {

    }
    return self;
}

-(NSMutableArray *)cellData
{
    if (!_cellData) {
        self.cellData = [[NSMutableArray alloc]init];
    }
    return _cellData;
}
-(void)viewDidLoad
{
    [super viewDidLoad];

    //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];

}


#pragma mark - 组的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellData.count;
}
#pragma mark - 组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    CYSettingGroup *group = self.cellData[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYSettingCell *cell = [CYSettingCell cellWithTableView:tableView];

    //获取组的数据模型
    CYSettingGroup *group = self.cellData[indexPath.section];

    //获取行的数据模型
    CYSettingItem *item = group.items[indexPath.row];

    //设置模型 显示数据
    cell.item = item;
    return cell;
}
#pragma mark - cell的点中
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型里的vcClass[控制器类型]
    //获取组的数据模型
    CYSettingGroup *group = self.cellData[indexPath.section];

    //获取行的数据模型
    CYSettingItem *item = group.items[indexPath.row];

    //判断是否有特殊的操作
    if (item.operation) {
        //有特殊的操作，operation有值，然后调用
        item.operation();
    }else if(item.vcClass) {
        //创建控制器再显示
        id vc = [[item.vcClass alloc]init];
        //设置下一个控制器的标题
        [vc setTitle:item.title];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark 头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //获取组模型
    CYSettingGroup *group = self.cellData[section];
    return group.headerTitle;

}

#pragma mark 尾部标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    //获取组模型
    CYSettingGroup *group = self.cellData[section];
    return group.footerTitle;
}
@end
