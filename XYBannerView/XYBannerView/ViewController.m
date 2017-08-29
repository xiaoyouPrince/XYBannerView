//
//  ViewController.m
//  XYBannerView
//
//  Created by 渠晓友 on 2017/3/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

#import "ViewController.h"

#import "XYBannerView.h"

@interface ViewController ()<UIScrollViewDelegate,XYBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 1.创建banner
//    XYBannerView *banner = [XYBannerView bannerView];
    XYBannerView *banner = [[XYBannerView alloc] init];
    
    // 2.设置banner相关属性
    banner.imagesArr = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    
    banner.titlesArr = @[@"111111111",@"2222222222",@"333333333",@"444444444",@"555555555"];
    banner.frame = CGRectMake(37.5, 100, 300, 150);
//    banner.frame = CGRectMake(80, 20, 200, 90);
    
    // 3. 监听设置代理
    banner.delegate = self;
    
    
    // 3.添加到UI上
    [self.view addSubview:banner];
    
    
    
    
}

/**
 *  返回Banner和对应的点击页码
 *  @parama banner  返回的Banner对象
 *  @parama index   点击的页码
 */
- (void)bannerView:(XYBannerView *)banner didClickImageAtIndex:(NSInteger)index
{
    NSLog(@"index == %ld",index);
}


// 1.创建基本UI

// 1.1 引入封装概念

// 2.设置代理

// 3.添加scrollView的image

// 4.分页

// 5.定时器滚动起来

// 5.1 定时器线程阻塞问题，设置runloop的模式

// 6。引入性能问题，复用对应的ImageView



@end
