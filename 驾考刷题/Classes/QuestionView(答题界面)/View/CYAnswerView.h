//
//  CYAnswerView.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYAnswerView : UIView
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

@property (weak, nonatomic) IBOutlet UIView *optionC;
@property (weak, nonatomic) IBOutlet UIView *optionD;

@property (weak, nonatomic) IBOutlet UIView *lineBC;
@property (weak, nonatomic) IBOutlet UIView *lineCD;
@end
