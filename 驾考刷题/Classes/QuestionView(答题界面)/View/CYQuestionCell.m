//
//  CYQuestionCell.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/12.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionCell.h"

@interface CYQuestionCell()

//题目及选项
@property (weak, nonatomic) IBOutlet UILabel *title;
//@property (weak, nonatomic) IBOutlet UILabel *A;
@property (weak, nonatomic) IBOutlet UILabel *B;
@property (weak, nonatomic) IBOutlet UILabel *C;
@property (weak, nonatomic) IBOutlet UILabel *D;

//小按钮，用于改变UI
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnD;

//选择大按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *buttonB;
@property (weak, nonatomic) IBOutlet UIButton *buttonC;
@property (weak, nonatomic) IBOutlet UIButton *buttonD;


@end

@implementation CYQuestionCell

- (void)awakeFromNib {
    // Initialization code
}

@end
