//
//  YJMBannerCell.m
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/27.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import "YJMBannerCell.h"

@implementation YJMBannerCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建将要显示控件
        self.bannerImageView = [[UIImageView alloc] init];
        self.bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bannerImageView.clipsToBounds = YES;
//        self.bannerImageView.image = IMAGE(@"退出");
//        self.bannerImageView.backgroundColor = kGreenColor;
        [self.contentView addSubview:self.bannerImageView];
    }
    return self;
    
}
@end
