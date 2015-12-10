//
//  CYEncourageMeController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYEncourageMeController.h"

@interface CYEncourageMeController ()

@end

@implementation CYEncourageMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"鼓励我";
}

- (IBAction)copyTitle:(UIButton *)sender {
    NSString *title = sender.tag == 1 ? @"736420282" : @"736420282@qq.com";
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = title;
}

@end
