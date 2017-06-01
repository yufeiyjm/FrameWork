//
//  MonthCalendarVC.h
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "BaseViewController.h"

@interface MonthCalendarVC : BaseViewController
@property(nonatomic,strong) void(^daySelect)(NSDate *date);

@end
