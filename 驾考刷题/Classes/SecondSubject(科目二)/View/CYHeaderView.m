//
//  CYHeaderView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYHeaderView.h"

@interface CYHeaderView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end


@implementation CYHeaderView

+(instancetype)headerView
{
    CYHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"CYHeadView" owner:nil options:nil]lastObject];
    return headerView;
}

@end
