//
//  NaviHeader.m
//  WechatArticle
//
//  Created by 找房 on 15/12/8.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "NaviHeader.h"
#import "AFNetworking.h"

#import "HKUITool.h"

@interface NaviHeader ()<UIAlertViewDelegate>{

    NSMutableArray * titleArr;

    NSMutableArray * buttonArr;
    UIView * Assew;
    
    UISearchBar * searchBar;
    
    
    NSInteger currentType;
    
    
    NSInteger currentIndex;
    

}




@end

@implementation NaviHeader
-(instancetype) init{

    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    if(self){
    
        Assew = [[UIView alloc]initWithFrame:CGRectMake(0, 12,58, 26)];
        [Assew setBackgroundColor:[UIColor clearColor]];
        [Assew.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        [Assew.layer setBorderWidth:1.0f];
        [Assew.layer setCornerRadius:4.0f];
        [Assew .layer setMasksToBounds:YES];
        [self addSubview:Assew];
        
       // [self setBackgroundColor:[UIColor redColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewlist) name:NotiTypeTagsUpdate object:nil];

    }
    [HKUITool getTagsListWithClear:YES];
    return self;


}


-(void) getNewlist{
    
    NSArray * arr  = [HKUITool loadTagesWithDescending:YES];
    
    
    
    
    if(buttonArr == nil){
    
        buttonArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
    
    
    }
    
    for (UIButton * tagButton in buttonArr) {
        
        [tagButton removeFromSuperview];
        
        
    }
    
    if(buttonArr.count < arr.count){
    
        
        NSInteger buttonCount = buttonArr.count;
        for (NSInteger i = 0 ; i< arr.count - buttonCount; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0, 12 , 60, 26)];
            [button setBackgroundColor:[UIColor clearColor]];
            [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
            
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttonArr addObject:button];
            
            
        }
    }
    
    
    for (NSInteger i = 0; i< arr.count; i++) {
        
        
        UIButton * button = buttonArr[i];
        [button setFrame:CGRectMake(i * 64, 12 , 60, 26)];
        [button setTitle:[arr[i] objectForKey:@"name"] forState:UIControlStateNormal];
        
        [button setTag:[[arr[i]  objectForKey:@"id"] integerValue]];
        [self addSubview:button];
        
    }
    [self setBounces:NO];
    [self setContentSize:CGSizeMake((arr.count) * 64, self.bounds.size.height)];

    UIButton * firstButton  = buttonArr[0];
    
    [self performSelector:@selector(buttonClicked:) withObject:firstButton];




}
-(UIButton * ) createTagButton{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 12 , 60, 26)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:8]];

    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(void) buttonClicked:(UIButton *) button{
    
   [UIView animateWithDuration:0.3f animations:^{
       
        [Assew setCenter:button.center];
       
   }completion:^(BOOL finished) {
       if(self.delegate && [self.delegate respondsToSelector:@selector(naviheaderclickedWithType:)]){
           [self.delegate naviheaderclickedWithType:button.tag];
       }else{
           if(self.block){
               self.block (button.tag);
           }
       }
   }];
}
-(void) changeState:(BOOL) isStateSelect{
    if(searchBar ==nil){
        
        
  
        
        
    }
    if(!isStateSelect){
    
    
    }
    else{
    
    
    }
    
    self.isStateSelect = isStateSelect;


}

-(void) changeSate:(BOOL)isSateSelect withBlock:(NaviheaderClicked)naviheaderBlock{

    
    if(isSateSelect){
        naviheaderBlock(10);
    
    }else{
    
        naviheaderBlock (5);
    
    }


}
-(void) try2NaviWithCancelBlock:(NaviheaderCanceled) block{


    block(NO,10);
    
    
    


}
-(void) dealloc{

    self.block = nil;


}
-(void) debugger:(NSData *) response {
    
    NSLog(@"%@:%@",[self class],[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]) ;
    
}
@end
