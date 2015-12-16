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

//三条线
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

-(void)setQuestionMode:(CYQuestionModel *)questionMode
{
    _questionMode =questionMode;
    self.labelA.text = questionMode.item1;
    self.labelB.text = questionMode.item2;

    if (questionMode.item3  == nil|| [questionMode.item3 isEqualToString:@""]) {
        self.optionC.hidden = YES;
        self.lineCD.hidden = YES;
        self.lineDX.hidden = YES;
    } else {
        self.optionC.hidden = NO;
        self.lineCD.hidden = NO;
        self.lineDX.hidden = NO;
        self.labelC.text = questionMode.item3;

    }

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


#pragma mark - 按钮事件
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            [self checkAnswerWithButon:self.btnA option:@"1" lable:self.labelA trueButton:self.buttonA];
        }
            break;
        case 2:
        {
            [self checkAnswerWithButon:self.btnB option:@"2" lable:self.labelB trueButton:self.buttonB];
        }

            break;
        case 3:
        {
            [self checkAnswerWithButon:self.btnC option:@"3" lable:self.labelC trueButton:self.buttonC];
        }

            break;
        case 4:
        {
            [self checkAnswerWithButon:self.btnD option:@"4" lable:self.labelD trueButton:self.buttonD];
        }

            break;

        default:
            break;
    }

    //刷新选项按钮的UI、文字的UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//    });
}
- (void)checkAnswerWithButon:(UIButton *)button option:(NSString *)option lable:(UILabel *)lable trueButton:(UIButton *)trueButton{

    BOOL isCorrect = NO;
    if ([self.questionMode.answer isEqualToString:option]) {
        lable.textColor = [UIColor greenColor];
        button.selected = YES;
        isCorrect = YES;
        if (isCorrect) {
            if ([self.delegate respondsToSelector:@selector(CYAnswerViewDidAnswerCorrectly:)]) {
                [self.delegate CYAnswerViewDidAnswerCorrectly:self];
            }
        }
    }else{
        lable.textColor = [UIColor redColor];
        [button setBackgroundImage: [UIImage imageNamed:@"Answer_wrong"] forState:UIControlStateNormal];
}


}

-(void)showCorrectAnswer
{



}


@end
