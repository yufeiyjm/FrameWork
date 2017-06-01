//
//  MonthCalendarCollectionViewCell.m
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "MonthCalendarCollectionViewCell.h"
#import "NSDate+Category.h"
#import "MonthCalendarCommon.h"
#import "MonthCalendarOwner.h"

@interface MonthCalendarCollectionViewCell ()
@property (nonatomic, retain) NSMutableArray *blocks;
@property (nonatomic, retain) NSMutableArray *backArr;
@end
@implementation MonthCalendarCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _blocks = [[NSMutableArray alloc] init];
        _backArr = [[NSMutableArray alloc] init];
        CGFloat calendarDayWidth = self.mj_w/7.0;

        for (int i = 0; i < 42; i++) {
            int x = (i % 7) * calendarDayWidth ;
            int y = (i / 7) * WeekCellHeight;
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(x + (calendarDayWidth - DayHeight)/2,  y + (WeekCellHeight - DayHeight)/2, DayHeight, DayHeight)];
            backView.layer.cornerRadius = DayHeight/2.0f;
            backView.backgroundColor = UIColorFromRGB(0xE97E0F);
            backView.hidden = YES;
            [self addSubview:backView];
            UIButton *block = [[UIButton alloc] initWithFrame:CGRectMake(x + (calendarDayWidth - DayHeight)/2,  y + (WeekCellHeight - DayHeight)/2, DayHeight, DayHeight)];
            block.tag = i;
            block.titleLabel.font = [UIFont fontWithName:@"DINSchrift" size:15.0f];
            block.clipsToBounds = YES;
            [block addTarget:self action:@selector(dayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//            block.backgroundColor = kRedColor;
            [self addSubview:block];
            [_blocks addObject:block];
            [_backArr addObject:backView];
            UILabel *lab = [CommonUtils createLabelWithText:@"4890" frame:CGRectMake(x, block.mj_y + block.mj_h , calendarDayWidth, 10)];
            lab.font = k12Font;
            lab.textAlignment = NSTextAlignmentCenter;
//            lab.backgroundColor = kGreenColor;
            [self addSubview:lab];
        }
    }
    return self;
}

- (void)setBeginDate:(NSDate *)beginDate
{
    _beginDate = beginDate;
    NSDate *selectedDate = [[MonthCalendarOwner sharedMonthCalendarOwner] selectedDate];
    for (int i = 0; i < 42; i++) {
        UIButton *block = [_blocks objectAtIndex:i];
        UIView *backView = [_backArr objectAtIndex:i];
        NSInteger daysInLastMonth = [_beginDate totaldaysInMonth:[_beginDate lastMonth]];
        NSInteger daysInThisMonth = [_beginDate totaldaysInMonth];
        NSInteger firstWeekday    = [_beginDate firstWeekdayInThisMonth];
        NSInteger day = 0;
        
        backView.hidden = YES;
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            block.userInteractionEnabled = NO;
            [block setTitleColor:UIColorFromRGB(0xFFDE92) forState:UIControlStateNormal];
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            block.userInteractionEnabled = NO;
            [block setTitleColor:UIColorFromRGB(0xFFDE92) forState:UIControlStateNormal];
        }else{
            day = i - firstWeekday + 1;
            block.userInteractionEnabled = YES;
            [block setTitleColor:kWhiteColor forState:UIControlStateNormal];
            NSString *dayStr = [NSString stringWithFormat:@"%zd-%02zd-%02zd",beginDate.year,beginDate.month,day];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            [dateFormatter setTimeZone:GTMzone];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date =[dateFormatter dateFromString:dayStr];;
            if ([date isEqualToDateIgnoringTime:selectedDate]) {
                backView.hidden = NO;
            }
            else{
                backView.hidden = YES;
                
            }
        }
        
        [block setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];

       
    }
    
}
-(void)dayButtonClick:(UIButton *)sender{
//    NSInteger day = [[sender titleForState:UIControlStateNormal] integerValue];
//    NSString *dayStr = [NSString stringWithFormat:@"%zd-%02zd-%02zd",_beginDate.year,_beginDate.month,day];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    [dateFormatter setTimeZone:GTMzone];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date =[dateFormatter dateFromString:dayStr];
//    
//    [MonthCalendarOwner sharedMonthCalendarOwner].selectedDate = date;
//    if ([self.superview isKindOfClass:[UICollectionView class]]) {
//        [((UICollectionView *)self.superview) reloadData];
//    }
//    if (self.daySelect) {
//        self.daySelect(date);
//    }
}
@end
