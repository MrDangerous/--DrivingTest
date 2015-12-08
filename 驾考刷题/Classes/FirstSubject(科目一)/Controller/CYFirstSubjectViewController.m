//
//  CYFirstSubjectViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYFirstSubjectViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "CYLeftDrawerTableViewController.h"

@interface CYFirstSubjectViewController ()

@end

@implementation CYFirstSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
}
-(void)setupLeftMenuButton
{
    //创建按钮
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    //为navigationItem添加LeftBarButtonItem
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
-(void)leftDrawerButtonPress:(id)sender
{
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}

@end
