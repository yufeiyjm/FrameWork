//
//  HomePageVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/4/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "HomePageVC.h"
#import "HMSegmentedControl.h"
#import "AirportListVC.h"
#import "TypePickerView.h"
#import "AirportListVC.h"
#import "MSSCalendarViewController.h"
#import "YJMNavigationController.h"
#import "ForecastTowVC.h"
#import "CitySelectedVC.h"

@interface HomePageVC ()<UIActionSheetDelegate,MSSCalendarViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *roundTripBack;
@property (weak, nonatomic) IBOutlet UIView *oneWayBack;

@property (weak, nonatomic) IBOutlet UILabel *leaveAirportTagLab;
@property (weak, nonatomic) IBOutlet UILabel *leaveAirportCityLab;
@property (weak, nonatomic) IBOutlet UILabel *goingAirportTagLab;
@property (weak, nonatomic) IBOutlet UILabel *goingAirportCityLab;

@property (weak, nonatomic) IBOutlet UILabel *oneWayDepartureDate;

@property (weak, nonatomic) IBOutlet UILabel *roundTripDepartureDate;
@property (weak, nonatomic) IBOutlet UILabel *roundTripReturnDate;

@property (weak, nonatomic) IBOutlet UILabel *passengerLab;
@property (weak, nonatomic) IBOutlet UILabel *cabinLab;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (nonatomic,assign)NSInteger oneWayDate;

@property (nonatomic,assign)NSInteger startDate;
@property (nonatomic,assign)NSInteger endDate;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"Search Flights", nil);
    self.navigationItem.leftBarButtonItems = nil;
    self.oneWayBack.alpha = 0;
    __block NSArray *hmsArr = @[NSLocalizedString(@"Round Trip", nil),NSLocalizedString(@"One Way", nil)];
    __weak typeof(self) weakSelf = self;
    HMSegmentedControl *segmentedControl3 = [[HMSegmentedControl alloc] initWithSectionTitles:hmsArr];
    [segmentedControl3 setFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.roundTripBack.alpha = 1;
                weakSelf.oneWayBack.alpha = 0;
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.roundTripBack.alpha = 0;
                weakSelf.oneWayBack.alpha = 1;
            }];
        }
    }];
    segmentedControl3.selectedSegmentIndex = 0;
    segmentedControl3.selectionIndicatorHeight = 4.0f;
    segmentedControl3.backgroundColor = UIColorFromRGB(0xC7DFEC);
    segmentedControl3.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x0080C0),NSFontAttributeName:k14Font};
    segmentedControl3.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:k14Font};
    segmentedControl3.selectionIndicatorColor = UIColorFromRGB(0xC7DFEC);
    segmentedControl3.selectionIndicatorColor = kWhiteColor;
    //    segmentedControl3.selectionIndicatorBoxColor = [UIColor blackColor];
    segmentedControl3.selectionIndicatorBoxOpacity = 1.0;
    segmentedControl3.selectionStyle = HMSegmentedControlSelectionStyleBox;
    //    segmentedControl3.selectedSegmentIndex = HMSegmentedControlNoSegment;
    segmentedControl3.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl3.shouldAnimateUserSelection = NO;
    segmentedControl3.tag = 2;
    [self.view addSubview:segmentedControl3];
    
    [self.checkButton setImage:IMAGE(@"icon_checkbox_unchecked") forState:UIControlStateNormal];
    [self.checkButton setImage:IMAGE(@"icon_checkbox_checked_checkout") forState:UIControlStateSelected];
    
    NSArray *arLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *strLang = [arLanguages objectAtIndex:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [NSString stringWithFormat:@"%@v1/route?area=%@",BASEURL,strLang];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /**获取当前系统语言的域名*/
                if ([result[@"result"] integerValue] == 1) {
                    [UrlSharedManager sharedManager].requestUrl = result[@"data"][@"server_addr"];
                }

            }
            
        });
        
    });
}
- (IBAction)leavingButtonClick:(id)sender {
    __weak typeof(self) weakSelf = self;
//    AirportListVC *vc = [[AirportListVC alloc]init];
//    vc.airport = NSLocalizedString(@"Departure City or Airport", nil);
//    vc.selectAirport = ^(NSString *airport,NSString *cityName){
//        weakSelf.leaveAirportTagLab.text = airport;
//        weakSelf.leaveAirportCityLab.text = cityName;
//        [weakSelf shakeAnimationForView:weakSelf.leaveAirportTagLab];
//        [weakSelf shakeAnimationForView:weakSelf.leaveAirportCityLab];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    CitySelectedVC *vc = [[CitySelectedVC alloc]init];
    vc.citySelected = ^(NSDictionary *cityDic){
        NSString *departure_City_name = cityDic[@"Departure_City_name"];
        if (departure_City_name.length > 0) {
            
            weakSelf.goingAirportTagLab.text = cityDic[@"Arrive_City_id"];
            weakSelf.goingAirportCityLab.text = cityDic[@"Arrive_City_name"];
            [weakSelf shakeAnimationForView:weakSelf.goingAirportTagLab];
            [weakSelf shakeAnimationForView:weakSelf.goingAirportCityLab];

            
            weakSelf.leaveAirportTagLab.text = cityDic[@"Departure_City_id"];
            weakSelf.leaveAirportCityLab.text = cityDic[@"Departure_City_name"];
            [weakSelf shakeAnimationForView:weakSelf.leaveAirportTagLab];
            [weakSelf shakeAnimationForView:weakSelf.leaveAirportCityLab];

            
        }else{
            NSString *cityId = cityDic[@"City_id"];
            if (cityId.length == 0) {
                [CommonUtils showToast:NSLocalizedString(@"The airline not opened, please be waite", nil)];
            }else{
                weakSelf.leaveAirportTagLab.text = cityDic[@"City_id"];
                weakSelf.leaveAirportCityLab.text = cityDic[@"City_name"];
                [weakSelf shakeAnimationForView:weakSelf.leaveAirportTagLab];
                [weakSelf shakeAnimationForView:weakSelf.leaveAirportCityLab];
                
            }

        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)goingButtonClick:(id)sender {
    __weak typeof(self) weakSelf = self;
//    AirportListVC *vc = [[AirportListVC alloc]init];
//    vc.airport = NSLocalizedString(@"Arrival City or Airport", nil);
//    vc.selectAirport = ^(NSString *airport,NSString *cityName){
//        weakSelf.goingAirportTagLab.text = airport;
//        weakSelf.goingAirportCityLab.text = cityName;
//        [weakSelf shakeAnimationForView:weakSelf.goingAirportTagLab];
//        [weakSelf shakeAnimationForView:weakSelf.goingAirportCityLab];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    CitySelectedVC *vc = [[CitySelectedVC alloc]init];
    vc.citySelected = ^(NSDictionary *cityDic){
        NSString *departure_City_name = cityDic[@"Departure_City_name"];
        if (departure_City_name.length > 0) {
            
            weakSelf.goingAirportTagLab.text = cityDic[@"Arrive_City_id"];
            weakSelf.goingAirportCityLab.text = cityDic[@"Arrive_City_name"];
            [weakSelf shakeAnimationForView:weakSelf.goingAirportTagLab];
            [weakSelf shakeAnimationForView:weakSelf.goingAirportCityLab];
            
            
            weakSelf.leaveAirportTagLab.text = cityDic[@"Departure_City_id"];
            weakSelf.leaveAirportCityLab.text = cityDic[@"Departure_City_name"];
            [weakSelf shakeAnimationForView:weakSelf.leaveAirportTagLab];
            [weakSelf shakeAnimationForView:weakSelf.leaveAirportCityLab];
            
            
        }else{
            NSString *cityId = cityDic[@"City_id"];
            if (cityId.length == 0) {
                [CommonUtils showToast:NSLocalizedString(@"The airline not opened, please be waite", nil)];
            }else{
                weakSelf.goingAirportTagLab.text = cityDic[@"City_id"];
                weakSelf.goingAirportCityLab.text = cityDic[@"City_name"];
                [weakSelf shakeAnimationForView:weakSelf.goingAirportTagLab];
                [weakSelf shakeAnimationForView:weakSelf.goingAirportCityLab];
                
            }
            
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)oneWayClick:(id)sender {
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    cvc.originStr = self.leaveAirportTagLab.text;
    cvc.destStr = self.goingAirportTagLab.text;
    cvc.limitMonth = 12 * 2;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.oneWay = YES;
    cvc.type = MSSCalendarViewControllerNextType;
    cvc.beforeTodayCanTouch = NO;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = YES;// 今天之前的日期是否可以点击
    cvc.startDate = _oneWayDate;// 选中开始时间
    cvc.endDate = _oneWayDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = YES;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    YJMNavigationController *nav = [[YJMNavigationController alloc]initWithRootViewController:cvc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate vc:(MSSCalendarViewController *)vc
{
    if (vc.oneWay) {
        _oneWayDate = startDate;
        _oneWayDate = endDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.locale = [NSLocale systemLocale];
        [dateFormatter setDateFormat: NSLocalizedString(@"EEE,MMM dd", nil)];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_oneWayDate]];
        _oneWayDepartureDate.text = startDateString;

    }else{
        _startDate = startDate;
        _endDate = endDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat: NSLocalizedString(@"EEE,MMM dd", nil)];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        NSString *endDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_endDate]];
        _roundTripDepartureDate.text = startDateString;
        _roundTripReturnDate.text = endDateString;
    }
 

}

- (IBAction)roundDepartureClick:(id)sender {
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    cvc.originStr = self.leaveAirportTagLab.text;
    cvc.destStr = self.goingAirportTagLab.text;
    cvc.limitMonth = 12 * 2;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.type = MSSCalendarViewControllerNextType;
    cvc.beforeTodayCanTouch = NO;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = YES;// 今天之前的日期是否可以点击
    cvc.startDate = _startDate;// 选中开始时间
    cvc.endDate = _endDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = NO;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    YJMNavigationController *nav = [[YJMNavigationController alloc]initWithRootViewController:cvc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)roundReturnClick:(id)sender {
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    cvc.originStr = self.leaveAirportTagLab.text;
    cvc.destStr = self.goingAirportTagLab.text;
    cvc.limitMonth = 12 * 2;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.type = MSSCalendarViewControllerNextType;
    cvc.beforeTodayCanTouch = NO;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = YES;// 今天之前的日期是否可以点击
    cvc.startDate = _startDate;// 选中开始时间
    cvc.endDate = _endDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = YES;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
    cvc.delegate = self;
    YJMNavigationController *nav = [[YJMNavigationController alloc]initWithRootViewController:cvc];
    [self presentViewController:nav animated:YES completion:nil];
}


- (IBAction)passengerClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    NSString *select = [self.passengerLab.text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" %@",NSLocalizedString(@"Passenger", nil)] withString:@""];
    TypePickerView *time = [[TypePickerView alloc]init];
    time.typeArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    time.selectPicker = ^(NSString *timeStr){
        weakSelf.passengerLab.text = [NSString stringWithFormat:@"%@ %@",timeStr,NSLocalizedString(@"Passenger", nil)];
        [weakSelf shakeAnimationForView:weakSelf.passengerLab];
    };
    [time creatTypePickerView:self.view];
    time.selected = [select integerValue] - 1;
}
- (IBAction)checkClick:(UIButton *)sender {
    sender.selected = !sender.selected;
//    CitySelectedVC *vc = [[CitySelectedVC alloc]init];
//    vc.citySelected = ^(NSString *cityName,NSString *cityId){
//        SaintiLog(@"%@---%@",cityId,cityName);
//        [CommonUtils showToast:cityName];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)searchcClick:(UIButton *)sender {
    ForecastTowVC *vc = [[ForecastTowVC alloc]init];
    vc.originStr = self.leaveAirportTagLab.text;
    vc.destStr = self.goingAirportTagLab.text;
    if (self.oneWayBack.alpha == 1) {
        if (_oneWayDate <= 0) {
            
            [CommonUtils showToast:NSLocalizedString(@"Please select travel time", nil)];
            return;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_oneWayDate]];
        
        vc.deptdateStr = startDateString;
        vc.returndateStr = startDateString;
        
    }else{
        if (_startDate <= 0) {
            
            [CommonUtils showToast:NSLocalizedString(@"Please select travel time", nil)];
            return;
        }if (_startDate <= 0) {
            [CommonUtils showToast:NSLocalizedString(@"Please select travel time", nil)];
            return;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        NSString *endDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_endDate]];
        
        vc.deptdateStr = startDateString;
        vc.returndateStr = endDateString;
    }

    
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)cabinClick:(id)sender {
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Cabin" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"Econnomy" otherButtonTitles:@"Preminum Econnomy",@"Business",@"First",  nil];
//    [sheet showInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cabin" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self addActionTarget:alert title:NSLocalizedString(@"Econnomy", nil) color: UIColorFromRGB(0x0A84C1) action:^(UIAlertAction *action) {
        weakSelf.cabinLab.text = NSLocalizedString(@"Econnomy", nil);
        [weakSelf shakeAnimationForView:weakSelf.cabinLab];
    }];
    [self addActionTarget:alert title:NSLocalizedString(@"Preminum Econnomy", nil) color: UIColorFromRGB(0x0A84C1) action:^(UIAlertAction *action) {
        weakSelf.cabinLab.text = NSLocalizedString(@"Preminum Econnomy", nil);
        [weakSelf shakeAnimationForView:weakSelf.cabinLab];
    }];
    
    [self addActionTarget:alert title:NSLocalizedString(@"Business", nil) color: UIColorFromRGB(0x0A84C1) action:^(UIAlertAction *action) {
        weakSelf.cabinLab.text = NSLocalizedString(@"Business", nil);
        [weakSelf shakeAnimationForView:weakSelf.cabinLab];
    }];
    
    [self addActionTarget:alert title:NSLocalizedString(@"First", nil) color: UIColorFromRGB(0x0A84C1) action:^(UIAlertAction *action) {
        weakSelf.cabinLab.text = NSLocalizedString(@"First", nil);
        [weakSelf shakeAnimationForView:weakSelf.cabinLab];
    }];
    [self addCancelActionTarget:alert title:NSLocalizedString(@"Cancel", nil)];
    [self presentViewController:alert animated:YES completion:nil];
}
// 取消按钮
-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:UIColorFromRGB(0x0A84C1) forKey:@"_titleTextColor"];
    [alertController addAction:action];
}
//添加对应的title    这个方法也可以传进一个数组的titles  我只传一个是为了方便实现每个title的对应的响应事件不同的需求不同的方法
- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  抖动效果
 *
 *  @param view 要抖动的view
 */
- (void)shakeAnimationForView:(UIView *) view {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        CALayer *viewLayer = view.layer;
        CGPoint position = viewLayer.position;
        CGPoint x = CGPointMake(position.x + 1, position.y);
        CGPoint y = CGPointMake(position.x - 1, position.y);
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        [animation setFromValue:[NSValue valueWithCGPoint:x]];
        [animation setToValue:[NSValue valueWithCGPoint:y]];
        [animation setAutoreverses:YES];
        [animation setDuration:.2];
        [animation setRepeatCount:3];
        [viewLayer addAnimation:animation forKey:nil];
    });

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
