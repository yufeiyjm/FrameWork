//
//  TimeSelectView.m
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/3/2.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "TimeSelectView.h"

@implementation TimeSelectView

-(void)creatTimeSelectView:(UIView *)aView{
    self.tag =909090909;
    UIView *tempView = [aView viewWithTag:909090909];
    [tempView removeFromSuperview];
    if (!_timePicker) {
        self.backgroundColor = kWhiteColor;
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 256);
        [aView addSubview:self];
        
        _timePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0,40,kScreenWidth,216)];
        _timePicker.backgroundColor = kWhiteColor;
        _timePicker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_timePicker];
        
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:UIColorFromRGB(0xd5bb83) forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = k15Font;
        [cancleBtn setFrame:CGRectMake(20, 0, 44, 40)];
        [cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xd5bb83) forState:UIControlStateNormal];
        btn.titleLabel.font = k15Font;
        [btn setFrame:CGRectMake(kScreenWidth - 64, 0, 44, 40)];
        [btn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5)];
        line.backgroundColor =UIColorFromRGB(0xe1e1e1);
        [self addSubview:line];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight - 256 , kScreenWidth, 256);
    }];
}
-(void)cancleClick{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 256);
    }completion:^(BOOL finish){
        [self removeFromSuperview];
    }];
}
-(void)finishClick{
    NSDate* _date = _timePicker.date;
    
    /*添加你自己响应代码*/
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if (self.dateFormatterStr) {
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:self.dateFormatterStr];
    }
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:_date];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    if (self.selectTime) {
        self.selectTime(currentDateStr);
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, kScreenHeight , kScreenWidth, 256);
        }completion:^(BOOL finish){
            [self removeFromSuperview];
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
