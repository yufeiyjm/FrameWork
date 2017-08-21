//
//  MonthCalendarView.h
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCalendarCollectionViewCell.h"
#import "NSDate+Category.h"
@class MonthCalendarView;
@protocol MonthCalendarViewDelegate <NSObject>

-(void)MonthCalendarView:(MonthCalendarView *)monthCalendarView didSelectDate:(NSDate *)selectDate;
-(void)MonthCalendarView:(MonthCalendarView *)monthCalendarView scrollToMonthDate:(NSDate *)date;

@end
@interface MonthCalendarView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)id<MonthCalendarViewDelegate> monthCalendarDelete;
@property (nonatomic, strong) NSDate *firstDate;

- (void)jumpToToday;
- (void)jumpToDate:(NSDate *)date;
@end
