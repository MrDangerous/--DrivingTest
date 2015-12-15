//
//  CYQuestionViewController.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/11.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionViewController.h"
#import "CYJumpCell.h"
#import "CYJumpToCollectionView.h"
#import "CYButton.h"
#import "CYQuestionCell.h"
#import "CYQuestionModel.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "CYQuestionFrame.h"
@interface CYQuestionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, weak)UICollectionView *collectionView;
/** naviBar相关 */
/**需要强指针引用*/
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UIButton *modeBtn;

// 弹出来的三个View
@property (nonatomic, strong) UICollectionView *jumpCollectionView;
@property (nonatomic, strong) CYJumpToCollectionView *jumpTopView;
@property (nonatomic, strong) UIButton *topCover;

/**
 *  题目数组（里面放的都是CYQuestion数组，一个数组就代表一道题目）
 */
@property (nonatomic, strong) NSMutableArray *questionFrames;
@end

@implementation CYQuestionViewController
///**
// *  懒加载数据
// */
-(NSMutableArray *)questionFrames
{
    if (!_questionFrames) {
        self.questionFrames = [[NSMutableArray alloc]init];
        }
    return _questionFrames;
}


static NSString *const ID = @"cell";
-(void)configCollectionView
{


    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(__kScreenWidth, __kScreenHeight - 64);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //注册cell
    [collectionView registerClass:[CYQuestionCell class] forCellWithReuseIdentifier:ID];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
}

#pragma mark collectionView数据源代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.questionFrames.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYQuestionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    取出这行对应的数据模型
    cell.questionFrame = self.questionFrames[indexPath.item];
    return cell;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
    //配置导航栏
    [self configNaviBar];
    [self configQuestionInfo];

}


/**
 *  创建navigationBarButtonItem
 */
-(void)configNaviBar
{
    CYButton *jump = [self buttonWithTitle:@"1/100" imageName:@"Answer_jump" highImageName:nil target:self action:@selector(jump:)];
    jump.frame = CGRectMake(__kScreenWidth - 60 * 3 - 10, 0, 65, 44);
    jump.titleEdgeInsets = UIEdgeInsetsMake(0, -3, -20, 0);
    jump.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -40);
    self.jumpBtn = jump;
    UIBarButtonItem *itemJump = [[UIBarButtonItem alloc]initWithCustomView:jump];

    CYButton *mode = [self buttonWithTitle:@"答题模式" imageName:@"Answer_mode" highImageName:@"Answer_mode_sel" target:self action:@selector(changeMode:)];
    mode.frame = CGRectMake(__kScreenWidth - 50 * 2, 0, 65, 44);
    [mode setTitle:@"开挂模式" forState:UIControlStateSelected];
    mode.titleEdgeInsets = UIEdgeInsetsMake(0, -20, -20, 0);
    mode.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -48);
    mode.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    self.modeBtn = mode;
    UIBarButtonItem *itemMode = [[UIBarButtonItem alloc]initWithCustomView:mode];

     NSString *title = @"收藏";
    CYButton *collection = [self buttonWithTitle:title imageName:@"Answer_collection" highImageName:@"Answer_collection_sel" target:self action:@selector(collection:)];
    [collection setTitle:@"已收藏" forState:UIControlStateSelected];
    collection.frame = CGRectMake(__kScreenWidth - 30, 0, 55, 44);
    collection.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -20, 0);
    CGFloat width = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    collection.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -width - 15);
    self.collectionBtn = collection;
    UIBarButtonItem *itemCollection = [[UIBarButtonItem alloc]initWithCustomView:collection];

    self.navigationItem.rightBarButtonItems = @[itemCollection,itemMode,itemJump];
}
/**
 *  自定义navigation按钮封装
 */
-(CYButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    CYButton *button = [CYButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *highImage = [[UIImage imageNamed:highImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:image forState:UIControlStateNormal];
    if (highImage) {
        [button setImage:highImage forState:UIControlStateSelected];
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 *  获得题目信息
 */
-(void)configQuestionInfo
{
    /*接口地址：http://api2.juheapi.com/jztk/query
    支持格式：json
    请求方式：get post
    请求示例：http://api2.juheapi.com/jztk/query?subject=1&model=c1&key=您申请的appKey&testType=rand
     
     {
     "error_code": 0,
     "reason": "ok",
     "result": [
     {
     "id": 12,
     "question": "这个标志是何含义？",//问题
     "answer": "4",//答案
     "item1": "前方40米减速",//选项，当内容为空时表示判断题正确选项
     "item2": "最低时速40公里",//选项，当内容为空时表示判断题错误选项
     "item3": "限制40吨轴重",
     "item4": "限制最高时速40公里",
     "explains": "限制最高时速40公里：表示该标志至前方限制速度标志的路段内，机动车行驶速度不得超过标志所示数值。此标志设在需要限制车辆速度的路段的起点。以图为例：限制行驶时速不得超过40公里。",//答案解释
     "url": "http://images.juheapi.com/jztk/c1c2subject1/12.jpg"//图片url
     }
     ]
     }

     */
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
       //将微博字典数组转为微博模型数组
        [responseObject writeToFile:@"/Users/apple/Desktop/question.plist" atomically:YES];
        NSArray *newQuestions = [CYQuestionModel objectArrayWithKeyValuesArray:responseObject[@"result"]];
        NSMutableArray *newFrames = [NSMutableArray array];
        for (CYQuestionModel *model in newQuestions) {
            CYQuestionFrame *f = [[CYQuestionFrame alloc]init];
            f.questionMode = model;
            [newFrames addObject:f];
        }
        self.questionFrames = newFrames;
        //刷新表格
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"请求失败 ---- %@",error);
    }];
}
#pragma mark - 添加3个按钮事件





@end
