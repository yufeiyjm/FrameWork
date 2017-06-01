//
//  OrderListViewController.h
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/26.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
@interface OrderListViewController : BaseViewController<ZJScrollPageViewChildVcDelegate>
@property(nonatomic,assign) NSInteger selectIndex;

@end
