//
//  MCKScanQRImage.h
//  MCKCustomQRImage
//
//  Created by touchic on 15/9/21.
//
//

#import <UIKit/UIKit.h>

@protocol MCKScanDeleget <NSObject>

-(void) scanResult:(NSString *) result;

-(void) scanCancel;

@end

@interface MCKScanQRImage : UIView

/**
 *  扫描结果
 */
@property(nonatomic,copy) NSString *resultString;


@property (nonatomic,weak) id <MCKScanDeleget> delegate;
@end
