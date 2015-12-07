//
//  CYTabbar.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/6.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTabbar;
@protocol CYTabbarDelegate <NSObject>

-(void)tabbar:(CYTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface CYTabbar : UIView

@property(nonatomic, weak)id<CYTabbarDelegate> delegate;

/**
 * 传普通状态和选中状态的图片，内部就帮你添加一个按钮
 */
-(void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg;
@end
//自定义按钮
@interface CYTabbarButton : UIButton

@end