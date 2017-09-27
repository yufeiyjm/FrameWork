//
//  LoginAlertVC.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/26.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginAlertVC : BaseViewController
@property (strong, nonatomic) void(^forgetPswClick)(void);
@property (strong, nonatomic) void(^registerClick)(void);
@end
