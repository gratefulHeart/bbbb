//
//  FMDataBaseHelper.h
//  dfsd
//
//  Created by z,k on 14-12-17.
//  Copyright (c) 2014年 zk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface FMDataBaseHelper : NSObject
{
    FMDatabase *db;
}
+(instancetype)shareInstance;

-(instancetype)initWithDBName:(NSString*)dbname;

#pragma mark 创建所有默认表
-(void)creatAllTables;

//插入一条数据
-(BOOL)insertNewDataToTableName:(NSString *)tableName withData:(NSDictionary *)strDict;
//插入多条数据
-(void)insertNewDataToTableName:(NSString *)tableName withArray:(NSArray *)arr;

//查询数据
-(NSArray *)queryDataFromTableName:(NSString *)tableName withParas:(NSDictionary *)dict;
//查询当天数据
-(NSArray *)queryTodayData;
//通过SQL查询数据
-(NSArray *)queryDataBySql:(NSString *)sql;

//删除数据某个表的数据 （全删）
-(void)removeSomeDataFromTableName:(NSString *)tableName withParas:(NSDictionary *)dict;
@end
