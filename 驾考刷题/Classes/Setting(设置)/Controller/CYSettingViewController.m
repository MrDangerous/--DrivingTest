//
//  CYSettingViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSettingViewController.h"
#import "CYSettingItem.h"

@interface CYSettingViewController ()
/**
 *  表格数据，里面存储数组
 */
@property(nonatomic, strong)NSMutableArray *cellData;
@end

@implementation CYSettingViewController
-(NSMutableArray *)cellData
{
    if (!_cellData) {
        self.cellData = [[NSMutableArray alloc]init];
    }
    return _cellData;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化数据
    //第一组数据
    CYSettingItem *item1 = [CYSettingItem itemWithIcon:@"handSake" title:@"提醒和推送"];
    CYSettingItem *item2 = [CYSettingItem itemWithIcon:@"handSake" title:@"我"];
    CYSettingItem *item3 = [CYSettingItem itemWithIcon:@"handSake" title:@"提醒"];
    NSArray *group1 = @[item1,item2,item3];
    [self.cellData addObject:group1];
    //显示数据

    CYSettingItem *item4 = [CYSettingItem itemWithIcon:@"handSake" title:@"提送"];
    CYSettingItem *item5 = [CYSettingItem itemWithIcon:@"handSake" title:@"提推送"];
    CYSettingItem *item6 = [CYSettingItem itemWithIcon:@"handSake" title:@"推送"];
    CYSettingItem *item7 = [CYSettingItem itemWithIcon:@"handSake" title:@"送"];
    CYSettingItem *item8 = [CYSettingItem itemWithIcon:@"handSake" title:@"推送"];
    CYSettingItem *item9 = [CYSettingItem itemWithIcon:@"handSake" title:@"提醒"];
    NSArray *group2 = @[item4,item5,item6,item7,item8,item9];
    [self.cellData addObject:group2];
}


#pragma mark - 组的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellData.count;
}
#pragma mark - 组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    NSArray *group = self.cellData[section];
    return group.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"SettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //获取模型显示数据
    NSArray *group = self.cellData[indexPath.section];
    CYSettingItem *item = group[indexPath.row];

    //显示图片和标题
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.icon];


    return cell;
}



@end
