//
//  ZFBCycleView.m
//  01-支付宝
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

////总共有多少组
//#define GROUP_COUNT 3
//
////总共有多少张图片
//#define IMAGE_COUNT 5


#import "ZFBCycleView.h"
#import "ZFBCycleCell.h"
#import "ZFBCycleFlowLayout.h"


@interface ZFBCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;



@end


static NSString *Identifier = @"Identifier";

@implementation ZFBCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI{

    [self makeCollectionView];
    
    [self makePageController];
    
     NSTimer *time = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
    //把定时器添加到运行循环
    [[NSRunLoop currentRunLoop]addTimer:time forMode:NSRunLoopCommonModes];
    
    self.timer = time;
}

- (void)startScroll{

    //获取当前是第几页
    NSInteger page = self.pageControl.currentPage;
    
    NSIndexPath *indexPath;
    
    if (page == (self.cycleImages.count - 1)) { //当图片是最后一张时
        indexPath = [NSIndexPath indexPathForItem:0 inSection:GROUP_COUNT / 2 + 1]; //第2组0行索引
    }else{
        //如果不是最后一张图片
        indexPath = [NSIndexPath indexPathForItem:++page inSection:GROUP_COUNT / 2]; //第1组 行加 1
    }
    //通过指定的索引滚动到指定的位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}

// 绘图
- (void)drawRect:(CGRect)rect{

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:GROUP_COUNT / 2];

    //让一开始默认不加动画的行式滚动到 1组0张图片
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}




// 创建 CollectionView
- (void)makeCollectionView{

    ZFBCycleFlowLayout *flowLayout = [[ZFBCycleFlowLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    [collectionView registerNib:[UINib nibWithNibName:@"ZFBCycleCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Identifier];
    
    [self addSubview:collectionView];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);  //上右下左同时约束
        
    }];
    
    self.collectionView = collectionView;
}

// 创建 pageController
- (void)makePageController{
    
    // UIViewController
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    pageControl.numberOfPages = IMAGE_COUNT;
    
    [self addSubview:pageControl];
    
    [pageControl makeConstraints:^(MASConstraintMaker *make) {
        // 如果是相对于同级控件就要用到 equalTo 指明是相对于那一个控件约束,相对于父控件可以省略equalTo不写
        make.centerX.offset(0);
        make.bottom.offset(-10);
    }];

    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width + 0.499;

    // 用 % 摩算出 当前图片所在第几张
    self.pageControl.currentPage = page % self.cycleImages.count;
}

- (void)setCycleImages:(NSArray *)cycleImages{

    _cycleImages = cycleImages;
    
    //设置总共有多少页码
    self.pageControl.numberOfPages = cycleImages.count;
}

//有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return GROUP_COUNT;
}
//每组返少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.cycleImages.count;
}

//每个 item 的展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ZFBCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];

    cell.indexPath = indexPath;
    
    return cell;
    
}

//只有通过代码实现滚动停止后才调用的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //调用下 通过代码实现滚后和手动拖拽停止滚动调用的方法
    [self scrollViewDidEndDecelerating:scrollView];
}

//通过代码实现滚后和手动拖拽停止滚动调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //获取前面有多少张图片
    NSInteger itemCount = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    
    //获取当前图片所在组
    NSInteger section = itemCount / self.cycleImages.count;
    
    //当前图片所在第几张
    NSInteger item = itemCount % self.cycleImages.count;
    
    NSLog(@"图片总张数：%ld  第%ld组  第%ld张图片",itemCount,section,item);
    
    if (section == GROUP_COUNT / 2) {
        return;
    }
    
    //如果不是在第一组 就让定位到第一组的和当前组显示一样的图片
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:GROUP_COUNT / 2];
    NSLog(@"不在第一组就不加动画跳到第一组的第%ld张当前一样的图片",item);
    
    // 不带动画的滚动到指定索引的图片
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

}

//即将开始拖拽时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    self.timer.fireDate = [NSDate distantFuture]; //停止定时器
}

//停止拖拽时调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    //开启定时器 在 2 秒后执行
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
}



@end
