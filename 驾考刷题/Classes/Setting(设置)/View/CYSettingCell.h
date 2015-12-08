//
//  CYSettingCell.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYSettingItem;
@interface CYSettingCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  表格的数据模型
 */
@property(nonatomic, strong)CYSettingItem *item;
@end
