//
//  MCKQRImage.h
//  MCKCustomQRImage
//
//  Created by MCKing on 15/9/21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCKQRImage : NSObject

/**
 *  生成二维码 (默认是黑色)
 *
 *  @param inforString 传入的information字符串
 *
 *  @return 二维码图片
 */
+ (UIImage *)getQRImageWithInforString:(NSString *)inforString;
+ (UIImage *)getQRImageWithInforString:(NSString *)inforString andImage:(UIImage *)logoImage;
/**
 *  改变二维码颜色
 *
 *  @param superQRImage 传入的二维码
 */
+ (UIImage *)customQRImage:(UIImage *)superQRImage andRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

+ (UIImage *) addLogo:(UIImage *) logo toImage:(UIImage *) image;

@end
