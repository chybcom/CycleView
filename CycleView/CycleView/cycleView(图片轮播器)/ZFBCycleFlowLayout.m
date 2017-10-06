//
//  ZFBCycleFlowLayout.m
//  01-支付宝
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZFBCycleFlowLayout.h"

@implementation ZFBCycleFlowLayout

//开始布局时调用
- (void)prepareLayout{

    [super prepareLayout];

    //最小行间距
    self.minimumLineSpacing = 0;
    //最小列间距
    self.minimumInteritemSpacing = 0;
    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // item 大小
    self.itemSize = self.collectionView.bounds.size;
    //关闭水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //关闭垂直滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    //开启分页效果
    self.collectionView.pagingEnabled = YES;
    //关闭弹彉效果
    self.collectionView.bounces = NO;
}


@end
