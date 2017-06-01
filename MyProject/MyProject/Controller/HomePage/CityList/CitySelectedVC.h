//
//  CitySelectedVC.h
//  MyProject
//
//  Created by jiaming yan on 2017/5/27.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageView.h"
#import "CityListVC.h"

@interface CitySelectedVC : BaseViewController<ZJScrollPageViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(nonatomic,strong) void(^citySelected)(NSDictionary *cityDic);

@end
