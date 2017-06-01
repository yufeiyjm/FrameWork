//
//  ForecastTowVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/4/14.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ForecastTowVC.h"
#import "LGLCalenderViewController.h"
#import "WebViewController.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "NSString+Expand.h"
@interface ForecastTowVC ()
@property (weak, nonatomic) IBOutlet UILabel *airportLab;
@property (weak, nonatomic) IBOutlet UILabel *recommendLab;
@property (weak, nonatomic) IBOutlet UILabel *departureLab;
@property (weak, nonatomic) IBOutlet UILabel *arriveLab;

@end

@implementation ForecastTowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"Price Forecast", nil);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 64, 44);
    [backBtn setTitle:NSLocalizedString(@"Shop", nil) forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(futureClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
    
    // Enable and disable various graph properties and axis displays
    self.myGraph.delegate = self;
    self.myGraph.dataSource = self;
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableYAxisLabel = YES;
    self.myGraph.autoScaleYAxis = YES;
    self.myGraph.alwaysDisplayDots = NO;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    
//    // Draw an average line
//    self.myGraph.averageLine.enableAverageLine = YES;
//    self.myGraph.averageLine.alpha = 0.6;
//    self.myGraph.averageLine.color = [UIColor redColor];
//    self.myGraph.averageLine.width = 2.5;
//    self.myGraph.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.myGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.myGraph.formatStringForValues = @"%.0f";
    

    self.myGraph.colorTop = [UIColor whiteColor];;
    self.myGraph.colorBottom = UIColorFromRGB(0x0AC775);
    
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGFloat locations[] = {0.0, 0.5, 1.0};
    
    // 创建 颜色1
    CGFloat beginColor[] = {10/255.0, 199.0/255, 117.0/255,1};
    CGColorRef beginColorRef = CGColorCreate(spaceRef, beginColor);
    
    // 创建 颜色2
    CGFloat midColor[] = {177/255.0, 255.0/255, 209.0/255,1};
    CGColorRef midColorRef = CGColorCreate(spaceRef, midColor);
    
    // 创建 颜色3
    CGFloat endColor[] = {1,1,1,1};
    CGColorRef endColorRef = CGColorCreate(spaceRef, endColor);
    
    // 创建颜色数组
    CFArrayRef colorArrayRef = CFArrayCreate(kCFAllocatorDefault,
                                             (const void*[]){beginColorRef, midColorRef,endColorRef},
                                             3,
                                             nil);
    
    // 渐变
    CGGradientRef gradeRef2 =  CGGradientCreateWithColors(spaceRef,
                                                          colorArrayRef,
                                                          locations);
    
    self.myGraph.gradientBottom = gradeRef2;
    //    gradientBottom

    self.myGraph.colorXaxisLabel = kBlackColor;UIColorFromRGB(0X333333);
    self.myGraph.colorYaxisLabel = kBlackColor;UIColorFromRGB(0X333333);
    
    self.myGraph.colorBackgroundXaxis = [UIColor whiteColor];
    //    self.myGraph.alphaBottom = 0.5;
    
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    self.myGraph.enableBezierCurve = NO;
    self.myGraph.colorLine = [UIColor lightGrayColor];
    self.myGraph.alphaBackgroundYaxis = 1;
//    self.myGraph.enableReferenceXAxisLines = NO;
    self.myGraph.enableTopReferenceAxisFrameLine = YES;
    self.myGraph.enableLeftReferenceAxisFrameLine = YES;
    self.myGraph.enableBottomReferenceAxisFrameLine = YES;
    self.myGraph.labelFont = [UIFont boldSystemFontOfSize:9.0F];
    self.myGraph.widthLine = 1;
    
    self.airportLab.text = [NSString stringWithFormat:@"%@-%@",self.originStr,self.destStr];
    self.departureLab.text = self.deptdateStr;
    self.arriveLab.text = self.returndateStr;
    __weak typeof(self) weakSelf = self;
    //GCD执行耗时操作
    [self showProgressWithView:self.view animated:YES];
    [SendRequest requestRecommendWithOrigin:self.originStr dest:self.destStr deptdate:self.deptdateStr returndate:self.returndateStr result:^(id result, NSError *error){
        /**本次旅行的最低票价*/
        if ([result[@"result"] integerValue] == 1) {
            

            if ([result[@"data"][@"buynow"] integerValue] == 1) {
                
                NSString *str = [NSString stringWithFormat:@"Buy:\nThe fare will go up with %.2f%@ probability. Buy now at $%.2f.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
                
                NSArray *arLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
                NSString *strLang = [arLanguages objectAtIndex:0];
                NSLog(@"LANG:%@",strLang);
                if ([strLang isEqualToString:@"zh-Hans-CN"]) {
                    if ([result[@"data"][@"prob"] floatValue] > 0.85) {
                        str = [NSString stringWithFormat:@"立即购买:\n机票价格上涨的概率超过%.2f%@. 现在购买价格:$%.2f.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
                    }else if ([result[@"data"][@"prob"] floatValue] > 0.5) {
                        str = [NSString stringWithFormat:@"购买:\n机票价格上涨的概率超过%.2f%@ . 现在购买价格:$%.2f.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
                    }
                    //                NSString *str = [NSString stringWithFormat:@"Buy Now\n%@Go%@Back\n\n机票价格将不会回落，建议立即购买%.2f%@",weakSelf.deptdateStr,weakSelf.returndateStr,[result[@"data"][@"prob"] floatValue]*100,@"%"];
                    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str];
                    if ([result[@"data"][@"prob"] floatValue] > 0.85) {
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"立即购买:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"立即购买:"]]; //设置字体颜色
                        
                    }else if ([result[@"data"][@"prob"] floatValue] > 0.5) {
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:@"购买:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"购买:"]]; //设置字体颜色
                    }else{
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:@"购买:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:[str rangeOfString:@"购买:"]]; //设置字体颜色
                    }
                    
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"%.2f%@",[result[@"data"][@"prob"] floatValue]*100,@"%"]]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"$%@",result[@"data"][@"current_fare"]]]]; //设置字体颜色
                    weakSelf.recommendLab.attributedText = strAtt;
                }else{
                    if ([result[@"data"][@"prob"] floatValue] > 0.85) {
                        str = [NSString stringWithFormat:@"Buy Now:\nThe fare will go up with %.2f%@ probability. Buy now at $%.2f.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
                    }else if ([result[@"data"][@"prob"] floatValue] > 0.5) {
                        str = [NSString stringWithFormat:@"Buy Soon:\nThe fare will go up with %.2f%@ probability. Buy now at $%.2f.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
                    }
                    //                NSString *str = [NSString stringWithFormat:@"Buy Now\n%@Go%@Back\n\n机票价格将不会回落，建议立即购买%.2f%@",weakSelf.deptdateStr,weakSelf.returndateStr,[result[@"data"][@"prob"] floatValue]*100,@"%"];
                    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str];
                    if ([result[@"data"][@"prob"] floatValue] > 0.85) {
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"Buy Now:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"Buy Now:"]]; //设置字体颜色
                        
                    }else if ([result[@"data"][@"prob"] floatValue] > 0.5) {
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:@"Buy Now:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"Buy Now:"]]; //设置字体颜色
                    }else{
                        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:@"Buy:"]]; //设置字体颜色
                        [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:[str rangeOfString:@"Buy:"]]; //设置字体颜色
                    }
                    
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"%.2f%@",[result[@"data"][@"prob"] floatValue]*100,@"%"]]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"$%@",result[@"data"][@"current_fare"]]]]; //设置字体颜色
                    weakSelf.recommendLab.attributedText = strAtt;
                }
                
                
            }else{
                NSString *str = [NSString stringWithFormat:@"Wait:\nThe fare will decrease with %.2f%@ probability from $%.2f at the moment.",[result[@"data"][@"prob"] floatValue]*100,@"%",[result[@"data"][@"current_fare"] floatValue]];
//                 NSString *str = [NSString stringWithFormat:@"Please Wait\n%@Go%@Back\n\n机票价格在未来可能回落，建议等待%.2f%@",weakSelf.deptdateStr,weakSelf.returndateStr,[result[@"data"][@"prob"] floatValue]*100,@"%"];
                
                
                NSArray *arLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
                NSString *strLang = [arLanguages objectAtIndex:0];
                NSLog(@"LANG:%@",strLang);
                if ([strLang isEqualToString:@"zh-Hans-CN"]) {
                    str = [NSString stringWithFormat:@"等待:\n票价从现在$%.2f降低的概率超过%.2f%@",[result[@"data"][@"current_fare"] floatValue],[result[@"data"][@"prob"] floatValue]*100,@"%"];
                    //                 NSString *str = [NSString stringWithFormat:@"Please Wait\n%@Go%@Back\n\n机票价格在未来可能回落，建议等待%.2f%@",weakSelf.deptdateStr,weakSelf.returndateStr,[result[@"data"][@"prob"] floatValue]*100,@"%"];
                    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str];
                    
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"等待:"]]; //设置字体颜色
                    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"等待:"]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"%.2f%@",[result[@"data"][@"prob"] floatValue]*100,@"%"]]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"$%@",result[@"data"][@"current_fare"]]]]; //设置字体颜色
                    weakSelf.recommendLab.attributedText = strAtt;
                }else{
                    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:str];
                    
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:@"Wait:"]]; //设置字体颜色
                    [strAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[str rangeOfString:@"Wait:"]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"%.2f%@",[result[@"data"][@"prob"] floatValue]*100,@"%"]]]; //设置字体颜色
                    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str rangeOfString:[NSString stringWithFormat:@"$%@",result[@"data"][@"current_fare"]]]]; //设置字体颜色
                    weakSelf.recommendLab.attributedText = strAtt;
                }
                
            }
            
            
            
            
            [SendRequest requestHistoryWithOrigin:self.originStr dest:self.destStr deptdate:self.deptdateStr returndate:self.returndateStr result:^(id result, NSError *error){
                /**本次旅行的最低票价*/
                [weakSelf hideProgress:self.view animated:YES];
                if ([result[@"result"] integerValue] == 1) {
                    //            [weakSelf hydrateDatasets];
                    if (!weakSelf.arrayOfValues) weakSelf.arrayOfValues = [[NSMutableArray alloc] init];
                    if (!weakSelf.arrayOfDates) weakSelf.arrayOfDates = [[NSMutableArray alloc] init];
                    [weakSelf.arrayOfValues removeAllObjects];
                    [weakSelf.arrayOfDates removeAllObjects];
                    NSArray *tempArr = result[@"data"][@"fareinfo"];
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    df.dateFormat = @"yyyy-MM-dd";
                    
//                    NSMutableArray *xDataArr = [NSMutableArray array];
//                    NSMutableArray *xNameArr = [NSMutableArray array];
//                    [weakSelf.arrayOfValues addObject:@(0)];
//                    [weakSelf.arrayOfDates addObject:@"起点"];
                    for (NSInteger i = (tempArr.count - 1) ; i > 0; i--) {
                        
                        [weakSelf.arrayOfValues addObject:@([tempArr[i][@"lowestfare"] floatValue])];
                        NSDate *tempDate = [df dateFromString:tempArr[i][@"observationdate"]];
                        NSDateFormatter *dformatter = [[NSDateFormatter alloc] init];
                        dformatter.dateFormat = @"MM/dd";
                        
                        [weakSelf.arrayOfDates addObject:[dformatter stringFromDate:tempDate]];
                        
//                        NSDateFormatter *dformatter = [[NSDateFormatter alloc] init];
//                        dformatter.dateFormat = @"dd";
//                        NSString *strDay = [dformatter stringFromDate:tempDate];
//                        [xNameArr addObject:strDay];
//                        [xDataArr addObject:@([tempArr[i][@"lowestfare"] floatValue])];
                    }

                    [weakSelf.myGraph reloadGraph];
                    
                
                    
//                    
//                    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300.0)];
//                    // 设置x轴上坐标内容
//                    [lineChart setXLabels:xNameArr];
//                    // 设置好像没什么用
//                    lineChart.xLabelColor = UIColorFromRGB(0x0D84BF);
//                    
//                    lineChart.showLabel = YES;
//                    // 是否显示Y轴的数值
//                    lineChart.showGenYLabels = YES;
//                    // 是否显示横向虚线
//                    lineChart.showYGridLines = YES;
//                    // 是否平滑的曲线
//                    lineChart.showSmoothLines = NO;
//                    // 是否显示xy 坐标轴
//                    lineChart.showCoordinateAxis = YES;
//                    // 轴的颜色
//                    lineChart.axisColor = UIColorFromRGB(0x0D84BF);
//                    // 轴的宽度
//                    lineChart.axisWidth = 1.0f;
//                    
//                    NSLog(@"%f",lineChart.chartMarginLeft);
//                    
//                    //    lineChart.thousandsSeparator = YES;
//                    // 设置y轴坐标的颜色
//                    lineChart.yLabelColor = UIColorFromRGB(0x0D84BF);
//                    
//                    // Line Chart No.1
//                    NSArray * data01Array = xDataArr;
//                    PNLineChartData *data01 = [PNLineChartData new];
//                    data01.color = PNFreshGreen;
//                    data01.dataTitle = @"Hello World";
//                    // 设置点的格式
//                    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
//                    data01.inflexionPointColor = UIColorFromRGB(0x0D84BF);
//                    // 是否点label
////                    data01.showPointLabel = YES;
//                    data01.pointLabelColor = [UIColor redColor];
//                    data01.pointLabelFont = [UIFont systemFontOfSize:12];
//                    data01.pointLabelFormat = @"%1.1f";
//                    // 设置折线有几个值
//                    data01.itemCount = lineChart.xLabels.count;
//                    data01.inflexionPointWidth = 5;
//                    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
//                    data01.getData = ^(NSUInteger index) {
//                        CGFloat yValue = [data01Array[index] floatValue];
//                        
//                        // 设置x轴坐标对应的y轴的值
//                        return [PNLineChartDataItem dataItemWithY:yValue];
//                    };
//                    lineChart.showYGridLines = YES;
//                    
//                    //设置坐标轴宽度
//                    
//                    lineChart.axisWidth = 2.0;
//                    
//                    lineChart.showSmoothLines = YES;
//                    
//                    // Line Chart No.2
//                    //        NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
//                    //        PNLineChartData *data02 = [PNLineChartData new];
//                    //        data02.color = PNTwitterColor;
//                    //        data02.itemCount = lineChart.xLabels.count;
//                    //        data02.getData = ^(NSUInteger index) {
//                    //            CGFloat yValue = [data02Array[index] floatValue];
//                    //            return [PNLineChartDataItem dataItemWithY:yValue];
//                    //        };
//                    // 设置line的数据数组
//                    lineChart.chartData = @[data01];
//                    [lineChart setYValueMin:0];
//                    [lineChart setYValueMax:2000];
//                    // 绘制出来
//                    [lineChart strokeChart];
//                    
//                    [weakSelf.myGraph addSubview:lineChart];
                    
                    
                    
                }
                
            }];
        }else{
            [weakSelf hideProgress:self.view animated:YES];
 
        }
        
    }];
}
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"lineIndex = %zd",lineIndex);
}

-(void)futureClick{
    [self showProgressWithView:self.view animated:YES];
    [SendRequest requestCityCodeWithTerm:self.originStr  result:^(id resultDeparture, NSError *error){
        if ([resultDeparture[@"result"] integerValue] == 1) {
            NSArray *departureArr = resultDeparture[@"data"];
            if (departureArr.count != 0) {
                [SendRequest requestCityCodeWithTerm:self.destStr  result:^(id resultArrive, NSError *error){
                    [self hideProgress:self.view animated:YES];
                    if ([resultArrive[@"result"] integerValue] == 1) {
                        NSArray *arriveArr = resultArrive[@"data"];
                        if (arriveArr.count != 0) {
                           
                            WebViewController *vc = [[WebViewController alloc]init];
                            vc.urlStr = [NSString stringWithFormat:@"http://m.ctrip.com/html5/flight/matrix/matrix-list-intl.html?dcity=%@&acity=%@&dport=&aport=&trip=2&ddate1=%@&ddate2=%@",resultDeparture[@"data"][0][@"city_code"],resultArrive[@"data"][0][@"city_code"],self.deptdateStr,self.returndateStr];
                            if ([resultDeparture[@"data"][0][@"city_code"] isEqualToString:@"QSF"]) {
                                vc.urlStr = [NSString stringWithFormat:@"http://m.ctrip.com/html5/flight/matrix/matrix-list-intl.html?dcity=%@&acity=%@&dport=&aport=&trip=2&ddate1=%@&ddate2=%@",@"SFO",resultArrive[@"data"][0][@"city_code"],self.deptdateStr,self.returndateStr];
                            }
                            if ([resultDeparture[@"data"][0][@"city_code"] isEqualToString:@"QLA"]) {
                                vc.urlStr = [NSString stringWithFormat:@"http://m.ctrip.com/html5/flight/matrix/matrix-list-intl.html?dcity=%@&acity=%@&dport=&aport=&trip=2&ddate1=%@&ddate2=%@",@"LAX",resultArrive[@"data"][0][@"city_code"],self.deptdateStr,self.returndateStr];
                            }
                            if ([resultArrive[@"data"][0][@"city_code"] isEqualToString:@"QSF"]) {
                                vc.urlStr = [NSString stringWithFormat:@"http://m.ctrip.com/html5/flight/matrix/matrix-list-intl.html?dcity=%@&acity=%@&dport=&aport=&trip=2&ddate1=%@&ddate2=%@",resultDeparture[@"data"][0][@"city_code"],@"SFO",self.deptdateStr,self.returndateStr];
                            }
                            if ([resultArrive[@"data"][0][@"city_code"] isEqualToString:@"QLA"]) {
                                vc.urlStr = [NSString stringWithFormat:@"http://m.ctrip.com/html5/flight/matrix/matrix-list-intl.html?dcity=%@&acity=%@&dport=&aport=&trip=2&ddate1=%@&ddate2=%@",resultDeparture[@"data"][0][@"city_code"],@"LAX",self.deptdateStr,self.returndateStr];
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                    }
                    
                }];
            }else{
                [self hideProgress:self.view animated:YES];
            }
            
            
        }else{
            [self hideProgress:self.view animated:YES];
        }
        
    }];
    


//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    ctl.originStr = self.originStr;
//    ctl.destStr = self.destStr;
//    ctl.deptdateStr = self.deptdateStr;
//    ctl.returndateStr = self.returndateStr;
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
////        NSString * date = [NSString stringWithFormat:@"%@-%@-%@", paramas[@"year"], paramas[@"month"], paramas[@"day"]];
////        NSString * price = paramas[@"price"];
////        self.date.text = date;
////        self.price.text = price;
//    }];
//    [self.navigationController pushViewController:ctl animated:YES];
}
//- (void)hydrateDatasets {
//    // Reset the arrays of values (Y-Axis points) and dates (X-Axis points / labels)
//
//    
////    NSInteger previousStepperValue = 0;
//    NSInteger totalNumber = 0;
//    NSDate *baseDate = [NSDate date];
//    BOOL showNullValue = true;
//    
//    // Add objects to the array based on the stepper value
//    for (int i = 0; i < 30; i++) {
//        [self.arrayOfValues addObject:@([self getRandomFloat])]; // Random values for the graph
//        if (i == 0) {
//            [self.arrayOfDates addObject:baseDate]; // Dates for the X-Axis of the graph
//        } else if (showNullValue && i == 4) {
//            [self.arrayOfDates addObject:[self dateForGraphAfterDate:self.arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
//            self.arrayOfValues[i] = @(BEMNullGraphValue);
//        } else {
//            [self.arrayOfDates addObject:[self dateForGraphAfterDate:self.arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
//        }
//        
//        totalNumber = totalNumber + [[self.arrayOfValues objectAtIndex:i] intValue]; // All of the values added together
//    }
//}
//- (float)getRandomFloat {
//    float i1 = (float)(arc4random() % 1000000) / 100 ;
//    return i1;
//}
//- (NSDate *)dateForGraphAfterDate:(NSDate *)date {
//    NSTimeInterval secondsInTwentyFourHours = 24 * 60 * 60;
//    NSDate *newDate = [date dateByAddingTimeInterval:secondsInTwentyFourHours];
//    return newDate;
//}

- (NSString *)labelForDateAtIndex:(NSInteger)index {
//    NSDate *date = self.arrayOfDates[index];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    df.dateFormat = @"MM/dd";
//    NSString *label = [df stringFromDate:date];
//    NSLog(@"%zd---- %@",index,label);
    
    NSString *label = self.arrayOfDates[index];
    return label;
}
#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.arrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.arrayOfValues objectAtIndex:index] doubleValue];
}
- (CGFloat)minValueForLineGraph:(BEMSimpleLineGraphView *)graph{
    return 0;
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    NSString *label = [self labelForDateAtIndex:index];
    NSString *result = [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    return result;
}
//- (CGFloat)staticPaddingForLineGraph:(BEMSimpleLineGraphView *)graph{
//    return 23;
//}
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
//    self.labelValues.text = [NSString stringWithFormat:@"%@", [self.arrayOfValues objectAtIndex:index]];
//    self.labelDates.text = [NSString stringWithFormat:@"in %@", [self labelForDateAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.labelValues.alpha = 0.0;
//        self.labelDates.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//        self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
//        
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.labelValues.alpha = 1.0;
//            self.labelDates.alpha = 1.0;
//        } completion:nil];
//    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
//    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
}

/* - (void)lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph {
 // Use this method for tasks after the graph has finished drawing
 } */

- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
    return @"$";
}
//- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph{
//    return @"JINE";
//}
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
