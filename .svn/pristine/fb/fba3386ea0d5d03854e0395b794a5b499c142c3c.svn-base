//
//  OnlyMoveableCell.m
//  WechatArticle
//
//  Created by 找房 on 15/12/24.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "OnlyMoveableCell.h"

@implementation OnlyMoveableCell

- (void)awakeFromNib {
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) layoutSubviews{
    [super layoutSubviews];

    CGRect  rect = self.contentView.frame;
    
    rect.origin.x = 0;
    
    
    self.contentView.frame = rect;
  [self bringSubviewToFront:self.contentView];
}
@end
