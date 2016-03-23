//
//  UIImage+FixOrientation.h
//  anHourse
//
//  Created by HK_ALAKA on 15/5/13.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_FixOrientatoion)

+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end
