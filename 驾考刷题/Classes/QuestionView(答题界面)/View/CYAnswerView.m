//
//  CYAnswerView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYAnswerView.h"
#import "CYQuestionModel.h"
@interface CYAnswerView()
//A选项相关按钮
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *btnA;

@property (weak, nonatomic) IBOutlet UIButton *buttonB;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UILabel *labelB;

@property (weak, nonatomic) IBOutlet UIButton *buttonC;
@property (weak, nonatomic) IBOutlet UILabel *labelC;
@property (weak, nonatomic) IBOutlet UIButton *btnC;

@property (weak, nonatomic) IBOutlet UIButton *buttonD;
@property (weak, nonatomic) IBOutlet UILabel *labelD;
@property (weak, nonatomic) IBOutlet UIButton *btnD;

//用于判断题的时候删掉
@property (weak, nonatomic) IBOutlet UIView *optionC;
@property (weak, nonatomic) IBOutlet UIView *optionD;

//三条分割线
@property (weak, nonatomic) IBOutlet UIView *lineBC;
@property (weak, nonatomic) IBOutlet UIView *lineDX;
@property (weak, nonatomic) IBOutlet UIView *lineCD;

@end

@implementation CYAnswerView
-(instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CYAnswerView" owner:self options:nil]lastObject];

    }
    return self;
}

#pragma mark - 数据的初始化
/**
 *  传入数据模型，给控件一一赋值
 */
-(void)setQuestionMode:(CYQuestionModel *)questionMode
{
    _questionMode =questionMode;
    //每次拿到新的数据模型，就重新更新控件的显示情况
    [self setOriginState];

    self.labelA.text = questionMode.item1;
    self.labelB.text = questionMode.item2;
    //选项C,D需要特殊处理，因为为判断题时，返回值为空
    if (questionMode.item3  == nil|| [questionMode.item3 isEqualToString:@""]) {
        self.optionC.hidden = YES;
        //xib中的两条线
        self.lineCD.hidden = YES;
        self.lineDX.hidden = YES;
    } else {
        self.optionC.hidden = NO;
        self.lineCD.hidden = NO;
        self.lineDX.hidden = NO;
        self.labelC.text = questionMode.item3;
    }
    //选项C,D需要特殊处理，因为为判断题时，返回值为空
    if (questionMode.item4 == nil || [questionMode.item4 isEqualToString:@""]) {
        self.optionD.hidden = YES;
        self.lineCD.hidden = YES;
        self.lineDX.hidden = YES;
    } else {
        self.optionD.hidden = NO;
        self.lineCD.hidden = NO;
        self.lineDX.hidden = NO;
        self.labelD.text = questionMode.item4;
    }

}

/** 到下一个题目时，初始化各选项按钮的设置 */
- (void)setOriginState {
    // 将各个按钮设为可用
    [self setOriginStateWhenMultiSelect];
    // 单选的
    [self setOriginStateWhenSingleSelect];
}
/**
 *  按钮设为可用
 */
- (void)setOriginStateWhenMultiSelect {
    self.buttonA.enabled = YES;
    self.buttonB.enabled = YES;
    self.buttonC.enabled = YES;
    self.buttonD.enabled = YES;
}
/**
 *  重新设置各个选项的图片等信息
 */
- (void)setOriginStateWhenSingleSelect {
    [self setUpOptionButton:self.btnA image:@"Answer_A_1"];
    [self setUpOptionButton:self.btnB image:@"Answer_B_1"];
    [self setUpOptionButton:self.btnC image:@"Answer_C_1"];
    [self setUpOptionButton:self.btnD image:@"Answer_D_1"];
    self.labelA.textColor = [UIColor darkGrayColor];
    self.labelB.textColor = [UIColor darkGrayColor];
    self.labelC.textColor = [UIColor darkGrayColor];
    self.labelD.textColor = [UIColor darkGrayColor];
}

- (void)setUpOptionButton:(UIButton *)button image:(NSString *)image{
    button.selected = NO;
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

#pragma mark - 按钮事件
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:[self checkAnswerWithButon:self.btnA option:@"1" lable:self.labelA trueButton:self.buttonA];

            break;
        case 2:[self checkAnswerWithButon:self.btnB option:@"2" lable:self.labelB trueButton:self.buttonB];


            break;
        case 3:[self checkAnswerWithButon:self.btnC option:@"3" lable:self.labelC trueButton:self.buttonC];

            break;
        case 4:[self checkAnswerWithButon:self.btnD option:@"4" lable:self.labelD trueButton:self.buttonD];

            break;

        default:
            break;
    }
}
- (void)checkAnswerWithButon:(UIButton *)button option:(NSString *)option lable:(UILabel *)lable trueButton:(UIButton *)trueButton{
    /** 答题逻辑 */
    if ([self.questionMode.answer isEqualToString:option]) {//回答正确
        lable.textColor = [UIColor greenColor];
        button.selected = YES;
        //发出通知，告诉控制器回答正确，跳转下一题
        //这里需要异步处理因为用户可能在跳转途中做其他操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CYAnswerDidSelectCorrect" object:nil userInfo:nil];
        });
    }else{//回答错误
        lable.textColor = [UIColor redColor];
        [button setBackgroundImage: [UIImage imageNamed:@"Answer_wrong"] forState:UIControlStateNormal];
        //显示正确答案
        [self showCorrectAnswer];
    }
        //禁用按钮
        [self changeButtonEnableStateToNO];
}
/**
 *  移除通知
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

//显示正确答案
-(void)showCorrectAnswer
{
    // 1.将各个按钮设为可用
    [self setOriginStateWhenMultiSelect];
    // 2.配置答案数据
    if ([self.questionMode.answer isEqualToString:@"1"]) {
        self.labelA.textColor = [UIColor greenColor];
        self.btnA.selected = YES;
    }
    if ([self.questionMode.answer isEqualToString:@"2"]) {
        self.labelB.textColor = [UIColor greenColor];
        self.btnB.selected = YES;
    }
    if ([self.questionMode.answer isEqualToString:@"3"]) {
        self.labelC.textColor = [UIColor greenColor];
        self.btnC.selected = YES;
    }
    if ([self.questionMode.answer isEqualToString:@"4"]) {
        self.labelD.textColor = [UIColor greenColor];
        self.btnD.selected = YES;
    }

}
/** 禁止所有按钮的点击 */
- (void)changeButtonEnableStateToNO {
    self.buttonA.enabled = NO;
    self.buttonB.enabled = NO;
    self.buttonC.enabled = NO;
    self.buttonD.enabled = NO;
}
@end
