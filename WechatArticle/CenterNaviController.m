//
//  CenterNaviController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/23.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "CenterNaviController.h"

@interface CenterNaviController ()
{

    UIImageView * indicator;

}
@end

@implementation CenterNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    indicator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 160, 10, 50)];
    
    [indicator setImage:[[UIImage imageNamed:@"sepC"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [indicator setTintColor:[UIColor whiteColor]];
    
    [indicator setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:indicator];
    
    
    
    // Do any additional setup after loading the view.
}
-(void) setIndicatorPosition:(NSInteger) position{


    
    [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
        
        [indicator setFrame: CGRectMake(0, 160 + 50 * position, 10, 50)];
        
    } completion:^(BOOL finished) {
        
        
    }];



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
