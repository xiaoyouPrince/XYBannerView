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

@interface XYBannerView ()<UIScrollViewDelegate,XYBannerViewDelegate>


// 滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// 页面小圆点
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;
// 标题label
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, strong) NSTimer *timer;



@end

@implementation XYBannerView

// 放回实例对象
+ (instancetype)bannerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// 代码创建
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        // 创建子控件
        UIScrollView *scrollView = [UIScrollView new];
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        UIPageControl *pageControl = [UIPageControl new];
        self.pageControll = pageControl;
        [self addSubview:pageControl];
        
        // 基础设置
        [self setup];
    }
    return self;
}


// xib 创建
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    // 基础设置
    [self setup];
}

/**
 *  基础设置
 */
- (void)setup
{

    
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
        
        
        // 每个IV设置点击事件
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedImageView:)];
        [imageView addGestureRecognizer:tap];
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

- (void)layoutSubviews
{

    [super layoutSubviews];

    
    // 重写scrollView的布局
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(imageViewCount * self.bounds.size.width, 0);
    for (int i = 0; i<imageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    
    // 重写pageControl的布局
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.scrollView.frame.size.width - pageW;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    self.pageControll.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 重写titleLabel的布局
    CGFloat titleH = 50;
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height - titleH, self.frame.size.width, titleH);

    
}

#pragma mark - 重写set方法
- (void)setImagesArr:(NSArray *)imagesArr
{
    _imagesArr = imagesArr;

    
    
    // 设置
    self.pageControll.numberOfPages = imagesArr.count;
    self.pageControll.currentPage = 0;
    
    // 设置内容
    [self setupContent];
    
    
    
    
    // 设置定时功能
    [self startTimer];
    
}

// 这里是设置标题
- (void)setTitlesArr:(NSArray *)titlesArr
{
    _titlesArr = titlesArr;
    
    // 创建一个标题的Label
    UILabel *titleLabel = [UILabel new];
    titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
//    CGFloat titleH = 50;
//    titleLabel.frame = CGRectMake(0, self.frame.size.height - titleH, self.frame.size.width, titleH);
    
    // 设置默认第一个是 第一条
    titleLabel.text = titlesArr.firstObject;
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
        
        // 同时设置title（title 和 图片是对应的，但是当前title和当前要展示的image属于错位1个单位的关系,实际上是延迟了一个单位，所以需要重新计算）
        self.titleLabel.text = self.titlesArr[index];
    }
    
    
    // 设置当前偏移量
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
    // 重置偏移量之后重新计算对应的title（取出当前页码，减去1即可）
    NSString *currentTitle = self.titleLabel.text;
    NSInteger titleIndex = [self.titlesArr indexOfObject:currentTitle];
    
    titleIndex --; // 自减一
    
    if (titleIndex  < 0) titleIndex = self.titlesArr.count - 1;
    
    // 重新设置对应的title
    self.titleLabel.text = self.titlesArr[titleIndex];
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

#pragma mark - 自己代理调用

// 点击了自己图片index
- (void)clickedImageView:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    if ([self.delegate respondsToSelector:@selector(bannerView:didClickImageAtIndex:)]) {
        
        [self.delegate bannerView:self didClickImageAtIndex:imageView.tag];
    }
}





@end
