//
//  CYJumpToCollectionView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/11.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYJumpToCollectionView.h"
#import "CYJumpCell.h"
@interface CYJumpToCollectionView()


@property(nonatomic, strong)NSMutableArray *questions;


@end

@implementation CYJumpToCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CYJumpToCollectionView" owner:self options:nil] lastObject];
    }
    return self;
}


@end
