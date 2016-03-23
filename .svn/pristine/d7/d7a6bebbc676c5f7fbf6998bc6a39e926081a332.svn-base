  //
//  QRCImageView.m
//  WechatArticle
//
//  Created by 找房 on 15/12/12.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "QRCImageView.h"

@interface QRCImageView ()  <UIAlertViewDelegate>{



}

@end

@implementation QRCImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) init{

    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    
    if(self){
    
        [self makeView];
        [self setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:0.8f]];
    
    }
    return self;

}
-(void) makeView{


    self.QRCView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    
    
    [self.QRCView setCenter:CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height * 0.4)];
    
    
    self.DesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 60)];
    
    
    [self.DesLabel setCenter:CGPointMake(self.QRCView.center.x, self.QRCView.center.y + 120)];
    
    
    [self.QRCView setBackgroundColor:[UIColor redColor]];
    [self.DesLabel setFont:[UIFont systemFontOfSize:14]];
 //   [self.DesLabel setBackgroundColor:[UIColor blueColor]];
    [self.DesLabel setTextAlignment:NSTextAlignmentCenter];
    [self.DesLabel setText:@"这是一个微信链接，建议用微信扫描"];
    [self.DesLabel setNumberOfLines:0];
    
    [self.DesLabel setTextColor:[UIColor colorWithWhite:0.7f alpha:1.0f]];
    [self addSubview:self.QRCView];
    
    [self addSubview:self.DesLabel];
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [button setBackgroundColor:[UIColor colorWithRed:0 green:163/255.0f blue:1 alpha:1]];
    
    [button setFrame:CGRectMake(0, 0, 100, 24)];
    
    [button.layer setCornerRadius:12];
    
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [button.layer setBorderWidth:0.5f];
    
    [button setCenter:CGPointMake(self.DesLabel.center.x, self.DesLabel.center.y  + 50)];
    [button setTitle:@"保存到相册" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [button addTarget:self action:@selector(saveImage2lib) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissMiss)];
    
    
    [self addGestureRecognizer:tap];




}
-(void) saveImage2lib{

    UIImageWriteToSavedPhotosAlbum(self.QRCView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);


}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{

    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert setDelegate:self];
    [alert show];


}
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    [self dissMiss];


}
-(void) dissMiss{

    
   // [self setBackgroundColor:[UIColor clearColor]];
[UIView animateWithDuration:0.3 animations:^{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    
    
    
} completion:^(BOOL finished) {
    
    [self removeFromSuperview];
}];


}
-(void) dealloc{




}
@end
