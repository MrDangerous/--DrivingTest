//
//  CYPopSelectView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/9.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYPopSelectView.h"

@interface CYPopSelectView()<UITableViewDataSource,UITableViewDelegate>

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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%d", (int)indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


@end
