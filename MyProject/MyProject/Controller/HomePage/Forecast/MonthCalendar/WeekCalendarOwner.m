//
//  WeekCalendarOwner.m
//  ClubProject
//
//  Created by jiaming yan on 2017/4/28.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "WeekCalendarOwner.h"
static WeekCalendarOwner *daysOwner = nil;
@implementation WeekCalendarOwner
- (id)init
{
    self = [super init];
    if (self)
    {
        _selectedDate = [[NSDate date] copy];

    }
    return self;
}
+ (WeekCalendarOwner *)sharedWeekCalendarOwner
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        daysOwner = [[WeekCalendarOwner alloc] init];
    });
    return daysOwner;
}
@end
