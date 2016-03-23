//
//  FMDBManager.m
//  WechatArticle
//
//  Created by 找房 on 15/12/19.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "FMDBManager.h"

#import "WeichatArticleModel.h"

@implementation FMDBManager


+(NSString *)databaseFilePath
{

    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentPath = [filePath objectAtIndex:0];
    
    NSLog(@"%@",filePath);
    
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"articles.sqlite"];
    
    return dbFilePath;
	 
}
+ (FMDatabase *) manager{

    static FMDatabase * Manager = nil;
    
    
    if(Manager==nil){

        Manager = [FMDatabase databaseWithPath:[FMDBManager databaseFilePath]];
    
    }
    return Manager;
}
+(void)creatTable
{
    //先判断数据库是否存在，如果不存在，创建数据库
    if (![FMDBManager manager]) {
        [FMDBManager manager];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![[FMDBManager manager] open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [[FMDBManager manager] setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![[FMDBManager manager]  tableExists:@"Article"])
    {
        [[FMDBManager manager] executeUpdate:@"CREATE TABLE Article (id TEXT, title TEXT , content TEXT, cover TEXT, fromStr TEXT, type TEXT, url TEXT, userlogo TEXT, date TEXT, typeid TEXT, userlogocode TEXT, isFave TEXT) "];
        
        
        NSLog(@"创建完成");
    }

}
+(void)insertModel:(WeichatArticleModel *)model
{
    
    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:@"Article"])
    {
        [FMDBManager creatTable];
    }
    //以上操作与创建表是做的判断逻辑相同
    //现在表中查询有没有相同的元素，如果有，做修改操作
    FMResultSet *rs = [db executeQuery:@"select * from Article where id = ?",model.ID];
    if([rs next])
    {
        return;
      
       // [db executeUpdate:@"update Article set url = ?, age = ? where people_id = 1",aPeople.name,[NSStringstringWithFormat:@"%d",aPeople.age]];
    }
    //向数据库中插入一条数据
    else{
        [db executeUpdate:@"INSERT INTO Article (id,title,content,cover,fromStr,type,url,userlogo,date,typeid,userlogocode,isFave) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",model.ID,model.title,model.contentImg,model.weiNum,model.userName,model.typeName,model.url,model.userLogo,model.date,model.typeId,model.userLogo_code,@"No"];
    }
 
}
+(void)Fave:(WeichatArticleModel *)model withIsFave:(BOOL) isFave
{
    
    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:@"Article"])
    {
        [FMDBManager creatTable];
    }
    //以上操作与创建表是做的判断逻辑相同
    //现在表中查询有没有相同的元素，如果有，做修改操作
    FMResultSet *rs = [db executeQuery:@"select * from Article where id = ?",model.ID];
    if([rs next])
    {
        
        [db executeUpdate:@"update Article set isFave = ? where id = ?",isFave?@"Yes":@"No",model.ID];
        
        return;
        
        // [db executeUpdate:@"update Article set url = ?, age = ? where people_id = 1",aPeople.name,[NSStringstringWithFormat:@"%d",aPeople.age]];
    }
    //向数据库中插入一条数据
    else{
        [db executeUpdate:@"INSERT INTO Article (id,title,content,cover,fromStr,type,url,userlogo,date,typeid,userlogocode,isFave) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",model.ID,model.title,model.contentImg,model.weiNum,model.userName,model.typeName,model.url,model.userLogo,model.date,model.typeId,model.userLogo_code,@"No"];
    }
    [db close];
    
}

+(void) deleteArticlesIsFave:(BOOL) isFave{


    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    [db setShouldCacheStatements:YES];
    
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if(![db tableExists:@"Article"])
    {
        return;
    }
    //删除操作
    if (isFave) {
        [db executeUpdate:@"delete from Article where isFave = ?", @"Yes"];
    }else{
        [db executeUpdate:@"delete from Article where isFave = ?",  @"No"];
    }
    [db close];
}
+(BOOL) isArticleExists:(NSString *) url{

    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    [db setShouldCacheStatements:YES];
    
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if(![db tableExists:@"Article"])
    {
        return NO;
    }
    else{
        FMResultSet *rs = [db executeQuery:@"select * from Article where url = ?",url];
        if([rs next])
        {
            [db close];
            return YES;
            // [db executeUpdate:@"update Article set url = ?, age = ? where people_id = 1",aPeople.name,[NSStringstringWithFormat:@"%d",aPeople.age]];
        }
        else{
        [db close];
            return NO;
        }
    }
}
+(BOOL) isArticleHasFaved:(NSString *) url{
    
    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    [db setShouldCacheStatements:YES];
    
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if(![db tableExists:@"Article"])
    {
        return NO;
    }
    else{
        FMResultSet *rs = [db executeQuery:@"select * from Article where url = ?",url];
        if([rs next])
        {
            
            
            WeichatArticleModel * model = [[WeichatArticleModel alloc]init];
            
            model.ID = [rs stringForColumn:@"id"];
            
            model.contentImg = [rs stringForColumn:@"content"];
            
            model.date = [rs stringForColumn:@"date"];
            
            model.title = [rs stringForColumn:@"title"];
            
            model.typeId = [rs stringForColumn:@"typeid"];
            
            model.typeName = [rs stringForColumn:@"type"];
            
            model.url = [rs stringForColumn:@"url"];
            
            model.userLogo = [rs stringForColumn:@"userlogo"];
            
            model.userLogo_code = [rs stringForColumn:@"userlogocode"];
            
            model.userName = [rs stringForColumn:@"fromStr"];
            model.weiNum = [rs stringForColumn:@"cover"];
            
            model.isFave = [[rs stringForColumn:@"isFave"] isEqualToString:@"Yes"]?YES:NO;
            
            [db close];
            
            return model.isFave;
            
           
            // [db executeUpdate:@"update Article set url = ?, age = ? where people_id = 1",aPeople.name,[NSStringstringWithFormat:@"%d",aPeople.age]];
        }
        else{
            [db close];
            return NO;
        }
    }
}

+(NSArray *) selectHistory{


    NSMutableArray * historyArr= [[NSMutableArray alloc]init];
    
    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:@"Article"])
    {
        [FMDBManager creatTable];
    }
    //以上操作与创建表是做的判断逻辑相同
    //现在表中查询有没有相同的元素，如果有，做修改操作
    FMResultSet *rs = [db executeQuery:@"select * from Article"];
    
    while ([rs next])
    {
        
        WeichatArticleModel * model = [[WeichatArticleModel alloc]init];
        
        model.ID = [rs stringForColumn:@"id"];
        
        model.contentImg = [rs stringForColumn:@"content"];
        
        model.date = [rs stringForColumn:@"date"];
        
        model.title = [rs stringForColumn:@"title"];
        
        model.typeId = [rs stringForColumn:@"typeid"];
        
        model.typeName = [rs stringForColumn:@"type"];
        
        model.url = [rs stringForColumn:@"url"];
        
        model.userLogo = [rs stringForColumn:@"userlogo"];
        
        model.userLogo_code = [rs stringForColumn:@"userlogocode"];
        
        model.userName = [rs stringForColumn:@"fromStr"];
        
        model.weiNum = [rs stringForColumn:@"cover"];
        
        model.isFave = [[rs stringForColumn:@"isFave"] isEqualToString:@"Yes"]?YES:NO;
        
        [historyArr insertObject:model atIndex:0];
    }
    [db close];
    return [historyArr copy];

}
+(NSArray *) selectFaverate{
    
    
    NSMutableArray * historyArr= [[NSMutableArray alloc]init];
    
    FMDatabase * db = [FMDBManager manager];
    
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:@"Article"])
    {
        [FMDBManager creatTable];
    }
    //以上操作与创建表是做的判断逻辑相同
    //现在表中查询有没有相同的元素，如果有，做修改操作
    FMResultSet *rs = [db executeQuery:@"select * from Article where isFave = ?",@"Yes"];
    while ([rs next])
    {
        
        WeichatArticleModel * model = [[WeichatArticleModel alloc]init];
        
        model.ID = [rs stringForColumn:@"id"];
        
        model.contentImg = [rs stringForColumn:@"content"];
        
        model.date = [rs stringForColumn:@"date"];
        
        model.title = [rs stringForColumn:@"title"];
        
        model.typeId = [rs stringForColumn:@"typeid"];
        
        model.typeName = [rs stringForColumn:@"type"];
        
        model.url = [rs stringForColumn:@"url"];
        
        model.userLogo = [rs stringForColumn:@"userlogo"];
        
        model.userLogo_code = [rs stringForColumn:@"userlogocode"];
        
        model.userName = [rs stringForColumn:@"fromStr"];
        
        model.weiNum = [rs stringForColumn:@"cover"];
        
        model.isFave = [[rs stringForColumn:@"isFave"] isEqualToString:@"Yes"]?YES:NO;
        
        [historyArr insertObject:model atIndex:0];
    }
    [db close];
    
    return [historyArr copy];
}

@end
