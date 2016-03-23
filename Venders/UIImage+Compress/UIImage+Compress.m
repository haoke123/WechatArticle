//
//  UIImage+Compresse.m
//  imageScale
//
//  Created by HK_ALAKA on 15/3/3.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import "UIImage+Compress.h"

#import "UIImage+ResizeMagick.h"


@implementation UIImage (Compresse)

- (NSData*)toData
{
    if ([self isKindOfClass:[UIImage class]]) {
        
        NSData *data = UIImageJPEGRepresentation(self, 0.75f);
        
        return data;
    }
    else return nil;
}

//截取部分图像
- (UIImage*)getSubImage:(CGRect)rect
{
    return  [self croppedImageWithRect:CGRectMake(0, 0, self.size.width, self.size.width)];
//    UIGraphicsBeginImageContext(rect.size);
//    [self drawInRect: rect];
//    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return resizedImage;
//    //
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    
    return smallImage;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{

    UIGraphicsBeginImageContext(size);

    [img drawInRect:CGRectMake(0,0, size.width, size.height)];

    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (UIImage *) getSquartIconImage{
   return [self croppedImageWithRect:CGRectMake(0, 0, self.size.width, self.size.width)];
   // return [self getSubImage:CGRectMake(0, 0, self.size.width, self.size.width)];

}
@end

