//
//  UIImage+Compresse.h
//  imageScale
//
//  Created by HK_ALAKA on 15/3/3.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Compresse)

- (NSData*)toData;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
- (UIImage*)getSubImage:(CGRect)rect;
- (UIImage *) getSquartIconImage;
@end

