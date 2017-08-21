//
//  UncaughtExceptionHandler.h
//  UncaughtExceptionHandler
//
//  Created by yan.jm on 15/6/29.
//  Copyright (c) 2015年 yan.jm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}


@end
void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void);