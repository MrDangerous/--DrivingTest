//
//  CYJumpToCollectionView.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/11.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYJumpToCollectionView.h"
#import "CYJumpCell.h"
@interface CYJumpToCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
//数据
@property(nonatomic, strong)NSMutableArray *questions;


@end

@implementation CYJumpToCollectionView


static NSString *const ID = @"cell";

-(NSMutableArray *)questions
{
    if (!_questions) {
        self.questions = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 20; i++) {
            [self.questions addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _questions;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CYJumpToCollectionView" owner:self options:nil]lastObject];

    }
    return self;
}
-(void)awakeFromNib
{
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
//    CGRect rect =  CGRectMake(0, 300, 320, 320);
//    [self.collectView initWithFrame:rect collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    [self.collectView registerNib:[UINib nibWithNibName:@"CYJumpCell" bundle:nil] forCellWithReuseIdentifier:ID];


}

#pragma mark - CollectView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.questions.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYJumpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];


    return cell;
}



@end
