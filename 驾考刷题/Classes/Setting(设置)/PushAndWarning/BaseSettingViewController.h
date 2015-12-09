//
//  BaseSettingViewController.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYSettingItem.h"
#import "CYSettingArrowItem.h"
#import "CYSettingSwitchItem.h"
#import "CYSettingGroup.h"
#import "CYSettingLabelItem.h"
@interface BaseSettingViewController : UITableViewController
/**
 *  表格数据，里面存储数组
 */
@property(nonatomic, strong)NSMutableArray *cellData;
@end
