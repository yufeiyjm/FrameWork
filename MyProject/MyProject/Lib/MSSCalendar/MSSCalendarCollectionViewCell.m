//
//  MSSCalendarCollectionViewCell.m
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarDefine.h"

@implementation MSSCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    CGFloat height = self.frame.size.height / 2;
    _backView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - ((self.frame.size.height / 2 - MSS_Iphone6Scale(10))/2), MSS_Iphone6Scale(10), self.frame.size.height / 2 - MSS_Iphone6Scale(10), self.frame.size.height / 2 - MSS_Iphone6Scale(10))];
    [self.contentView addSubview:_backView];
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = (self.frame.size.height / 2 - MSS_Iphone6Scale(10))/2;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_imageView];
    
    _dateLabel = [[MSSCircleLabel alloc]initWithFrame:CGRectMake(0, MSS_Iphone6Scale(10), self.contentView.frame.size.width, self.frame.size.height / 2 - MSS_Iphone6Scale(10))];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _dateLabel.backgroundColor = kClearColor;
    [self.contentView addSubview:_dateLabel];
    
    _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateLabel.frame), self.contentView.frame.size.width, _dateLabel.frame.size.height)];
    _subLabel.textAlignment = NSTextAlignmentCenter;
    _subLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    [self.contentView addSubview:_subLabel];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _dateLabel.isSelected = isSelected;
}

@end
