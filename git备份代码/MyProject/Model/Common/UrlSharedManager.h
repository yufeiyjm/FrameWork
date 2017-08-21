//
//  UrlSharedManager.h
//  MyProject
//
//  Created by jiaming yan on 2017/5/26.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlSharedManager : NSObject
@property (strong, nonatomic) NSString *requestUrl;

+(UrlSharedManager *)sharedManager;
@end
