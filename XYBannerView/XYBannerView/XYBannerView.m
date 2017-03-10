//
//  XYBannerView.m
//  XYBannerView
//
//  Created by 渠晓友 on 2017/3/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

#import "XYBannerView.h"

// 定义图片张数为3
static int imageViewCount = 3;

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


// xib 创建
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(imageViewCount * self.scrollView.frame.size.width, 0);
    
    
    // 关于pageControll的初始设置
    self.pageControll.currentPageIndicatorTintColor = [UIColor yellowColor];
    self.pageControll.pageIndicatorTintColor = [UIColor grayColor];
    
}


#pragma mark - 重写set方法
- (void)setImagesArr:(NSArray *)imagesArr
{
    _imagesArr = imagesArr;

    

    
    
    // 设置内容
    [self setupContent];
    
    // 设置
    self.pageControll.numberOfPages = imagesArr.count;
    self.pageControll.currentPage = 0;
    
    
    // 设置定时功能
    [self startTimer];
    
}

- (void)setupContent
{
    // 设置图片，页码（这是一个循环，自己演算一下即可）
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControll.currentPage;
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        if (index < 0) {
            index = self.pageControll.numberOfPages - 1;
        } else if (index >= self.pageControll.numberOfPages) {
            index = 0;
        }
        imageView.tag = index;
        imageView.image = [UIImage imageNamed:self.imagesArr[index]];
    }
    
    
    // 设置当前偏移量
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);

}


#pragma mark - 代理监听页面滚动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;

            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    
    self.pageControll.currentPage = page;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setupContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setupContent];
}


#pragma mark - 定时器

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [self nextPage];
        
    }];
    
    // 设置timer在运行循环中模式为
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)endTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];

}


@end
