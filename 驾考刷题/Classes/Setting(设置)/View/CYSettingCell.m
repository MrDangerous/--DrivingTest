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
#import "CYSettingLabelItem.h"

@interface CYSettingCell()
/**
 *  箭头
 */
@property(nonatomic, strong)UIImageView *mArrow;
/**
 *  开关
 */
@property(nonatomic, strong)UISwitch *mSwitch;
/**
 *  Label
 */
@property(nonatomic, strong)UILabel *mLabel;
@end


@implementation CYSettingCell

-(UIImageView *)mArrow
{
    if (!_mArrow) {
        self.mArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _mArrow;
}
-(UISwitch *)mSwitch
{
    if (!_mSwitch) {
        self.mSwitch = [[UISwitch alloc]init];

        //监听事件
        [_mSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _mSwitch;
}
-(UILabel *)mLabel
{
    if (!_mLabel) {
        _mLabel = [[UILabel alloc] init];
        _mLabel.bounds = CGRectMake(0, 0, 80, 33);
        _mLabel.textAlignment = NSTextAlignmentRight;
        _mLabel.text = @"1次";
    }
    return _mLabel;
}

-(void)valueChange:(UISwitch *)mSwitch
{
    //把开关状态保存到偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:mSwitch.isOn forKey:self.item.title];
    [defaults synchronize];//保存同步
}

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
            self.imageView.image =[UIImage imageNamed:item.icon];
    }

    //设置箭头
    if ([item isKindOfClass:[CYSettingArrowItem class]]) {//箭头
        self.accessoryView = self.mArrow;

        //箭头可以选中
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if([item isKindOfClass:[CYSettingSwitchItem class]]){//开关
        //设置开关的状态
        self.mSwitch.on = [[NSUserDefaults standardUserDefaults]boolForKey:item.title];
        self.accessoryView = self.mSwitch;
        //开关不用选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if ([item isKindOfClass:[CYSettingLabelItem class]]){//右边添加一个label
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = self.mLabel;
    }
}
@end
