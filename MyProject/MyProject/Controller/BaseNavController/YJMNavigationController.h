//
//  YJMViewController.h
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/26.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YJMWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (YJMWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end
@interface YJMNavigationController : UINavigationController
@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *yjm_viewControllers;
@end
