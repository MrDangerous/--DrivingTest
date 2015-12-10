//
//  CYLeftDrawerController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYLeftDrawerController.h"
#import "CYSettingCell.h"
@interface CYLeftDrawerController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSArray *cellData;
@end

@implementation CYLeftDrawerController

-(void)viewWillAppear:(BOOL)animated
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    //去除状态栏
    [self prefersStatusBarHidden];

}

-(NSArray *)cellData
{
    if (!_cellData) {
        self.cellData = [[NSArray alloc]init];
        self.cellData = @[@"消息中心",@"丢肥皂",@"扫一扫",@"我的题库",@"意见反馈"];
    }
    return _cellData;
}

#pragma mark - 加载数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYSettingCell *cell = [CYSettingCell cellWithTableView:tableView];
    //设置cell样式
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    //设置数据
    cell.textLabel.text = self.cellData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

@end
