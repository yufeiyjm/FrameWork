//
//  AppDelegate.h
//  MyProject
//
//  Created by yanjiaming on 17/3/10.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbarController;

-(void)gotoLogin;
-(void)gotoHome;
@end

