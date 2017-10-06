//
//  CycleViewController.m
//  CycleView
//
//  Created by apple on 17/6/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CycleViewController.h"
#import "ZFBCycleView.h"


@interface CycleViewController ()
// 轮播图片数组
@property (nonatomic, strong) NSArray *cycleImages;

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    ZFBCycleView *cycleView = [[ZFBCycleView alloc]init];
    
    [self.view addSubview:cycleView];
    
    cycleView.cycleImages = self.cycleImages;
    
  
    [cycleView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
     
    }];
    
    
    
}

- (NSArray *)cycleImages{

    if (_cycleImages == nil) {
        
        NSMutableArray *Marry = [NSMutableArray arrayWithCapacity:IMAGE_COUNT];
        
        for (NSInteger i = 0; i < IMAGE_COUNT; ++i) {
            
            NSString *imageName = @(i).description;
            
            [Marry addObject:imageName];
        }
        _cycleImages = Marry;
        
    }
    return _cycleImages;
}



@end
