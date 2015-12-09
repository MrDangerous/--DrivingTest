//
//  CYProductCell.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYProductCell.h"

@interface CYProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;

@end

@implementation CYProductCell

- (void)awakeFromNib {
    //剪切圆角
#warning awakeFromNib这个方法之后,连线才完成
    self.imgView.layer.cornerRadius = 15;
    self.imgView.layer.masksToBounds = YES;
}
-(void)setProduct:(CYProduct *)product
{
    _product = product;
    //设置图片
    self.imgView.image = [UIImage imageNamed:product.icon];
    //设置产品名称
    self.nameLb.text = product.title;
}
@end
