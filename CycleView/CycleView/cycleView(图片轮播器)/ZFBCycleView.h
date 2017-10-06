//
//  ZFBCycleView.h
//  01-支付宝
//
//  Created by apple on 17/6/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


//总共有多少组
#define GROUP_COUNT 3

//总共有多少张图片
#define IMAGE_COUNT 7


@interface ZFBCycleView : UIView


/**用于接收 ZFBHomeFunctionAdCell 传过来的图片数组*/
@property (nonatomic, strong) NSArray *cycleImages;


@end
