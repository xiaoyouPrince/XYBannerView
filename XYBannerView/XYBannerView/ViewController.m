//
//  ViewController.m
//  XYBannerView
//
//  Created by 渠晓友 on 2017/3/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

#import "ViewController.h"

#import "XYBannerView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 设置图片张数 = 5
//    int imageCount = 5;
//    
//    for (int i = 0;  i < imageCount; i++) {
//        
//        // 根据位置index创建图片
//        NSString *imageName = [NSString stringWithFormat:@"img_0%d",i];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
//        imageView.frame = CGRectMake(i * imageView.frame.size.width, 0, imageView.frame.size.width, self.scrollView.frame.size.height);
//        
//        // 添加到ScrollView上
//        [self.scrollView addSubview:imageView];
//
//    }
//    
//    
//    // 设置contentSize
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imageCount, 0);
//    
//    // 设置分页
//    self.scrollView.pagingEnabled = YES;
//    // 去掉标注线
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    // 1.创建banner
//    XYBannerView *banner = [XYBannerView bannerView];
    XYBannerView *banner = [[XYBannerView alloc] init];
    
    // 2.设置banner相关属性
    banner.imagesArr = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
//    banner.frame = CGRectMake(37.5, 100, 300, 150);
    banner.frame = CGRectMake(80, 20, 200, 90);
    
    // 3.添加到UI上
    [self.view addSubview:banner];
    
    
    
    // 测试
//    UIImageView *iv = [UIImageView new];
//    iv.image = [UIImage imageNamed:nil];
//    iv.frame = CGRectMake(50, 300, 200, 80);
//    iv.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:iv];
    
    
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
