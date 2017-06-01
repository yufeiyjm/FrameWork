//
//  LGLCalenderCell.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLCalenderCell.h"
#import "UIView+Frame.h"
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation LGLCalenderCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 8;
        self.dateL = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, self.width, 16)];
        self.dateL.textAlignment = NSTextAlignmentCenter;
        self.dateL.backgroundColor = [UIColor clearColor];
        self.dateL.textColor = UIColorFromRGB(0x0A84C1);
        self.dateL.font = [UIFont boldSystemFontOfSize:14];
        
        self.priceL = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, self.width, 16)];
        self.priceL.textAlignment = NSTextAlignmentCenter;
        self.priceL.backgroundColor = [UIColor clearColor];
        self.priceL.textColor = UIColorFromRGB(0xE84234);
        self.priceL.font = [UIFont systemFontOfSize:9];
        
        [self addSubview:self.dateL];
        [self addSubview:self.priceL];
    }
    return self;
}


@end
