//
//  CYAnswerView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/14.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYAnswerView.h"

@implementation CYAnswerView
-(instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CYAnswerView" owner:self options:nil]lastObject];

    }
    return self;
}

@end
