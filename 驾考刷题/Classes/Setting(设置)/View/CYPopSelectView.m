//
//  CYPopSelectView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/9.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYPopSelectView.h"

@interface CYPopSelectView()<UITableViewDataSource,UITableViewDelegate>
/**
 *  取消按钮单击事件
 */
- (IBAction)btnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSArray *cellData;
@end

@implementation CYPopSelectView

-(void)awakeFromNib
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CYPopSelectView" owner:self options:nil]lastObject];

    }
    return self;
}
-(NSArray *)cellData
{
    if (!_cellData) {
        self.cellData = [[NSArray alloc]init];
        self.cellData = @[@"不移除",@"1次",@"2次",@"3次",@"4次",@"5次",@"6次"];
    }
    return _cellData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    //设置数据
    cell.textLabel.text = self.cellData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(popSelectView:didFinshedChangeCellData:)]) {
        [self.delegate popSelectView:self didFinshedChangeCellData:self.cellData[indexPath.row]];
    }

}


#pragma mark 按钮的单击事件
- (IBAction)btnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(popSelectView:)]) {
        [self.delegate popSelectView:self];
    }
}
@end
