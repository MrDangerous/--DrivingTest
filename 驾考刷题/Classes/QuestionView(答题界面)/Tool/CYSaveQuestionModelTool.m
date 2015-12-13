//
//  CYSaveQuestionModelTool.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/13.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSaveQuestionModelTool.h"
#import "CYQuestionModel.h"
#define QuestionModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"questionModel.archive"]
@implementation CYSaveQuestionModelTool
+(void)saveQuestionModel:(CYQuestionModel *)questionModel
{
    //自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法

    [NSKeyedArchiver archiveRootObject:questionModel toFile:QuestionModelPath];

}

+(CYQuestionModel *)questionModel
{
    //加载模型
    CYQuestionModel *questionModel = [NSKeyedUnarchiver unarchiveObjectWithFile:QuestionModelPath];
    
    return questionModel;
}
@end
