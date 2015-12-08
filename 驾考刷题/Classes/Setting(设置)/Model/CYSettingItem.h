//
//  CYSettingItem.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  定义一个block,无返回值也无参数
 */
typedef void (^OperationBlock)();

@interface CYSettingItem : NSObject
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;
/**
 *  控制器的类型
 */
@property(nonatomic, copy)Class vcClass;
/**
 *  存储一个特殊的Block 操作 block使用copy
 */
@property(nonatomic, copy)OperationBlock operation;
-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass;


@end
