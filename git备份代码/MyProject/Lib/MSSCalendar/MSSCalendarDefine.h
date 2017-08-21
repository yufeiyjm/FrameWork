//
//  MSSCalendarDefine.h
//  MSSCalendar
//
//  Created by 于威 on 16/4/4.
//  Copyright © 2016年 于威. All rights reserved.
//

#define MSS_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define MSS_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MSS_UTILS_COLORRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define MSS_Iphone6Scale(x) ((x) * MSS_SCREEN_WIDTH / 375.0f)
#define MSS_ONE_PIXEL 0.5

/*定义属性*/
// 周末颜色

#define MSS_WeekTitleTextColor UIColorFromRGB(0xB2B3B3)
// DateLabel默认文字颜色
#define MSS_TextColor UIColorFromRGB(0x0A84C1)
// DateLabel选中时的背景色
#define MSS_SelectBackgroundColor UIColorFromRGB(0x3673AA)
// DateLabel选中后文字颜色
#define MSS_SelectTextColor [UIColor whiteColor]
// SubLabel文字颜色
#define MSS_SelectSubLabelTextColor UIColorFromRGB(0x0A84C1);
// SubLabel选中开始文字
#define MSS_SelectBeginText @"去程"
// SubLabel选中结束文字
#define MSS_SelectEndText @"返程"
// DateLabel选中后文字颜色
#define MSS_SelectEndTextColor UIColorFromRGB(0x000000)
// 节日颜色
#define MSS_HolidayTextColor UIColorFromRGB(0x0A84C1)
// 周末颜色
#define MSS_WeekEndTextColor UIColorFromRGB(0x0A84C1)
// 不可点击文字颜色
#define MSS_TouchUnableTextColor UIColorFromRGB(0x9DCEE7)
// 周视图高度
#define MSS_WeekViewHeight 20
// headerView线颜色
#define MSS_HeaderViewLineColor UIColorFromRGB(0xe0e0e0)
// headerView文字颜色
#define MSS_HeaderViewTextColor [UIColor blackColor]
// headerView高度
#define MSS_HeaderViewHeight 30
// 弹出层文字颜色
#define MSS_CalendarPopViewTextColor [UIColor whiteColor]
// 弹出层背景颜色
#define MSS_CalendarPopViewBackgroundColor [UIColor blackColor]


