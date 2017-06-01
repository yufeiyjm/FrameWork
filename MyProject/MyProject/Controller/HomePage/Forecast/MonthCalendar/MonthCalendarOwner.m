//
//  MonthCalendarOwner.m
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "MonthCalendarOwner.h"
static MonthCalendarOwner *daysOwner = nil;
@implementation MonthCalendarOwner
- (id)init
{
    self = [super init];
    if (self)
    {
        _selectedDate = [[NSDate date] copy];
        
    }
    return self;
}
+ (MonthCalendarOwner *)sharedMonthCalendarOwner
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        daysOwner = [[MonthCalendarOwner alloc] init];
    });
    return daysOwner;
}
@end
