//
//  CYQuestionModel.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/12.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionModel.h"
#import "MJExtension.h"
@implementation CYQuestionModel
/**
 *  给题目加题号
 */
-(void)setQuestion:(NSString *)question
{
    _question =[NSString stringWithFormat:@"%ld.%@",(long)self.id,question];

}

@end
