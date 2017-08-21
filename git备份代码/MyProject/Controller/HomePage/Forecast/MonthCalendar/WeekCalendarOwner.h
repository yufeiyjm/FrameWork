//
//  WeekCalendarOwner.h
//  ClubProject
//
//  Created by jiaming yan on 2017/4/28.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekCalendarOwner : NSObject
@property (nonatomic, copy) NSDate *beginDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, copy) NSDate *selectedDate;
+ (WeekCalendarOwner *)sharedWeekCalendarOwner;
@end
