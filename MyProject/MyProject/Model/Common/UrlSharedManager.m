//
//  UrlSharedManager.m
//  MyProject
//
//  Created by jiaming yan on 2017/5/26.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "UrlSharedManager.h"

@implementation UrlSharedManager
+(UrlSharedManager *)sharedManager{
    static UrlSharedManager *manager = nil;
    @synchronized(self){
        if(manager == nil){
            manager = [[UrlSharedManager alloc]init];
        }
    }
    return manager;
}
@end
