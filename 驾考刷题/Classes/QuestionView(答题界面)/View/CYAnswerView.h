//
//  CYAnswerView.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYQuestionModel;
@class CYAnswerView;
@protocol  CYAnswerViewDelegate <NSObject>

-(void)CYAnswerViewDidAnswerCorrectly:(CYAnswerView *)CYAnswerView;
@optional
-(void)CYAnswerViewDidAnswerWrong:(CYAnswerView *)CYAnswerView;

@end


@interface CYAnswerView : UIView
@property(nonatomic, strong)CYQuestionModel *questionMode;

@property(nonatomic, weak)id<CYAnswerViewDelegate> delegate;


@end
