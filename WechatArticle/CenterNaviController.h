//
//  CenterNaviController.h
//  WechatArticle
//
//  Created by 找房 on 15/12/23.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^adjustPosition)(NSInteger);

@interface CenterNaviController : UINavigationController

-(void) setIndicatorPosition:(NSInteger) position;
@end
