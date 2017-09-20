//
//  AppDelegate.m
//  MyProject
//
//  Created by yanjiaming on 17/3/10.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageVC.h"
#import "YJMNavigationController.h"
#import "AssessmentHomeVC.h"
#import "GossipListVC.h"
#import "SpecialworkListVC.h"
#import "UncaughtExceptionHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    InstallUncaughtExceptionHandler();
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self gotoHome];
    return YES;
}
-(void)gotoHome{
    
    HomePageVC *homePage = [[HomePageVC alloc]init];
    YJMNavigationController *homeNav = [[YJMNavigationController alloc]initWithRootViewController:homePage];
    //    homeNav.navigationBarHidden = YES;
    homeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"包您入职" image:IMAGE(@"包您入职（未选中）") selectedImage:IMAGE(@"包您入职（未选中）")];
    
    
    AssessmentHomeVC *homePage1 = [[AssessmentHomeVC alloc]init];
    YJMNavigationController *homeNav1 = [[YJMNavigationController alloc]initWithRootViewController:homePage1];
    homeNav1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"测评" image:IMAGE(@"测评（未选中）") selectedImage:IMAGE(@"测评（未选中）")];
    
    GossipListVC *homePage2 = [[GossipListVC alloc]init];
    YJMNavigationController *homeNav2 = [[YJMNavigationController alloc]initWithRootViewController:homePage2];
    homeNav2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"职场八卦" image:IMAGE(@"职场八卦（未选中）") selectedImage:IMAGE(@"职场八卦（未选中）")];
    
    SpecialworkListVC *chatController = [[SpecialworkListVC alloc]init];
    //    chatController.hidesBottomBarWhenPushed = YES;
    //    chatController.lblTitle.text = @"客服";
    
    //    MessageListVC *homePage3 = [[MessageListVC alloc]init];
    YJMNavigationController *homeNav3 = [[YJMNavigationController alloc]initWithRootViewController:chatController];
    homeNav3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"职来职往" image:IMAGE(@"职来职往（未选中）") selectedImage:IMAGE(@"职来职往（未选中）")];
    
    self.tabbarController = [[UITabBarController alloc]init];
    self.tabbarController.tabBar.tintColor = UIColorFromRGB(0x169eae);
    self.tabbarController.delegate = self;
    [self.tabbarController.tabBar setBarTintColor:kBlackColor];
    self.tabbarController.viewControllers =[NSArray arrayWithObjects:homeNav,homeNav1,homeNav2,homeNav3, nil];
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];

   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
