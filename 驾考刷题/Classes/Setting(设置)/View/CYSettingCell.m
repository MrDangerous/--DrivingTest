//
//  CYSettingCell.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSettingCell.h"
#import "CYSettingItem.h"
#import "CYSettingArrowItem.h"
#import "CYSettingSwitchItem.h"
@implementation CYSettingCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SettingCell";
    CYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CYSettingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)setItem:(CYSettingItem *)item
{
    _item = item;

    //显示图片和标题
    self.textLabel.text = item.title;
    if (item.icon) {
            self.imageView.image = [UIImage imageNamed:item.icon];
    }

    //设置箭头
    if ([item isKindOfClass:[CYSettingArrowItem class]]) {//开关
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }else if([item isKindOfClass:[CYSettingSwitchItem class]]){//箭头
        self.accessoryView = [[UISwitch alloc]init];
    }
}
@end
