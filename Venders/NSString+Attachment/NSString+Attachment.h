//
//  Attributed.h
//  属性字符串
//
//  Created by HK_ALAKA on 15/8/13.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ZFEmotionAttrabutedStr @"ZFEmotionAttrabutedStr"
#define ZFEmotionPlaceHolderStr @"ZFEmotionPlaceHolderStr" 

#define SOUSEType @"SOUSEType"

#define SOUSETitle1 @"SOUSETitle1"
#define SOUSETitle2 @"SOUSETitle2"
#define SOUSETitle3 @"SOUSETitle3"

#define SOUSEContent1 @"SOUSEContent1"
#define SOUSEContent2 @"SOUSEContent2"
#define SOUSEContent3 @"SOUSEContent3"

#define SOUSEImage @"SOUSEImage"

#define SOUSEParameter @"SOUSEParameter"




@class UIFont;
@interface NSString (attachMent)
+(NSDictionary *)stringToAttributeString:(NSString *)text;
-(NSDictionary *)stringIsTypeofHouseSouse;
@end
