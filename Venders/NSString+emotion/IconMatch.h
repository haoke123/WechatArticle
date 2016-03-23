//
//  IconMatch.h
//  MyTest
//
//  Created by weqia on 13-7-14.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BEGIN_TAG @"["
#define END_TAG  @"]"

@interface IconMatch : NSObject
{
    NSMutableArray * _strs;
}

-(NSArray*) Match:(NSString*) resource;

@end
