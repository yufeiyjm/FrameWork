//
//  UIViewController+YJMNavigationExtension.m
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/26.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import "UIViewController+YJMNavigationExtension.h"
#import <objc/runtime.h>
@implementation UIViewController (YJMNavigationExtension)
- (BOOL)yjm_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYjm_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(yjm_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (YJMNavigationController *)yjm_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYjm_navigationController:(YJMNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(yjm_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

@end
