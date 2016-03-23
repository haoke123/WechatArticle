//
//  CoverCell.m
//  WechatArticle
//
//  Created by 找房 on 15/12/8.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "CoverCell.h"

@implementation CoverCell
-(void) awakeFromNib{
    [self.coverImageView.layer setMasksToBounds:YES];
    
}
@end
