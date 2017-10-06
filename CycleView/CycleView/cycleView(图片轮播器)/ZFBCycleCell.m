//
//  ZFBCycleCell.m
//  01-支付宝
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZFBCycleCell.h"


@interface ZFBCycleCell ()


@property (weak, nonatomic) IBOutlet UIImageView *cycleImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ZFBCycleCell


- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;

//    NSString *iconName = @(indexPath.item).description;
    
    NSString *iconName = [NSString stringWithFormat:@"%ld",indexPath.item];
    
    self.cycleImage.image = [UIImage imageNamed:iconName];

    self.titleLabel.text = [NSString stringWithFormat:@"第%ld组第%ld张图片",indexPath.section,indexPath.item];

}





@end
