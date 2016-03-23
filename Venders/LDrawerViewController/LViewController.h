//
//  LViewController.h
//  LDrawerViewController
//
//  Created by 林海 on 15/12/4.
//  Copyright © 2015年 林海. All rights reserved.
//

#import "LDrawerViewController.h"

@interface LViewController : UIViewController <LDrawerChild>

@property (nonatomic,weak) LDrawerViewController *drawer;

@end
