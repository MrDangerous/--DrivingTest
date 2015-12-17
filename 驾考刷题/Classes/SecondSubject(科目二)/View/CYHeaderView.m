//
//  CYHeaderView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/10.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYHeaderView.h"

@interface CYHeaderView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong)NSTimer *timer;

@end


@implementation CYHeaderView

+(instancetype)headerView
{
    CYHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"CYHeadView" owner:nil options:nil]lastObject];
    return headerView;
}

#pragma mark - scrollView相关
-(void)awakeFromNib
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


#pragma mark - scrollView的代理方法
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

@end
