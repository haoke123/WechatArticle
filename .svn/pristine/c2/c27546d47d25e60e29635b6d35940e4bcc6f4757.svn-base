//
//  NSString+Pinyin.m
//  anHourse
//
//  Created by 找房 on 15/10/26.
//  Copyright © 2015年 HK_ALAKA. All rights reserved.
//

#import "NSString+Pinyin.h"

@implementation NSString(NSSting_Pinyin)
+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

+(NSDictionary *) getCategoryFromArray:(NSArray *) array{
    
    NSMutableDictionary * tarDict = [[NSMutableDictionary alloc]init];
    NSMutableArray * reg = [[NSMutableArray alloc]init];
    for (NSString * detail in array) {
        NSString * preHax = [NSString firstCharactor:detail];
        if([tarDict objectForKey:preHax]){
            NSMutableArray * tmpArray = tarDict[preHax];
            [tmpArray addObject:detail];
        }else{
            NSMutableArray * tmpArray = [[NSMutableArray alloc]init];
            [tmpArray addObject:detail];
            [tarDict setObject:tmpArray forKey:preHax];
        }
    }
    
    for (NSString * preHax in @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]) {
        
        if([tarDict objectForKey:preHax]){
            [reg addObject:preHax];
        }
    }
    [tarDict setObject:reg forKey:@"reg"];
    return tarDict;
}
+(NSDictionary *) getCategoryFromModelArray:(NSArray *)array{
    NSMutableDictionary * tarDict = [[NSMutableDictionary alloc]init];
    NSMutableArray * reg = [[NSMutableArray alloc]init];
    for (NSDictionary  * detailModel in array) {
        NSString * preHax = [NSString firstCharactor:detailModel[@"Name"]];
        if([tarDict objectForKey:preHax]){
            NSMutableArray * tmpArray = tarDict[preHax];
            [tmpArray addObject:detailModel];
        }else{
            NSMutableArray * tmpArray = [[NSMutableArray alloc]init];
            [tmpArray addObject:detailModel];
            [tarDict setObject:tmpArray forKey:preHax];
        }
    }
    for (NSString * preHax in @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]) {
        if([tarDict objectForKey:preHax]){
            [reg addObject:preHax];
        }
    }
    [tarDict setObject:reg forKey:@"reg"];
    
    
    return tarDict;
}
+(NSArray *) getCatogoryArrayFromModelArray:(NSArray *) array{

    NSMutableArray * tarArr = [[NSMutableArray alloc]init];
    [tarArr addObject:@{@"Name":@"不限区"}];
    NSDictionary * dict = [NSString getCategoryFromModelArray:array];
    
    NSArray * reg = dict[@"reg"];
    for (NSString * title in reg) {
        [tarArr addObject:@{@"Name":[NSString stringWithFormat:@"ZF-%@",title]}];
        
        [tarArr addObjectsFromArray:dict[title]];
        
    }
    return tarArr;
}
@end
