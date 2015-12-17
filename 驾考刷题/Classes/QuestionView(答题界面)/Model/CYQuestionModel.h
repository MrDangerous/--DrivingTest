//
//  CYQuestionModel.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/12.
//  Copyright © 2015年 john. All rights reserved.
//  题目模型

#import <Foundation/Foundation.h>

@interface CYQuestionModel : NSObject
/** 题目号*/
@property(nonatomic, assign,getter=idstr)NSInteger id;
/** 题干*/
@property(nonatomic, copy)NSString *question;
/** 选项数*/
@property(nonatomic, copy)NSString *answer;
/** 第一个选项*/
@property(nonatomic, copy)NSString *item1;
/** 第二个选项*/
@property(nonatomic, copy)NSString *item2;
/** 第三个选项*/
@property(nonatomic, copy)NSString *item3;
/** 第四个选项*/
@property(nonatomic, copy)NSString *item4;
/** 解释*/
@property(nonatomic, copy)NSString *explains;
/** 图片链接*/
@property(nonatomic, copy)NSString *url;

/** 是否被收藏 */
@property (nonatomic, assign) BOOL isCollection;


+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
