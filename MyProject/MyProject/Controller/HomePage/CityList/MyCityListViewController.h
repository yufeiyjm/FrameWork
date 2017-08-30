//
//  MyCityListViewController.h
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/2/24.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"
@interface MyCityListViewController : BaseViewController
@property(nonatomic,assign) BOOL isChina;
@property(nonatomic,strong) void(^citySelected)(NSString *cityName,NSString *cityId);
@property(nonatomic,strong) void(^cityChinaArr)(NSArray *cityArr);
@property(nonatomic,strong) void(^cityAbroadArr)(NSArray *cityArr);

@end
