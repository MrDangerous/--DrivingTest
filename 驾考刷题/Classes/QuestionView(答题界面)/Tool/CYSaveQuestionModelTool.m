//
//  CYSaveQuestionModelTool.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/13.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSaveQuestionModelTool.h"
#import "CYQuestionFrame.h"
#import "CYQuestionModel.h"
//收藏表情的存储路径
#define ModelFramePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"modelFrame.archive"]
@implementation CYSaveQuestionModelTool

static NSMutableArray *_modelFrames;
/**
 *  类方法，只会调用一次
 */
+ (void)initialize
{
    _modelFrames = [NSKeyedUnarchiver unarchiveObjectWithFile:ModelFramePath];
    if (_modelFrames == nil) {
        _modelFrames = [NSMutableArray array];
    }

}


+ (void)saveQuestionModel:(CYQuestionFrame *)modelFrame
{
    //删除重复的题目
    for (CYQuestionFrame *f in _modelFrames) {
        if (f.questionMode.idstr == modelFrame.questionMode.idstr) {
            [_modelFrames removeObject:f];
            break;
        }
    }
    //将题目模型放在数组的最前面
    [_modelFrames insertObject:modelFrame atIndex:0];
    //将所有题目数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_modelFrames toFile:ModelFramePath];

}

+ (void)deleteQuestionModel:(CYQuestionFrame *)modelFrame
{
    //删除重复的题目
    for (CYQuestionFrame *f in _modelFrames) {
        if (f.questionMode.idstr == modelFrame.questionMode.idstr) {
            [_modelFrames removeObject:f];
            break;
        }
    }
    //将所有题目数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_modelFrames toFile:ModelFramePath];
}

/**
 *  返回装着的模型题目
 */
+ (NSArray *)modelFrames
{
    return _modelFrames;
}
@end
