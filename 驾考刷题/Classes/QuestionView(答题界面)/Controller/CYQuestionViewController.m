//
//  CYQuestionViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/11.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionViewController.h"
#import "CYJumpCell.h"
#import "CYJumpToCollectionView.h"
@interface CYQuestionViewController ()
@end

@implementation CYQuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;

}


- (IBAction)jumpToCollectionview:(id)sender {

    CYJumpToCollectionView *popView = [[CYJumpToCollectionView alloc]init];
    //设置popView的尺寸
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    CGFloat popViewX = 0;
    CGFloat popViewY = 64;
    CGFloat popViewW = viewW - popViewX;
    CGFloat popViewH = viewH - popViewY;

    popView.frame = CGRectMake(popViewX, popViewY, popViewW, popViewH);
    //把自定义view加到self.view中
    [self.view addSubview:popView];

}


@end
