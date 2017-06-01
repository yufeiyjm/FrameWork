//
//  MonthCalendarOwner.h
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthCalendarOwner : NSObject
@property (nonatomic, copy) NSDate *beginDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, copy) NSDate *selectedDate;
+ (MonthCalendarOwner *)sharedMonthCalendarOwner;
@end
