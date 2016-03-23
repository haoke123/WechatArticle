//
//  LViewController.m
//  LDrawerViewController
//
//  Created by 林海 on 15/12/4.
//  Copyright © 2015年 林海. All rights reserved.
//

#import "LViewController.h"

@interface LViewController ()

@end

@implementation LViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImg.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:backImg];
}




@end
