//
//  ForecastTowVC.h
//  MyProject
//
//  Created by jiaming yan on 2017/4/14.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"
#import "BEMSimpleLineGraphView.h"

@interface ForecastTowVC : BaseViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;

@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@property (assign, nonatomic) BOOL oneWay;
@property (copy, nonatomic) NSString *originStr;
@property (copy, nonatomic) NSString *destStr;
@property (copy, nonatomic) NSString *deptdateStr;
@property (copy, nonatomic) NSString *returndateStr;
@end
