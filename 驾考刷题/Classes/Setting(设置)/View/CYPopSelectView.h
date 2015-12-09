//
//  CYPopSelectView.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/9.
//  Copyright © 2015年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYPopSelectView;
@protocol  CYPopSelectViewDelegate<NSObject>

-(void)popSelectView:(CYPopSelectView *)popSelectView;
-(void)popSelectView:(CYPopSelectView *)popSelectView didFinshedChangeCellData:(NSString *)cellData;

@end


@interface CYPopSelectView : UIView

@property(nonatomic, weak)id<CYPopSelectViewDelegate> delegate;

@end
