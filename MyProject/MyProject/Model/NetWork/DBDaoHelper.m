//
//  DBDaoHelper.m
//  SaintiFrameWork
//
//  Created by yan.jm on 14/11/6.
//  Copyright (c) 2014年 yan.jm. All rights reserved.
//

#import "DBDaoHelper.h"
#import "DBHelper.h"
@implementation DBDaoHelper
//创建数据库表
+(BOOL)createAllTable
{
    FMDatabase *db =[DBHelper openDatabase];
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS 'TABLE_Shopping_Cart'('cart_id'  INTEGER PRIMARY KEY AUTOINCREMENT,'goods_id' TEXT,'goods_name' TEXT,'goods_price' TEXT)"];
    
    [db close];
    if (result )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
////插入我的便签信息
//+(BOOL )insertNotePadWith:(NotePad *)notepad
//{
//    FMDatabase *db =[DBHelper openDatabase];
//    BOOL result = [db executeUpdate:@"INSERT INTO 'TABLE_NOTE'('note_color','note_text','note_datetime','note_week','note_clocktime') VALUES(?,?,?,?,?)",notepad.strNoteColor,notepad.strNoteText,notepad.strNoteDateTime,notepad.strNoteWeek,notepad.strClockTime];
//    [db close];
//    return result;
//}
//
////根据id查询便签信息
//+(NotePad *)selectNotePadNoteId:(int)noteId
//{
//    FMDatabase *db =[DBHelper openDatabase];
//    //执行查询语句
//    FMResultSet *result = [db executeQuery:@"SELECT * FROM TABLE_NOTE WHERE note_id = ?",[NSString stringWithFormat:@"%d",noteId]];
//    
//    NotePad *note = [[[NotePad alloc]init]autorelease];
//    while (result.next)
//    {
//        //根据列名取得数据
//        int noteId = [result intForColumn:@"note_id"];
//        NSString *strNoteColor = [result stringForColumn:@"note_color"];
//        NSString *strNoteText = [result stringForColumn:@"note_text"];
//        NSString *strNoteDateTime = [result stringForColumn:@"note_datetime"];
//        NSString *strNoteWeek = [result stringForColumn:@"note_week"];
//        NSString *strClockTime = [result stringForColumn:@"note_clocktime"];
//        note.noteId = noteId;
//        note.strNoteColor = strNoteColor;
//        note.strNoteText = strNoteText;
//        note.strNoteDateTime = strNoteDateTime;
//        note.strNoteWeek = strNoteWeek;
//        note.strClockTime = strClockTime;
//    }
//    return note;
//}
//
////修改便签信息
//+(void)updateNotePadWithNoteId:(int)noteId NotePad:(NotePad *)notepad
//{
//    FMDatabase *db = [DBHelper openDatabase];
//    [db executeUpdate:@"UPDATE TABLE_NOTE SET note_text = ?,note_datetime = ?,note_week = ?,note_color = ?,note_clocktime = ? WHERE note_id = ?",notepad.strNoteText,notepad.strNoteDateTime,notepad.strNoteWeek,notepad.strNoteColor,notepad.strClockTime,[NSString stringWithFormat:@"%d",noteId]];
//    [db close];
//}
////删除便签信息
//+(void)deleteWithNoteId:(NotePad *)notepad
//{
//    FMDatabase *db = [DBHelper openDatabase];
//    [db executeUpdate:@"DELETE FROM TABLE_NOTE WHERE note_id = ?",[NSString stringWithFormat:@"%d",notepad.noteId]];
//    [db close];
//}
@end
