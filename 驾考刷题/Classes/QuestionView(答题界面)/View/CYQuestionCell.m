//
//  CYQuestionCell.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionCell.h"
#import "CYQuestionFrame.h"
#import "UIImageView+WebCache.h"
#import "CYQuestionModel.h"
@interface CYQuestionCell()

/** 滚动背景 */
@property(nonatomic, strong)UIScrollView *scrollView;
/** 题干 */
@property(nonatomic, strong)UILabel *titleLabel;
/** 图片 */
@property(nonatomic, strong)UIImageView *questionImage;
/** 选项 */
@property(nonatomic, strong)CYAnswerView *answerView;
@end

@implementation CYQuestionCell;
/**
 *  cell的初始化方法，一个cell会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    /** 滚动背景 */
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    //        scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.scrollEnabled = YES;

    [self.contentView addSubview:scrollView];
    self.scrollView = scrollView;
    /** 题干 */
    UILabel *titleLabel = [[UILabel alloc]init];
    //        titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    /** 图片 */
    UIImageView *questionImage = [[UIImageView alloc]init];
    //        questionImage.backgroundColor = [UIColor grayColor];
    [scrollView addSubview:questionImage];
    self.questionImage = questionImage;
    /** 选项 */
    CYAnswerView *answerView = [[CYAnswerView alloc]init];
    //        answerView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:answerView];
    self.answerView = answerView;

}

-(void)setQuestionFrame:(CYQuestionFrame *)questionFrame
{
    _questionFrame = questionFrame;
    CYQuestionModel *questionMode = questionFrame.questionMode;
    /** 滚动背景 */
    self.scrollView.frame = questionFrame.scrollViewF;

    /** 题干 */
    self.titleLabel.frame = questionFrame.titleLabelF;
    self.titleLabel.text = questionMode.question;


    /** 图片 */
    self.questionImage.frame = questionFrame.questionImageF;
    [self.questionImage sd_setImageWithURL:[NSURL URLWithString:questionMode.url] placeholderImage:nil];
    /** 选项 */
    self.answerView.frame = questionFrame.answerViewF;
    self.answerView.questionMode = questionMode;

    CYLog(@"答案是--------------第%@个选项",questionMode.answer);
}

@end
