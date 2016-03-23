//
//  LogOutButton.m
//  anHourse
//
//  Created by 找房 on 15/8/11.
//  Copyright (c) 2015年 HK_ALAKA. All rights reserved.
//

#import "LogOutButton.h"

@implementation LogOutButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) awakeFromNib{

    [self.logOutButton.layer setCornerRadius:6.0f];
    [self.logOutButton.layer setMasksToBounds:YES];

}
-(instancetype) init{


    self= [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70)];
    if(self){
        self.Lbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.Lbutton setFrame:CGRectMake(15, 23 , [UIScreen mainScreen].bounds.size.width -30, 44)];
        [self.Lbutton setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.Lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.Lbutton setBackgroundColor:[UIColor redColor]];
        [self.Lbutton.layer setCornerRadius:6.0f];
        [self.Lbutton.layer setMasksToBounds:YES];
        [self addSubview:self.Lbutton];
        
        
    
    
    }
    return self;

}

@end
