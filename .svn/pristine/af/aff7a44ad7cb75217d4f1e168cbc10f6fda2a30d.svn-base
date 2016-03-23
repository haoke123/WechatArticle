//
//  SummaryCell.m
//  anHourse
//
//  Created by 找房 on 15/11/5.
//  Copyright © 2015年 HK_ALAKA. All rights reserved.
//

#import "SummaryCell.h"


@interface SummaryCell (){

    UILabel * titleLabel;
    UILabel * contentLabel;


}

@end

@implementation SummaryCell



- (void)awakeFromNib {
    // Initialization code
}
-(void) setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    
    if(titleLabel ==nil){
    
    
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20)];
        [titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [titleLabel setTextColor:[UIColor colorWithWhite:103/255.0f alpha:1]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:titleLabel];
        
    }
    [titleLabel setText:_titleStr];
    


}
-(void) setContentStr:(NSString *)contentStr{

    _contentStr = contentStr;
    
    
    if(contentLabel ==nil){
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 60, [UIScreen mainScreen].bounds.size.width - 50, 500)];
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        [contentLabel setTextColor:[UIColor colorWithWhite:153/255.0f alpha:1]];
        [contentLabel setNumberOfLines:0];
        [self.contentView addSubview:contentLabel];
    }
    [contentLabel setText:_contentStr];
    
    
     CGSize size = [contentStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil].size;
    
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, size.height)];
    
    
    [self setFrame:CGRectMake(0, 0, self.bounds.size.width, size.height + 80)];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
