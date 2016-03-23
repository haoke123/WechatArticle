//
//  Attributed.m
//  属性字符串
//
//  Created by HK_ALAKA on 15/8/13.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import "NSString+Attachment.h"
#import <UIKit/UIKit.h>
#import "IconMatch.h"
#import "UIImage+Compress.h"
#import "EmotionViewConst.h"
#define ICON_SIZE 24.0f
#define LINE_HEIGHT 24.0f
#define SPACE_WIDTH 2.0f
@implementation NSString (attachMent)

-(NSDictionary *)stringIsTypeofHouseSouse
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *zhengze = @"^<(房源|客源)><([\\s\\S^>]+)><([\\s\\S^>]+)><([\\s\\S^>]+)><([\\s\\S^>]+)><([\\s\\S^>]+)><([\\s\\S^>]+)><([\\s\\S^>]+)><(\\d+)>$";
    
    NSPredicate * regPreDicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",zhengze];
    if([regPreDicate evaluateWithObject:self]){
        
        NSMutableString * str = [[NSMutableString alloc]initWithString:self];
      NSString *  tar = [str substringWithRange:NSMakeRange(1, str.length -2)];
        
        NSArray * array = [tar componentsSeparatedByString:@"><"];
        if(array.count ==9){
            [dict setValue:array[0] forKey:SOUSEType];
            [dict setValue:array[1] forKey:SOUSETitle1];
            [dict setValue:array[2] forKey:SOUSETitle2];
            [dict setValue:array[3] forKey:SOUSETitle3];
            [dict setValue:array[4] forKey:SOUSEContent1];
            [dict setValue:array[5] forKey:SOUSEContent2];
            [dict setValue:array[6] forKey:SOUSEContent3];
            [dict setValue:array[7] forKey:SOUSEImage];
            [dict setValue:array[8] forKey:SOUSEParameter];

            
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    return dict;
    
}



+(NSDictionary *)stringToAttributeString:(NSString *)text
{

    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    NSMutableString * tarStr = [[NSMutableString alloc]initWithString:text];
   
   
    NSString * zhengze = @"\\[[a-zA-Z0-9\u4e00-\u9fa5]+\\]"; //正则表达式 ,例如  [呵呵] 这种形式的通配符

    NSError * error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:&error];//正则表达式
    if (!re)
    {
        //NSLog(@"%@",[error localizedDescription]);//打印错误
        return nil;
    }

    NSArray * arr = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];//遍历字符串,获得所有的匹配字符串
    
    if(arr.count ==0){
        return nil;
    }
   // NSBundle *bundle = [NSBundle bundleWithPath:@"EmotionIcons.bundle"];
   NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@/info",EmotionBundelName,EmotionDefaultFolder] ofType:@"plist"];
   NSArray * face = [[NSArray alloc]initWithContentsOfFile:path];  //获取 所有的数组
    
   // NSLog(@"表情数组%@",face);
//    
//    //如果有多个表情图，必须从后往前替换，因为替换后Range就不准确了
    for (int j =(int) arr.count - 1; j >= 0; j--) {
        //NSTextCheckingResult里面包含range
        NSTextCheckingResult * result = arr[j];
        for (int i = 0; i < face.count; i++) {
            if ([[text substringWithRange:result.range] isEqualToString:face[i][@"chs"]])//从数组中的字典中取元素
            {
                NSTextAttachment * textAttachment = [[NSTextAttachment alloc]init];//添加附
                [textAttachment setBounds:CGRectMake(0, -5, 22, 22)];
                UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,EmotionDefaultFolder,face[i][@"png"]]];
               // textAttachment.image = [UIImage imageWithContentsOfFile:path];
                textAttachment.image = image;
                
                NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                [attStr replaceCharactersInRange:result.range withAttributedString:imageStr];//替换未图片附件
                [tarStr replaceCharactersInRange:result.range withString:@"xxx"];
                break;
            }
            
            
            
        }
    }
    //NSLog(@"属性：%@",attStr);
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attStr addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attStr.length)];
    return @{ZFEmotionAttrabutedStr:attStr,ZFEmotionPlaceHolderStr:tarStr};
}

@end
