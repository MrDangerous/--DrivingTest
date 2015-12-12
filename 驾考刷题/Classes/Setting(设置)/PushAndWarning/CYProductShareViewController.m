//
//  CYProductShareViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYProductShareViewController.h"
#import "CYProduct.h"
#import "CYProductCell.h"
@interface CYProductShareViewController ()
/**
 *  所有的产品，里面放CYProduct
 */
@property(nonatomic, strong)NSArray *products;
@end

@implementation CYProductShareViewController

-(NSArray *)products
{
    if (!_products) {
        //1.获取json路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"products.json" ofType:nil];

        //2.把json转成NSData
        NSData *data = [NSData dataWithContentsOfFile:filePath];

        //3.再把NSData转成数组
        //json的序列化 “就是把数据转成字典/数组”
        NSArray *productArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        //遍历数组里的字典，转成模型
        NSMutableArray *productsM = [NSMutableArray array];
        for (NSDictionary *dict in productArr) {
            CYProduct *product = [CYProduct productWithDict:dict];
            [productsM addObject:product];
        }
        _products = productsM;
    }
    return _products;
}

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{
    //流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        //最终的cell的大小，是由流水布局决定的，由xib决定不了
        //设置cell的尺寸
        flowLayout.itemSize = CGSizeMake(80, 100);

        //设置行的边距
        flowLayout.minimumLineSpacing = 20;
        //设置cell的列间距
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.collectionView.backgroundColor = [UIColor whiteColor];

    //注册一个可循环的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CYProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}





#pragma mark <UICollectionViewDataSource>
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

//组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.products.count; 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //设置模型
    cell.product = self.products[indexPath.row];
    
    return cell;
}
#pragma mark - cell的选中
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
