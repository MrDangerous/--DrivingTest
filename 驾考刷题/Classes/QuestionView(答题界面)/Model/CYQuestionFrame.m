//
//  CYQuestionFrame.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionFrame.h"
#import "CYQuestionModel.h"
#import "NSString+Extension.h"
#define QuestionCellBorderW 10

@implementation CYQuestionFrame
-(void)setQuestionMode:(CYQuestionModel *)questionMode
{
    _questionMode = questionMode;

    /** 题干 */
    CGFloat maxW = __kScreenWidth;
    CGSize titleSize = [questionMode.question sizeWithFont:[UIFont systemFontOfSize:15]maxW:maxW];
    self.titleLabelF = (CGRect){{0, 0}, titleSize};

    /** 图片 */
    if (questionMode.url == nil || [questionMode.url isEqualToString:@""]) {
             self.questionImageF = CGRectMake(0, -1, 0, 0);
    } else {
        CGFloat imageX = QuestionCellBorderW;
        CGFloat imageY = CGRectGetMaxY(self.titleLabelF) + QuestionCellBorderW;
        CGFloat imageW = __kScreenWidth - 2 * QuestionCellBorderW;
        CGFloat imageH = 150;
        self.questionImageF = CGRectMake(imageX, imageY, imageW, imageH);
    }

    /** 选项 */
        CGFloat answerX = QuestionCellBorderW;
        CGFloat answerY =  MAX(CGRectGetMaxY(self.titleLabelF), CGRectGetMaxY(self.questionImageF)) + QuestionCellBorderW;
        CGFloat answerW = __kScreenWidth - 2 * QuestionCellBorderW;
        CGFloat answerH = 184;
        self.answerViewF = CGRectMake(answerX, answerY, answerW, answerH);


    /** 滚动背景 */
    CGFloat scrollW = __kScreenWidth;
    CGFloat scrollH = CGRectGetMaxY(self.answerViewF);
    self.scrollViewF = CGRectMake(0, 0, scrollW, scrollH);

}
@end
