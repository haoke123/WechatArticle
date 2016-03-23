//
//  IconMatch.m
//  MyTest
//
//  Created by weqia on 13-7-14.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "IconMatch.h"

@implementation IconMatch

#pragma -mark 初始化方法
-(id)init
{
    self =[super init];
    if(self){
        _strs=[NSMutableArray array];
    }
    return self;
}

#pragma -mark 私有方法
-(void)match:(NSString*) resource
{
    if(resource.length==0)
        return;
    NSRange end=[resource rangeOfString:END_TAG];
    if(end.location==NSNotFound)
    {
        [_strs addObject:resource];
        return;
    }else
    {
        NSString * string=[resource substringToIndex:end.location];
        if(string==nil)
        {
            [_strs addObject:resource];
            return;
        }else
        {
            NSRange begin=[string rangeOfString:BEGIN_TAG options:NSBackwardsSearch];
            if(begin.location==NSNotFound)
            {
                [_strs addObject:resource];
                return;
            }else{
                string=[string substringToIndex:begin.location];
                if([string length]>0){
                    [_strs addObject:string];
                }
                [_strs addObject:[resource substringWithRange:NSMakeRange(begin.location, end.location-begin.location+1)]];
                [self match:[resource substringFromIndex:end.location+1]];
            }
        }
    }    
}


#pragma -mark 接口方法
-(NSArray*) Match:(NSString*) resource
{
    [self match:resource];
    return _strs;
}


@end
