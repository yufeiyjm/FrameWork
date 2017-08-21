//
//  LGLCalenderViewController.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^SelectDateBalock)(NSMutableDictionary * paramas);

@interface LGLCalenderViewController : BaseViewController
@property (copy, nonatomic) NSString *originStr;
@property (copy, nonatomic) NSString *destStr;
@property (copy, nonatomic) NSString *deptdateStr;
@property (copy, nonatomic) NSString *returndateStr;
@property (nonatomic, copy) SelectDateBalock block;
- (void)seleDateWithBlock:(SelectDateBalock)block;

@end
