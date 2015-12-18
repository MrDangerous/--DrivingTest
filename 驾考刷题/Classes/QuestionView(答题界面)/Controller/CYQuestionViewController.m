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
#import "CYQuestionFrame.h"
#import "CYSaveQuestionModelTool.h"
@interface CYQuestionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, weak)UICollectionView *collectionView;
/** naviBar相关 */
/** 拿到这三个按钮，以后要改变他们的按钮状态*/
@property (nonatomic, weak) CYButton *collectionBtn;
@property (nonatomic, weak) CYButton *jumpBtn;
@property (nonatomic, weak) CYButton *modeBtn;

// 弹出来的两个个View,一起就是一个大的弹出View，这两个可以封装在View中，减少控制器的代码量
@property (nonatomic, weak) UICollectionView *jumpCollectionView;
@property (nonatomic, weak) CYJumpToCollectionView *jumpTopView;

/** 弹出view时需要在背后加一个阴影按钮 */

@property (nonatomic, weak) UIButton *topCover;

/** 是否正在显示 跳转View */
@property (nonatomic, assign) BOOL isShowingJumpView;



// 控制题目索引, 类型的int类型属性, 默认没有赋值一开始就是0
@property(nonatomic, strong)NSIndexPath *indexPath;


@end

@implementation CYQuestionViewController

#pragma mark - 数据的懒加载
/**
 *  创建弹出框阴影背景
 */
-(UIButton *)topCover
{
    if (_topCover == nil) {
        UIButton *topCover = [[UIButton alloc]init];
        topCover.alpha = 0.4;
        topCover.frame = CGRectMake(0, __kScreenHeight, __kScreenWidth, 64);
        topCover.backgroundColor = [UIColor darkGrayColor];
        [topCover addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.view addSubview:topCover];
        _topCover = topCover;
    }
    return _topCover;
}
/**
 *  选择菜单中小的collectionView
 */
-(UICollectionView *)jumpCollectionView
{
    if (_jumpCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSize =CGSizeMake((__kScreenWidth - 20) / 5 , (__kScreenWidth - 20) / 5);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        UICollectionView *jumpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + 70 + __kScreenHeight, __kScreenWidth, __kScreenHeight - 64 - 70) collectionViewLayout:layout];
        jumpCollectionView.delegate = self;
        jumpCollectionView.dataSource = self;
        jumpCollectionView.backgroundColor = [UIColor whiteColor];
        jumpCollectionView.scrollEnabled = YES;
        jumpCollectionView.showsVerticalScrollIndicator = YES;
        jumpCollectionView.contentSize = CGSizeMake(0, (self.questionFrames.count / 5 + 2) * (__kScreenWidth/5));
        [jumpCollectionView registerNib:[UINib nibWithNibName:@"CYJumpCell" bundle:nil] forCellWithReuseIdentifier:@"CYJumpCell"];
        [self.navigationController.view addSubview:jumpCollectionView];
        _jumpCollectionView = jumpCollectionView;
    }
    return _jumpCollectionView;
}
/**
 *  xib加载的弹出View
 */
-(CYJumpToCollectionView *)jumpTopView
{
    if (_jumpTopView == nil) {
        CYJumpToCollectionView *jumpTopView = [[CYJumpToCollectionView alloc]init];
        jumpTopView.frame = CGRectMake(0, __kScreenHeight + 64, __kScreenWidth, 70);
        //添加手势，当一触摸到它时就跳转到主控制器
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
        [jumpTopView addGestureRecognizer:tap];
        [self.navigationController.view addSubview:jumpTopView];
        _jumpTopView = jumpTopView;
    }
    return _jumpTopView;
}

//主界面的大的collectionView
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

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configCollectionView];

    //刷新表格
    [self.collectionView reloadData];
    
    //配置导航栏
    [self configNaviBar];

}


#pragma mark collectionView数据源代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.questionFrames.count;
}

/**
 *  在这里分别判断返回的cell是jumpCollectionView的还是collectionView的
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        CYQuestionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        //取出这行对应的数据模型
        cell.questionFrame = self.questionFrames[indexPath.item];
        self.indexPath = indexPath;
        //回答正确之后的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(questionDidAnswerCorrect:) name:@"CYAnswerDidSelectCorrect" object:nil];

        return cell;
    }else{
        CYJumpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYJumpCell" forIndexPath:indexPath];
        [cell.btn setTitle:[NSString stringWithFormat:@"%zd",(indexPath.item + 1)] forState:UIControlStateNormal];

        return cell;
    }
}
/**
 *  点击jumpToCollectionView的cell后跳转到相应的题目
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.jumpCollectionView) {
        //执行跳转
        CGPoint offSet = self.collectionView.contentOffset;
        offSet.x = __kScreenWidth * indexPath.item;
        [self.collectionView setContentOffset:offSet animated:YES];
        [self jump];
    }

}

/**
 *  回答正确之后的方法
 */
-(void)questionDidAnswerCorrect:(NSNotification *)notification
{
    //如果是最后一题就返回，不执行下面的语句
    if (self.indexPath.item == self.questionFrames.count - 1) {
        return;
    }
    CGPoint offset = self.collectionView.contentOffset;
    offset.x += __kScreenWidth;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:offset animated:YES];
   }


/**
 *  创建navigationBarButtonItem
 */
-(void)configNaviBar
{
    CYButton *jump = [self buttonWithTitle:@"1/100" imageName:@"Answer_jump" highImageName:nil target:self action:@selector(jump)];
    jump.frame = CGRectMake(__kScreenWidth - 60 * 3 - 10, 0, 55, 44);
    jump.titleEdgeInsets = UIEdgeInsetsMake(0, -3, -20, 0);
    jump.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -40);
    self.jumpBtn = jump;
    UIBarButtonItem *itemJump = [[UIBarButtonItem alloc]initWithCustomView:jump];

    CYButton *mode = [self buttonWithTitle:@"答题模式" imageName:@"Answer_mode" highImageName:@"Answer_mode_sel" target:self action:@selector(changeMode)];
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

#pragma mark - 添加3个按钮事件
/**
 *  弹出选题界面
 */
-(void)jump
{
    if (self.isShowingJumpView == NO) {
        self.isShowingJumpView = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.jumpCollectionView.y = 64 + 70;
            self.jumpTopView.y = 64;
            self.topCover.y = 0;
        }];
    } else {
        self.isShowingJumpView = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.jumpCollectionView.y = __kScreenHeight + 64 + 70;
            self.jumpTopView.y = __kScreenHeight + 64;
            self.topCover.y = __kScreenHeight;
        }];
    }
}
/**
 *  改变答题模式
 */
-(void)changeMode
{

}
/**
 *  收藏按钮
 */
-(void)collection:(CYButton *)collectionBtn
{
    self.collectionBtn.selected = !collectionBtn.selected;
    CYQuestionFrame *modelFrame = self.questionFrames[self.indexPath.item];
    if (self.collectionBtn.selected) {
        //更换标题的时候内边距也需要改变
        CGFloat width = [@"已收藏" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        self.collectionBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -width - 15);
        modelFrame.questionMode.isCollection = YES;
    }else{
        self.collectionBtn.selected = NO;
        self.collectionBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -41);
        modelFrame.questionMode.isCollection = NO;
    }

    if (modelFrame.questionMode.isCollection) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //存储收藏的题目到沙盒文件中
            [CYSaveQuestionModelTool saveQuestionModel:modelFrame];
        });
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //存储收藏的题目到沙盒文件中
            [CYSaveQuestionModelTool deleteQuestionModel:modelFrame];
        });
    }
}



#pragma mark - 私有方法

/** 滚动结束的时候会调用此方法，这时才刷新收藏按钮的UI */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        [self refreshJumpBtnAndCollectionBtn];
    }
}
- (void)refreshJumpBtnAndCollectionBtn {
    CYQuestionFrame *modelFrame = self.questionFrames[self.indexPath.item];
    // 1、根据是否收藏,改变界面收藏按钮的显示。在拖拽结束后才执行。
    if (modelFrame.questionMode.isCollection) {
        // 更换标题的时候，内边距的值也变化一下
        self.collectionBtn.selected = YES;
        CGFloat width = [@"已收藏" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        self.collectionBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -width - 15);
    } else {
        self.collectionBtn.selected = NO;
        self.collectionBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -41);
    }

}
#pragma mark - 保存数据






@end
