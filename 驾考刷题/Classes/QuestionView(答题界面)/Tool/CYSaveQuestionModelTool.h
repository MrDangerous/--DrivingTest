//
//  CYSaveQuestionModelTool.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/13.
//  Copyright © 2015年 john. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYQuestionFrame.h"
@interface CYSaveQuestionModelTool : NSObject
/**
 *  存储题目信息
 *
 *  @param questionModel 题目模型
 */
+(void)saveQuestionModel:(CYQuestionFrame *)modelFrame;
/**
 *  删除题目信息
 */
+ (void)deleteQuestionModel:(CYQuestionFrame *)modelFrame;
/**
 *  返回题目信息
 *
 *  @return 题目模型
 */
+(NSArray *)modelFrames;

@end
