//
//  FMDataBaseHelper.m
//  dfsd
//
//  Created by z,k on 14-12-17.
//  Copyright (c) 2014年 zk. All rights reserved.
//

#import "FMDataBaseHelper.h"
#import "LKDBUtils.h"

@implementation FMDataBaseHelper


+(instancetype)shareInstance
{
    static id _shareInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareInstance = [[self alloc]initWithDBName:@"gfy"];
        
    });
    
    return _shareInstance;
    
}
-(NSString*)getDBPathWithDBName:(NSString*)dbName
{
    NSString* fileName = nil;
    if([dbName hasSuffix:@".db"] == NO) {
        fileName = [NSString stringWithFormat:@"%@.db",dbName];
    }
    else {
        fileName = dbName;
    }
    
    NSString* filePath = [LKDBUtils getPathForDocuments:fileName inDir:@"db"];
    return filePath;
}


-(instancetype)initWithDBName:(NSString*)dbname
{
    
    db = [[FMDatabase alloc]initWithPath:[self getDBPathWithDBName:dbname]];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
        [db close];
        return nil;
    }
    
    
//    [self creatAllTables];
//    [self createUserTableViewWithName:@"User"];
    [self createOneTable];
    return self;
    
//    return [self initWithDBPath:[self getDBPathWithDBName:dbname]];
    
    
}
-(void)createOneTable
{
    
    NSString *sql = @"CREATE TABLE  if not exists  dg_info (serial integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,dgName TEXT DEFAULT NULL,goinTime TEXT DEFAULT NULL,gooutTime TEXT DEFAULT NULL,customerType TEXT DEFAULT NULL,experienceType TEXT DEFAULT NULL,memberType TEXT DEFAULT NULL,costAmount TEXT DEFAULT NULL,note TEXT DEFAULT NULL,customerName TEXT DEFAULT NULL,buySomething TEXT DEFAULT NULL,dateStr TEXT DEFAULT NULL)";
//    NSString *sql = @"CREATE TABLE  if not exists dg_info (serial integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,dgName TEXT DEFAULT NULL,goinTime TEXT DEFAULT NULL,gooutTime TEXT DEFAULT NULL,customerType TEXT DEFAULT NULL,experienceType TEXT DEFAULT NULL,memberType TEXT DEFAULT NULL,costAmount TEXT DEFAULT NULL,note TEXT DEFAULT NULL,customerName TEXT DEFAULT NULL,buySomething TEXT DEFAULT NULL)";

    BOOL ret = [db executeUpdate:sql];
    if(ret)
    {
        NSLog(@"创建表成功");
//        return YES;
    }
    else
    {
        NSLog(@"创建表失败");
//        return NO;
    }

}
#pragma mark 创建所有默认表
-(void)creatAllTables
{
    NSDictionary *tablePropertys =[FMDataBaseHelper getAllTablesProperties];
    
    NSArray *allTableNames  =[tablePropertys allKeys];
    for (int i=0; i<[allTableNames count]; i++) {
        NSString *tableName =[allTableNames objectAtIndex:i];
        NSArray *tableProperties =[tablePropertys objectForKey:tableName];
        
        [self getOrCreatTableWithTablename:tableName withKeyNames:tableProperties];
    }

}


#pragma mark 获取所有已定义的表的详细信息
+(NSDictionary *)getAllTablesProperties
{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TablePropertys" ofType:@"plist"]];
}
#pragma mark 创建表
-(BOOL)getOrCreatTableWithTablename:(NSString *)tableName withKeyNames:(NSArray *)keyNames
{
    if (tableName == nil ||keyNames == nil ||keyNames.count<1) {
        NSLog(@"创建表传的名字为空");
        return NO;
    }
    
    
    NSString *sql =nil;
    sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,",tableName];
    for (int i = 0; i < [keyNames count]; i ++){
        sql =[sql stringByAppendingFormat:@"%@ text DEFAULT %@,", [keyNames objectAtIndex:i],@"0"];
    }
    sql = [sql substringToIndex:sql.length -1];
    sql = [sql stringByAppendingFormat:@"%@",@")"];
    
    BOOL ret = [db executeUpdate:sql];
    if(ret)
    {
        NSLog(@"创建表成功%@",tableName);
        return YES;
    }
    else
    {
        NSLog(@"创建表失败%@",tableName);
        return NO;
    }

    
    
}

//插入数据
-(BOOL)insertNewDataToTableName:(NSString *)tableName withData:(NSDictionary *)strDict
{
//    NSString *sql = [NSString stringWithFormat:@"insert into %@  (%@,%@,%@) values(?, ?, ?)",tableName,@"",@"",@""];
    tableName = @"dg_info";

    NSString *sqll = @"insert into ";

    NSString *str1 = @"(";
    NSString *str2 = @"(";
    for(int i = 0 ;i< [[strDict allKeys] count];i++)
    {
        if(i == [[strDict allKeys] count]-1)
        {
            str1 = [str1 stringByAppendingFormat:@"'%@')",[[strDict allKeys] objectAtIndex:i]];
            str2 = [str2 stringByAppendingFormat:@"'%@')",[strDict objectForKey:[[strDict allKeys] objectAtIndex:i]]];
        }
        else
        {
            str1 = [str1 stringByAppendingFormat:@"'%@',",[[strDict allKeys] objectAtIndex:i]];
            str2 = [str2 stringByAppendingFormat:@"'%@',",[strDict objectForKey:[[strDict allKeys] objectAtIndex:i]]];
        }
    }
    
    sqll = [sqll stringByAppendingFormat:@"%@ %@ values%@",tableName,str1,str2];
    NSLog(@"插入数据的 sqll = %@",sqll);
    
    
//    BOOL ret = [db executeUpdate:sql,@"",@"",@""];
    
    BOOL ret = [db executeUpdate:sqll];
    
    if(!ret)
    {
        NSLog(@" 数据库插入失败:%@",[db lastErrorMessage]);
        [AllTools messageViewWithText:[db lastErrorMessage]];
    }
    else
    {
        NSLog(@"数据库插入成功");
    }
    
    return ret;
}
//插入多条数据
-(void)insertNewDataToTableName:(NSString *)tableName withArray:(NSArray *)arr
{
    [db beginTransaction];//准备插入数据记录
    
    for(id item in arr)
    {
        [self insertNewDataToTableName:tableName withData:item];
    }
    [db commit];//执行插入记录
    //批量提交  效率高

}


//删除数据
-(void)removeSomeDataFromTableName:(NSString *)tableName withParas:(NSDictionary *)dict
{
//    NSString *sql = [NSString stringWithFormat:@"delete * from %@ where id = %@",tableName,@""];
    NSString *sql = [NSString stringWithFormat:@"delete  from %@ ",tableName];

    BOOL ret = [db executeUpdate:sql];

    if(!ret)
    {
        NSLog(@"数据库删除失败");
    }
    else
    {
        NSLog(@"数据库删除成功");
    }

}
//查询数据
-(NSArray *)queryDataFromTableName:(NSString *)tableName withParas:(NSDictionary *)dict
{
    tableName = @"dg_info";
    NSString *sqlStr = @"";
    if (dict == nil) {
        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ ",tableName];
    }
    else
    {
        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where %@='%@'",tableName,[[dict allKeys] firstObject],[[dict allValues] firstObject]];
    }
    
//    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where %@='%@'",tableName,[[dict allKeys] firstObject],[[dict allValues] firstObject]];

    NSMutableArray *arrr = [NSMutableArray array];
    
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {
        
//        NSString *name = [rs stringForColumn:@"Name"];
        NSDictionary *dict = [rs  resultDictionary];
        [arrr addObject:dict];
        
    }
    
    [rs close];
    
    return arrr;
    
    
}

-(NSArray *)queryDataBySql:(NSString *)sql
{
//    tableName = @"dg_info";
//    NSString *sqlStr = @"";
//    if (dict == nil) {
//        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ ",tableName];
//    }
//    else
//    {
//        sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where %@='%@'",tableName,[[dict allKeys] firstObject],[[dict allValues] firstObject]];
//    }
    
    //    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where %@='%@'",tableName,[[dict allKeys] firstObject],[[dict allValues] firstObject]];
    
    if (sql == nil||[sql isEqualToString:@""]) {
        return nil;
    }
    
    
    NSMutableArray *arrr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        //        NSString *name = [rs stringForColumn:@"Name"];
        NSDictionary *dict = [rs  resultDictionary];
        [arrr addObject:dict];
        
    }
    
    [rs close];
    
    return arrr;
    
    
}
//查询当天数据
-(NSArray *)queryTodayData
{
    NSString *tableName = @"dg_info";
    NSDateFormatter *fm = [NSDateFormatter defaultDateFormatter];
    [fm setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [fm stringFromDate:[NSDate date]];
    
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where dateStr='%@'",tableName,dateStr];
    NSMutableArray *arrr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {

        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[rs  resultDictionary]];
        [dict removeObjectForKey:@"serial"];
        [arrr addObject:dict];
        
    }
    
    [rs close];
    
    return arrr;
    
    
}
//修改数据
-(void)modifyDataToTableName:(NSString *)tableName withParas:(NSDictionary *)dict
{
//    NSString *sql = [NSString stringWithFormat:@"UPDATE shopCar_tb SET num = '%d' WHERE id = %d",num,row];
//    [db executeUpdate:sql];
}

#pragma mark 删除表
-(BOOL)deleteTableWithTableName:(NSString *)tableName
{
    NSString *sql =[NSString stringWithFormat:@"drop table %@",tableName];
    
    BOOL ret = [db executeUpdate:sql];
    
    if(ret)
    {
        NSLog(@"删除表成功");
    }
    else
    {
        NSLog(@"删除表失败");
    }
    return ret;
    
    
//    char *errorMsg =nil;
//    int exec_result = sqlite3_exec(_db, [sql UTF8String], Nil, Nil, &errorMsg);
//    if (exec_result ==SQLITE_OK) {
//        NSLog(@"db----------表   %@   删除成功",tableName);
//        return YES;
//    }else{
//        NSLog(@"db----------表   %@   删除失败  error%s",tableName,errorMsg);
//        return NO;
//    }
}



@end
