//
//  YJMBannerView.h
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/27.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YJMBannerViewDataSource, YJMBannerViewDelegate;

@interface YJMBannerView : UIView
/** 是否需要循环滚动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL shouldLoop;

/** 是否自动滑动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL autoScroll;

/** 自动滑动间隔时间(s), 默认为 3.0 */
@property (nonatomic, assign) IBInspectable CGFloat scrollInterval;

/** pageControl, 可自由配置其属性 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, weak)  id<YJMBannerViewDataSource> dataSource;
@property (nonatomic, weak)  id<YJMBannerViewDelegate> delegate;

- (void)reloadData;

- (void)startTimer;
- (void)stopTimer;

@end

@protocol YJMBannerViewDataSource <NSObject>
@required

- (NSInteger)numberOfItemsInBanner:(YJMBannerView *)banner;
- (NSURL *)banner:(YJMBannerView *)banner viewForItemAtIndex:(NSInteger)index;



@end

@protocol YJMBannerViewDelegate <NSObject>
@optional

- (void)banner:(YJMBannerView *)banner imageView:(UIImageView *)imageView didSelectItemAtIndex:(NSInteger)index;

@end
