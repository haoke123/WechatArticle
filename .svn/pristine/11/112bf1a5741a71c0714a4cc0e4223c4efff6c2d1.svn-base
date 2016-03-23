//
//  FMDBManager.h
//  WechatArticle
//
//  Created by 找房 on 15/12/19.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@class WeichatArticleModel;
@interface FMDBManager : NSObject
+ (FMDatabase *) manager;
+ (void)creatTable;
+(BOOL) isArticleExists:(NSString *) url;
+(void)insertModel:(WeichatArticleModel *)model;
+(NSArray *) selectHistory;
+(NSArray *) selectFaverate;
+(BOOL) isArticleHasFaved:(NSString *) url;
+(void)Fave:(WeichatArticleModel *)model withIsFave:(BOOL) isFave;
+(void) deleteArticlesIsFave:(BOOL) isFave;
@end
