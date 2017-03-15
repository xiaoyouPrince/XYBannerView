//
//  XYBannerView.h
//  XYBannerView
//
//  Created by 渠晓友 on 2017/3/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYBannerView;

@protocol XYBannerViewDelegate <NSObject>

@optional

//监听点击的图片和位置
- (void)bannerView:(XYBannerView *)banner didClickImageAtIndex:(NSInteger)index;


@end



@interface XYBannerView : UIView


// 要展示图片数组
@property (nonatomic, strong) NSArray *imagesArr;

@property (nonatomic, strong) NSArray *titlesArr;

@property (nonatomic, weak) id<XYBannerViewDelegate> delegate;


+ (instancetype)bannerView;








@end
