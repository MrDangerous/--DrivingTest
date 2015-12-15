//
//  CYQuestionFrame.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//  一个QuestionFrame模型存放着一个cell的所有子控件的frame模型

#import <Foundation/Foundation.h>
@class CYQuestionModel;
@interface CYQuestionFrame : NSObject
@property(nonatomic, strong) CYQuestionModel *questionMode;
/** 滚动背景 */
@property(nonatomic, assign)CGRect scrollViewF;
/** 题干 */
@property(nonatomic, assign)CGRect titleLabelF;
/** 图片 */
@property(nonatomic, assign)CGRect questionImageF;
/** 选项 */
@property(nonatomic, assign)CGRect answerViewF;

/** cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

@end
