//
//  CYTabbar.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYTabbar.h"

@interface CYTabbar()
/**
 *  当前选中的按钮
 */
@property(nonatomic, weak)UIButton *selectBtn;

@end


@implementation CYTabbar

//-(void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg
//{
//    UIButton *btn = [CYTabbarButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:selImg] forState:UIControlStateSelected];
//    //监听事件
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
//    //绑定tag
//    btn.tag = self.subviews.count;
//    [self addSubview:btn];
//
//    //设置默认选中
//    if (btn.tag == 0) {
//        [self btnClick:btn];
//    }
//}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    NSInteger count = self.subviews.count;
//    //布局子控件
//    CGFloat btnW = self.width / count;
//    CGFloat btnH = self.height;
//    for (UIButton *btn in self.subviews) {
//        btn.frame = CGRectMake(btnW * btn.tag, 0, btnW, btnH);
//    }
//}
//
//-(void)btnClick:(UIButton *)btn
//{
//    //点击通知代理
//    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedFrom:to:)]) {
//        [self.delegate tabbar:self didSelectedFrom:self.selectBtn.tag to:btn.tag];
//    }
//    //取消之前的选中
//    self.selectBtn.selected = NO;
//
//    //设置当前选中
//    btn.selected = YES;
//    self.selectBtn = btn;
//
//}
//
//@end
////实现自定义的btn
//@implementation CYTabbarButton
//
////图片高亮时候会调用这个方法
//-(void)setHighlighted:(BOOL)highlighted{
//    NSLog(@"%s",__func__);
//    //只要不调用父类的方法，按钮就不会有高度的效果
//    //[super setHighlighted:highlighted];
//}

@end

