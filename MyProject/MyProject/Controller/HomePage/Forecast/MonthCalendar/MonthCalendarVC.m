//
//  MonthCalendarVC.m
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "MonthCalendarVC.h"
#import "MonthCalendarView.h"
#import "WeekCalendarOwner.h"

@interface MonthCalendarVC ()<MonthCalendarViewDelegate>
@property (nonatomic, strong) MonthCalendarView *monthCalendar;
@property (nonatomic, strong) UILabel *monthLab;
@property (nonatomic, strong) UILabel *yearLab;

@end

@implementation MonthCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = kClearColor;
//    UIButton *backView = [UIButton buttonWithType:UIButtonTypeCustom];
//    backView.frame = [UIScreen mainScreen].bounds;
//    [backView addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventAllEvents];
//    [backView setBackgroundColor:kBlackColor];
//    backView.alpha = 0.3;
//    [self.view addSubview:backView];
    
    [self.view addSubview:self.monthCalendar];
    
    [self loadNavgationBar];
    
}
-(void)loadNavgationBar{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    NSDate *nowDate = [WeekCalendarOwner sharedWeekCalendarOwner].selectedDate;
    _yearLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    _yearLab.font = k18Font;
    _yearLab.text = [NSString stringWithFormat:@"%zd年",nowDate.year];
    _yearLab.textAlignment = NSTextAlignmentCenter;
    _yearLab.textColor = kWhiteColor;
    UIBarButtonItem *yearItem = [[UIBarButtonItem alloc]initWithCustomView:_yearLab];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,yearItem];
    
    
    
    
    _monthLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleView.mj_w, 44)];
    _monthLab.font = k18Font;
    _monthLab.text = [NSString stringWithFormat:@"%zd月",nowDate.month];
    _monthLab.textAlignment = NSTextAlignmentCenter;
    _monthLab.textColor = kWhiteColor;
    [titleView addSubview:_monthLab];
    
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftImage.contentMode = UIViewContentModeCenter;
    leftImage.image = IMAGE(@"14-右");
    [titleView addSubview:leftImage];
    
    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(titleView.mj_w - 10, 0, 10, 44)];
    rightImage.contentMode = UIViewContentModeCenter;
    rightImage.image = IMAGE(@"14-左");
    [titleView addSubview:rightImage];
    
    UIButton *closeButton = [CommonUtils creatButtonWithFrame:CGRectMake(0, 0, 27, 44) title:@"" titleColor:kWhiteColor font:k15Font taget:self select:@selector(closeClick)];
    //    calendarButton.backgroundColor = kRedColor;
    [closeButton setImage:IMAGE(@"14-关闭") forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    UIBarButtonItem *closeSpacer = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                    target:nil action:nil];
    closeSpacer.width = 20;
    self.navigationItem.rightBarButtonItems = @[rightItem,closeSpacer];
}
-(MonthCalendarView *)monthCalendar{
    if (!_monthCalendar) {
        _monthCalendar = [[MonthCalendarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 38*6 + 25)];
        _monthCalendar.backgroundColor = UIColorFromRGB(0xFFC849);
        _monthCalendar.monthCalendarDelete = self;
        _monthCalendar.firstDate = [WeekCalendarOwner sharedWeekCalendarOwner].selectedDate;
    }
    return _monthCalendar;
}
-(void)MonthCalendarView:(MonthCalendarView *)monthCalendarView didSelectDate:(NSDate *)selectDate{
    NSLog(@"%@",selectDate);
    if (self.daySelect) {
        self.daySelect(selectDate);
    }
    [self closeClick];
}
-(void)MonthCalendarView:(MonthCalendarView *)monthCalendarView scrollToMonthDate:(NSDate *)date{
    _monthLab.text = [NSString stringWithFormat:@"%zd月",date.month];
    _yearLab.text = [NSString stringWithFormat:@"%zd年",date.year];

}
-(void)closeClick{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
