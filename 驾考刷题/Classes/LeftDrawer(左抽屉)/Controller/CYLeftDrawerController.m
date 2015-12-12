//
//  CYLeftDrawerController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYLeftDrawerController.h"
#import "CYSettingCell.h"
#import "CYSettingArrowItem.h"
#import "CYSettingGroup.h"
@interface CYLeftDrawerController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *cellData;
@end

@implementation CYLeftDrawerController


-(NSMutableArray *)cellData
{
    if (!_cellData) {
        self.cellData = [[NSMutableArray alloc]init];
    }
    return _cellData;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    //去除状态栏
//    self.prefersStatusBarHidden = YES;

    //设置数据

    //初始化数据
    //第一组数据
    CYSettingItem *item1 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"消息中心"];
    CYSettingItem *item2 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"扫一扫"];
    CYSettingItem *item3 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"丢肥皂"];
    CYSettingItem *item4 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"我的题库"];
    CYSettingItem *item5 = [CYSettingArrowItem itemWithIcon:@"handShake" title:@"意见反馈"];
    CYSettingGroup *group1 = [[CYSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4,item5];
    [self.cellData addObject:group1];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 加载数据
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
    //设置cell样式
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:16];

    [cell addSubview:[self addDivideView]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

/** 添加分割线 */
- (UIView *)addDivideView {
    UIView *divide = [[UIView alloc] init];
    divide.frame = CGRectMake(0, 53, self.tableView.width, 1);
    divide.backgroundColor = [UIColor blackColor];
    return divide;
}

@end
