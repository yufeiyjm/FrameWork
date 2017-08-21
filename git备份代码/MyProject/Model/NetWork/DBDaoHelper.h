//
//  DBDaoHelper.h
//  SaintiFrameWork
//
//  Created by yan.jm on 14/11/6.
//  Copyright (c) 2014年 yan.jm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBDaoHelper : NSObject

/*
 方法说明:
 创建数据库表,这个方法一般在启动程序时调用。appdelegate中调用
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
+(BOOL)createAllTable;
/*
 方法说明:
 插入
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
//+(BOOL )insertNotePadWith:(NotePad *)notepad;

/*
 方法说明:
 查询
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
//+(NotePad *)selectNotePadNoteId:(int)noteId;
////修改便签信息
//+(void)updateNotePadWithNoteId:(int)noteId NotePad:(NotePad *)notepad;
////删除便签信息
//+(void)deleteWithNoteId:(NotePad *)notepad;
@end
