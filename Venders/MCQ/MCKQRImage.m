//
//  MCKQRImage.m
//  MCKCustomQRImage
//
//  Created by MCKing on 15/9/21.
//
//

#import "MCKQRImage.h"

@implementation MCKQRImage

+ (UIImage *)getQRImageWithInforString:(NSString *)inforString{
    
    CGFloat with = [[UIScreen mainScreen] bounds].size.width;
    UIImage *qrImage = [MCKQRImage createNonInterpolatedUIImageFormCIImage:[MCKQRImage createQRForString:inforString] withSize:with * 2];
    
    return qrImage;
    
}
+ (UIImage *)getQRImageWithInforString:(NSString *)inforString andImage:(UIImage *)logoImage{
    
    CGFloat with = [[UIScreen mainScreen] bounds].size.width;
    return [MCKQRImage addLogo:logoImage toImage : [MCKQRImage createNonInterpolatedUIImageFormCIImage:[MCKQRImage createQRForString:inforString] withSize:with * 2] ]; 
    
}

+ (UIImage *)customQRImage:(UIImage *)superQRImage andRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{

//    UIImage *customQRImage = [self imageBlackToTransparent:superQRImage withRed:60.0f andGreen:74.0f andBlue:89.0f];
     UIImage *customQRImage = [self imageBlackToTransparent:superQRImage withRed:red andGreen:green andBlue:blue];
    return customQRImage;
}

#pragma mark - 生成一张图片

//+(UIImage *)createNOnInterpolatedUIImageFormCIImage:(CIImage *)stringImage withSize:(CGFloat)stringSize andImage:(CIImage *)Image withImageSize:(CGFloat)ImageSize{
//
//    CGRect extent = CGRectIntegral(stringImage.extent); //二维码区域跟大小
//    CGFloat scale = MIN(stringSize/CGRectGetWidth(extent), stringSize/CGRectGetHeight(extent)); //缩放比
//    
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale; //拿到真实宽和高
//    
//    
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CGImageRef bitmapImage = [context createCGImage:stringImage fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale); //定义缩放比
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    
////    CGRect extentIM = CGRectIntegral(Image.extent);
////    CGContextRef birt2 = bitmapRef;
////    
////    CGImageRef bitLogo = [context createCGImage:Image fromRect:CGRectMake( 0, 0 ,extentIM.size.width, extentIM.size.height)];
////    CGContextDrawImage(birt2, CGRectMake(extent.size.width*0.4 , extent.size.width*0.4, extent.size.width*0.2, extent.size.width*0.2), bitLogo);
//    
//    
//    // 生成一张图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    
//    // 释放
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//
//    
////    
////    CGRect extentIM = CGRectIntegral(Image.extent);
////    CGFloat scaleIM = MIN(ImageSize/CGRectGetWidth(extentIM), ImageSize/CGRectGetHeight(extentIM));
////    size_t widthIM = CGRectGetWidth(extentIM)*scaleIM;
////    size_t heightIM = CGRectGetHeight(extentIM) * scaleIM;
////    CGColorSpaceRef csIM = CGColorSpaceCreateDeviceGray();
////    CGContextRef bitmapRefIM = CGBitmapContextCreate(nil, widthIM, heightIM, 8, 0, csIM, (CGBitmapInfo)kCGImageAlphaNone);
////    CGImageRef bitmapImageIM = [context createCGImage:Image fromRect:extentIM];
////     CGContextSetInterpolationQuality(bitmapRefIM, kCGInterpolationNone);
////    CGContextScaleCTM(bitmapRef, scale, scale); //定义缩放比
////    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//
//
//}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    // 范围
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 生成一张图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    // 释放
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
   
}



+(CIImage *)createQRForImage:(UIImage *)qrImage{
    
//    NSData *ImageData = UIImagePNGRepresentation(qrImage);
//    
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:ImageData forKey:@"inputMessage"];
//    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
   
    return [[CIImage alloc]initWithCGImage:qrImage.CGImage];



}


#pragma mark - 生成一张二维码
+ (CIImage *)createQRForString:(NSString *)qrString {
    
    // 将信息转换为二进制数据
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 创建filter 固定格式
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    
    // 将内容输出为CIImage
    return qrFilter.outputImage;
}

#pragma mark - 调整颜色
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    
    // 根据原有图片调整
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 调整颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; // 0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 生成图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // CG开头的 都要求释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}
+(UIImage *) addLogo:(UIImage *) logo toImage:(UIImage *) image
{
    
    logo = [MCKQRImage circleImageWithOldImage:logo borderWidth:0.5 borderColor:[UIColor whiteColor]];

    UIGraphicsBeginImageContext(image.size);
    
    [image drawAtPoint:CGPointZero];
    
    [logo drawInRect:CGRectMake(image.size.width * 0.3f, image.size.width * 0.3f, image.size.width * 0.4f, image.size.width * 0.4f)];
    
    UIImage * tar = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tar;
    
    
    
    
    
    
    



}
+ (UIImage *)circleImageWithOldImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
