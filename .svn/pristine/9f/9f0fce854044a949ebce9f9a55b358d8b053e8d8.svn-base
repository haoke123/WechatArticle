//
//  NaviHeader.h
//  WechatArticle
//
//  Created by 找房 on 15/12/8.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NaviheaderClicked)(NSInteger index);


typedef void(^NaviheaderCanceled)(BOOL isCancel, NSInteger lastIndex);

@protocol NaviHeaderDelegate <NSObject>

-(void) naviheaderclickedWithType:(NSInteger) type;

@end

@interface NaviHeader : UIScrollView

@property (nonatomic,assign) BOOL isStateSelect;

@property  (nonatomic,weak)  id <NaviHeaderDelegate> delegate;


@property (nonatomic,copy) NaviheaderClicked block;

-(void) changeState:(BOOL) isStateSelect;

-(void) changeSate:(BOOL) isSateSelect withBlock:(NaviheaderClicked) naviheaderBlock;

-(void) try2NaviWithCancelBlock:(NaviheaderCanceled) block;

@end
