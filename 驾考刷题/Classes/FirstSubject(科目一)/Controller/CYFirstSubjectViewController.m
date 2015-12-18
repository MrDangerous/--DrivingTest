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
#import "CYLeftDrawerController.h"
#import "CYSettingViewController.h"
#import "CYQuestionViewController.h"
#import "AFNetworking.h"
#import "CYQuestionFrame.h"
#import "CYQuestionModel.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "CYSaveQuestionModelTool.h"
@interface CYFirstSubjectViewController ()<UIScrollViewDelegate>

//滚动图片2个控件
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/**
 *  图片滚动定时器
 */
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation CYFirstSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置左边抽屉
    [self setupLeftMenuButton];
    //设置右边设置
    [self setRightBarButton];
    //设置滚动图片
    [self setSCrollImage];
}
/**
 *  滚动图片实现
 */
-(void)setSCrollImage
{
    CGFloat imgW = 320;
    CGFloat imgH = 130;
    CGFloat imgY = 0;
    //动态创建UIImageView添加到UIScollView中
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *imgName = [NSString stringWithFormat:@"img_%02d",i + 1];
        imageView.image = [UIImage imageNamed:imgName];

        CGFloat imgX = i * imgW;

        imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);

        //把imgView添加到UIscrollView中
        [self.scrollView addSubview:imageView];
    }
    //设置uiscrollView的contentsize
    CGFloat maxW = self.scrollView.frame.size.width * 5;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    //设置代理
    self.scrollView.delegate = self;
    //实现uiscrollView的分页效果
    self.scrollView.pagingEnabled = YES;

    //隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;

    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;

    //创建一个计时器控件NSTimer控件
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //修改self.timer的优先级
    //创建一个消息循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //改变优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];

}
#pragma mark - 设置左抽屉
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

#pragma mark - 设置右边设置
-(void)setRightBarButton
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(setting) image:@"Home_setting" highImage:nil];
}
/** 设置 */
- (void)setting {
    //进入设置的控制器
    CYSettingViewController *settingVc = [[CYSettingViewController alloc]init];

    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 滚动图片相关
/**
 *  自动滚动图片
 */
-(void)scrollImage
{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
    }else{
        page++;
    }
    //用每一页的宽度 *（页码 + 1） = 计算出了下一页的contentoffset
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

/**
 *  实现scrollView的代理方法
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前滚到了第几页
    CGFloat offSetX = scrollView.contentOffset.x;
    //一半过去就可以换页
    offSetX = offSetX + (scrollView.frame.size.width * 0.5);

    int page = offSetX / scrollView.frame.size.width;
    self.pageControl.currentPage = page;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止计时器
    [self.timer invalidate];
    //因为计时器已经废了，所以设置为nil
    self.timer = nil;

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新开启计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //创建一个消息循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //改变优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 科目一的按钮事件
/**
 *  顺序练习
 */
- (IBAction)orderTraing:(id)sender {
    //从plist中加载
    CYQuestionViewController *questionVc = [[CYQuestionViewController alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"question.plist" ofType:nil];
    NSDictionary *newQuestion = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *newQuestionDict = newQuestion[@"result"];

    NSMutableArray *newQuestionMode = [NSMutableArray array];
    for (NSDictionary *dict in newQuestionDict) {
        CYQuestionModel *model = [CYQuestionModel modelWithDict:dict];
        [newQuestionMode addObject:model];
    }

    NSMutableArray *newFrames = [NSMutableArray array];
    for (CYQuestionModel *model in newQuestionMode) {
        CYQuestionFrame *f = [[CYQuestionFrame alloc]init];
        f.questionMode = model;
        [newFrames addObject:f];
    }
    questionVc.questionFrames = newFrames;

    [self.navigationController pushViewController:questionVc animated:YES];
}
/**
 *  随机练习
 */
- (IBAction)randTraing:(id)sender {
    CYQuestionViewController *questionVc = [[CYQuestionViewController alloc]init];
        //1.请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        //2.拼接请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"subject"] = @(1);
        params[@"model"] = @"c1";
        params[@"key"] = @"aa4303492756274d1c763688bac1883c";
        params[@"testType"] = @"rand";
        //3.发送请求
        [mgr GET:@"http://api2.juheapi.com/jztk/query" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSString *filePath = @"/Users/apple/desktop/question.plist";
//            [responseObject writeToFile:filePath atomically:YES];
           //将微博字典数组转为微博模型数组
            NSArray *newQuestions = [CYQuestionModel objectArrayWithKeyValuesArray:responseObject[@"result"]];
    
            NSMutableArray *newFrames = [NSMutableArray array];
            for (CYQuestionModel *model in newQuestions) {
                CYQuestionFrame *f = [[CYQuestionFrame alloc]init];
                f.questionMode = model;
                [newFrames addObject:f];
            }
            questionVc.questionFrames = newFrames;
            [MBProgressHUD showSuccess:@"加载成功"];
            [self.navigationController pushViewController:questionVc animated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"加载失败"];
        }];

}
/**
 *  我的错题
 */
- (IBAction)myWrong:(id)sender {


}
/**
 *  我的收藏按钮
 */
- (IBAction)myCollect:(id)sender {
    //从沙盒中加载
    CYQuestionViewController *questionVc = [[CYQuestionViewController alloc]init];
    questionVc.questionFrames = [CYSaveQuestionModelTool modelFrames];
    if (questionVc.questionFrames.count) {
        [self.navigationController pushViewController:questionVc animated:YES];
    }else{
        [MBProgressHUD showError:@"没有收藏数据"];

    }
}

@end
