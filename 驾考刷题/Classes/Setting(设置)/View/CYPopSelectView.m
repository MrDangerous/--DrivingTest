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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    switch (indexPath.row) {
            case 0: cell.textLabel.text = @"不移除";
                break;
            case 1: cell.textLabel.text = @"1次";
                break;
            case 2: cell.textLabel.text = @"2次";
                break;
            case 3: cell.textLabel.text = @"3次";
                break;
            case 4: cell.textLabel.text = @"4次";
                break;
            case 5: cell.textLabel.text = @"5次";
                break;
            case 6: cell.textLabel.text = @"6次";
                break;
                
            default:
                break;
        }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{


}


#pragma mark 按钮的单击事件
- (IBAction)btnClick:(id)sender {

}
@end
