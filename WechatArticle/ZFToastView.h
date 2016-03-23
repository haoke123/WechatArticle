//
//  ZFToastView.h
//  anHourse
//
//  Created by 找房 on 15/10/24.
//  Copyright © 2015年 HK_ALAKA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM( NSInteger , ZFToastPosition){

    ZFToastPositionTop =0,
    ZFToastPositionCenter =1,
    ZFToastPositionBottom =2,
    ZFToastPositionLeft =3,
    ZFToastPositionRight =4,
    ZFToastPositionRadom =5,
    ZFToastPositionBottomWithBarHigh = 6,


};


@interface ZFToastView : UIView
@property (nonatomic,strong)  UILabel * ContentLabel;
@property (nonatomic,strong) UIColor * backColor;
+(void) showDefaultToastMessage:(NSString *)message;
+(void) showToastMessage:(NSString * ) message withPosition:(ZFToastPosition) position;
@end
