//
//  CYSettingGroup.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYSettingGroup : NSObject
/**
 *  组的头部标题
 */
@property(nonatomic,copy)NSString *headerTitle;

/**
 *  组的尾部标题
 */
@property(nonatomic,copy)NSString *footerTitle;
/**
 *  组的每一行数据模型
 */
@property(nonatomic, strong)NSArray *items;
@end
