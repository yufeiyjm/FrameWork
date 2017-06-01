//
//  DBHelper.h
//  ZXFrameWork
//
//  Created by 智享 on 14-8-18.
//  Copyright (c) 2014年 智享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DBHelper : NSObject
+(FMDatabase *)openDatabase;
@end
