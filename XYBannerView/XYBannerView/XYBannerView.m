//
//  XYBannerView.m
//  XYBannerView
//
//  Created by 渠晓友 on 2017/3/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

#import "XYBannerView.h"

@interface XYBannerView ()<UIScrollViewDelegate>

// 滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// 页面小圆点
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XYBannerView

// 放回实例对象
+ (instancetype)bannerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


#pragma mark - 重写set方法
- (void)setImagesArr:(NSArray *)imagesArr
{
    _imagesArr = imagesArr;
    
    // 创建对应的imageView添加到scrollView中去
    for (int i = 0 ; i < imagesArr.count ;i++) {

        // 根据位置index创建图片
        NSString *imageName = [NSString stringWithFormat:@"img_0%d",i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * imageView.frame.size.width, 0, imageView.frame.size.width, self.scrollView.frame.size.height);

        // 添加到ScrollView上
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(imagesArr.count * self.scrollView.frame.size.width, 0);
    self.scrollView.pagingEnabled = YES;
    
    
    
    // 关于pageControll的设置
    self.pageControll.numberOfPages = imagesArr.count;
    self.pageControll.currentPage = 0;
    self.pageControll.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControll.pageIndicatorTintColor = [UIColor grayColor];
    
    
    // 设置定时功能
    [self startTimer];
    
}


#pragma mark - 代理监听页面滚动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 实时监听当前第几页，根据当前偏移量来
    self.pageControll.currentPage = (int)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width + 0.5);
    
}


#pragma mark - 定时器

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [self nextPage];
        
    }];
    
    [self.timer fire];
}

- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    
    NSInteger page = self.pageControll.currentPage + 1;
    
    if (page == self.pageControll.numberOfPages) {
        page = 0;
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        //每次滚动就是，改变对应偏移量
        CGPoint offsize = self.scrollView.contentOffset;
        offsize.x =  page * self.scrollView.frame.size.width;
        self.scrollView.contentOffset = offsize;
    }];
}


@end
