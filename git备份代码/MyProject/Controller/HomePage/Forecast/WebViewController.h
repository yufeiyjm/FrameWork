//
//  WebViewController.h
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/2/22.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property (strong, nonatomic) NSString *urlStr;
@property (assign, nonatomic) BOOL noShare;

@property (assign, nonatomic) BOOL privateUrl;
@property (assign, nonatomic) BOOL isPush;
@property (copy, nonatomic) NSString *shareTitleStr;
@property (copy, nonatomic) NSString *shareContentStr;
@property (copy, nonatomic) NSString *shareUrlStr;
@property (copy, nonatomic) NSString *shareImageUrlStr;
@end
