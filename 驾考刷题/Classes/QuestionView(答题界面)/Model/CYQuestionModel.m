//
//  CYQuestionModel.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/12.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionModel.h"

@implementation CYQuestionModel
+(instancetype)questionModelWithDict:(NSDictionary *)dict
{
    CYQuestionModel *model = [[CYQuestionModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
