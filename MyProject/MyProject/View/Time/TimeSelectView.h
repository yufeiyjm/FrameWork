//
//  TimeSelectView.h
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/3/2.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectView : UIView
@property (strong, nonatomic) UIDatePicker *timePicker;
@property (strong, nonatomic) NSString *dateFormatterStr;
@property(nonatomic,strong) void(^selectTime)(NSString *timeStr);

-(void)creatTimeSelectView:(UIView *)aView;
@end
