//
//  AirportListVC.h
//  MyProject
//
//  Created by jiaming yan on 2017/4/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"

@interface AirportListVC : BaseViewController
@property(nonatomic,strong) NSString *airport;

@property(nonatomic,strong) void(^selectAirport)(NSString *airport,NSString *cityName);

@end
