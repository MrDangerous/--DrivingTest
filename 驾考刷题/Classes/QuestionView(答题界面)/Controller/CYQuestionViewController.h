//
//  CYQuestionViewController.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/11.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYQuestionViewController : UIViewController

/**
 *  题目数组（里面放的都是CYQuestionFrame数组，一个数组就代表一道题目）,这些题目数组的来源是不一定的所以要放在这里给按钮提供接口
 */
@property (nonatomic, strong) NSArray *questionFrames;

@end
