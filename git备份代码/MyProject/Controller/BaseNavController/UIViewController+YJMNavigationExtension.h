//
//  UIViewController+YJMNavigationExtension.h
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/26.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMNavigationController.h"
@interface UIViewController (YJMNavigationExtension)
@property (nonatomic, assign) BOOL yjm_fullScreenPopGestureEnabled;

@property (nonatomic, weak) YJMNavigationController *yjm_navigationController;
@end
