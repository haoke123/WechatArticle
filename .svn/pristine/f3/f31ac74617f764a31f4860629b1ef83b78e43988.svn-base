//
//  LanchImageView.m
//  WechatArticle
//
//  Created by 找房 on 15/12/18.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "LanchImageView.h"

#define RGB(R,G,B)              [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#import "RFTagCloudView.h"

@interface LanchImageView (){
    RFTagCloudView * CloudView;
    UILabel * copyRightLabel;
}
@end
@implementation LanchImageView
-(void) lanchAtSreen{
    [self setFrame:[UIScreen mainScreen].bounds];
    [self makeView];
}
-(void) makeView{
    [self setBackgroundColor:RGB(255, 128, 0)];
    if(CloudView ==nil){
        NSArray *colorArray=@[RGB(51, 51, 51),RGB(102, 102, 102),RGB(102, 153, 0),RGB(0, 153, 255),RGB(255, 102, 0),RGB(255, 51, 51)];
        NSArray *words = @[@"我他妈是北漂怎么了？",@"我的塔罗牌",@"学霸qun的日常",@"博古通今",@"舌尖上的中国",@"super man",@"welcome to china",@"职场人生存法则",@"妈妈bang",@"我是数码控",@"开着新车去兜风",@"习大大跟习麻麻又秀恩爱了",@"这怎么能算八卦呢",@"你哪来这么多神段子",@"湖人又怎么了",@"邓超给老婆下跪了又",@"我爱你",@"叫你百搭衣服",@"2016新旗舰手机",@"ta真的爱我吗"];
        CloudView = [[RFTagCloudView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height * 0, [UIScreen mainScreen].bounds.size.width -20  , [UIScreen mainScreen].bounds.size.height * 0.9f)];
        [CloudView drawCloudWithWords:words colors:colorArray rowHeight:30];
    }
    if(copyRightLabel ==nil){
        copyRightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 41, [UIScreen mainScreen].bounds.size.width -20, 21)];
        [copyRightLabel setTextColor:[UIColor whiteColor]];
        [copyRightLabel setTextAlignment:NSTextAlignmentCenter];
        [copyRightLabel setFont:[UIFont systemFontOfSize:14]];
        [copyRightLabel setText:@"本软件由豪客提供"];
    }
    [self addSubview:copyRightLabel];
    [self addSubview:CloudView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self performSelector:@selector(DissMiss) withObject:nil afterDelay:3];
}
-(void) DissMiss{
    [UIView animateWithDuration:0.4 animations:^{
        [self setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
