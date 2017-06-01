//
//  CityListVC.h
//  MyProject
//
//  Created by jiaming yan on 2017/5/27.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface CityListVC : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic,assign) BOOL isChina;
@property(nonatomic,strong) void(^citySelected)(NSDictionary *cityDic);
@property(nonatomic,strong) void(^cityChinaArr)(NSArray *cityArr);
@property(nonatomic,strong) void(^cityAbroadArr)(NSArray *cityArr);
@end
