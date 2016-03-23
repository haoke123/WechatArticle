//
//  ZFToastView.m
//  anHourse
//
//  Created by 找房 on 15/10/24.
//  Copyright © 2015年 HK_ALAKA. All rights reserved.
//

#import "ZFToastView.h"

@interface ZFToastView (){
    NSObject * lastObj;
    
    UILabel * contentLabel;
    
}

@end


@implementation ZFToastView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype) defaultToast{
    static ZFToastView * def = nil;
    if(!def){
        def = [[ZFToastView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 32)];
        def.ContentLabel = [[UILabel alloc]initWithFrame:def.bounds];
        
        [def.ContentLabel setTextColor:[UIColor colorWithRed:0 green:163/255.0f blue:1 alpha:1]];
        [def.ContentLabel setTextColor:[UIColor whiteColor]];
        
        [def.ContentLabel setFont:[UIFont systemFontOfSize:12]];
        [def.ContentLabel setTextAlignment:NSTextAlignmentCenter];
        [def addSubview:def.ContentLabel];
        [def setBackgroundColor:[UIColor clearColor]];
        [def.layer setBackgroundColor:[UIColor orangeColor].CGColor];
        def.backColor = [UIColor orangeColor];
        
    }
    return def;
}
+(void) showDefaultToastMessage:(NSString *)message{

    
    
[[ZFToastView defaultToast] showToastMessage:message withPosition:ZFToastPositionTop];


}
+(void) showToastMessage:(NSString * ) message withPosition:(ZFToastPosition) position{

    [[ZFToastView defaultToast] showToastMessage:message withPosition:position];


}
-(void) showToastMessage:(NSString * ) message withPosition:(ZFToastPosition) position{

    
    
    ZFToastView * view =    [ZFToastView defaultToast];
    
    
    
    [view.layer setBackgroundColor:[UIColor clearColor].CGColor];
    [view.ContentLabel setText:message];

    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    
    switch (position) {
        case ZFToastPositionTop:
        {
            [view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 64+ 16)];
        }
            break;
        case ZFToastPositionBottom:
        {
            [view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height -16)];
        }
            break;
        case ZFToastPositionCenter:
        {
            [view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0f)];
        }
            break;
        case ZFToastPositionLeft:
        {
            [view setCenter:CGPointMake(-[UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height - 79)];
        }
            break;
            
        case ZFToastPositionRight:{
        [view setCenter:CGPointMake(-[UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height - 65)];
        }
        case ZFToastPositionBottomWithBarHigh:{
        [view setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height - 65)];
        
        }
            
            break;
            
        default:
            break;
    }
  [UIView animateWithDuration:0.3 animations:^{
      [view.layer setBackgroundColor:[UIColor orangeColor].CGColor];
      
  } completion:^(BOOL finished) {
      [self performSelector:@selector(autoDisMiss) withObject:nil afterDelay:0.8f];
  }];
}
-(void) autoDisMiss{

    ZFToastView * view =    [ZFToastView defaultToast];
    [UIView animateWithDuration:0.4f animations:^{
        
        [view.layer setBackgroundColor:[UIColor colorWithWhite:1 alpha:0].CGColor];
      //  [view.ContentLabel setTextColor:[UIColor clearColor]];
        [view.ContentLabel.layer setBackgroundColor:[UIColor clearColor].CGColor];
    } completion:^(BOOL finished) {
        [view.ContentLabel.layer setBackgroundColor:[UIColor orangeColor].CGColor];
        [view.layer setBackgroundColor:[UIColor orangeColor].CGColor];
        [view.ContentLabel setTextColor:[UIColor whiteColor]];
        [view removeFromSuperview];
    }];


}
@end
