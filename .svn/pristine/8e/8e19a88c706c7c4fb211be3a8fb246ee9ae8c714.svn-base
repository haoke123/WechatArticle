//
//  TagCloudPageView.m
//  RFTagCloud
//
//  Created by Arvin on 15/11/18.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//

#import "RFTagCloudPageView.h"

#define kScreen_Width           ([UIScreen mainScreen].bounds.size.width)

CGFloat const kRFTagCloudPageStartLeft = 5;
CGFloat const kRFTagCloudPageLabelStartSize = 13;
CGFloat const kRFTagCloudPageLabelEndSize = 23;

@implementation RFTagCloudPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frames = [[NSMutableArray alloc] init];
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)drawCloudWithWords:(NSArray *)words colors:(NSArray *)colors rowHeight:(float)height isHandle:(BOOL)isHandle {
    self.clouds = words;
    self.rowHeight = height;
    self.colors = colors;
    self.isHandle = isHandle;
}

- (void)drawRect:(CGRect)rect {
    float offsetY=0;
    
    if (self.isHandle) {
        offsetY=(self.frame.size.height - self.clouds.count*self.rowHeight)/2;
    }
    
    for (int i=0; i< self.clouds.count; i++) {
        NSString *str=[self.clouds objectAtIndex:i];
        
        float fontSize=[self getRandomNumber:kRFTagCloudPageLabelStartSize to:kRFTagCloudPageLabelEndSize];
        
        CGSize textBlockMinSize = CGSizeMake(kScreen_Width, CGFLOAT_MAX);
        CGSize labelSize = [str boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
        
        labelSize = CGSizeMake(labelSize.width + fontSize, labelSize.height);
        
        if (labelSize.width >= kScreen_Width) {  //超过最大
            fontSize = kRFTagCloudPageLabelStartSize;
            labelSize = CGSizeMake(kScreen_Width, labelSize.height);
        }
        
        
        float endLeft=kScreen_Width - kRFTagCloudPageStartLeft - labelSize.width;
        if (endLeft < kRFTagCloudPageStartLeft) {
            endLeft = kRFTagCloudPageStartLeft ;
        }
        float left=[self getRandomNumber:kRFTagCloudPageStartLeft to:endLeft];
        
        CGRect frame=CGRectMake(left, offsetY + i*self.rowHeight, labelSize.width, self.rowHeight);
        [self.frames addObject:[NSValue valueWithCGRect:frame]];
        
        UILabel *label=[[UILabel alloc] init];
        int colorIndex=[self getRandomNumber:0 to:(int)self.colors.count-1];
        label.textColor=[self.colors objectAtIndex:colorIndex];
        
        label.font=[UIFont fontWithName:@"Helvetica Neue" size:fontSize];
        label.text=str;
        
        [label drawTextInRect:frame];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];   //触摸的位置
    int index=[self getClickedIndexWithTouchPoint:touchPoint];
    if (index != -1) {
        if ([self.delegate respondsToSelector:@selector(tagCloudPageView:clickedIndex:clickedStr:)]) {
            [self.delegate tagCloudPageView:self clickedIndex:index clickedStr:self.clouds[index]];
        }
    }
    
}

- (int)getClickedIndexWithTouchPoint:(CGPoint)point{
    int index=-1;
    for (int i=0; i<self.frames.count; i++) {
        if (CGRectContainsPoint([[self.frames objectAtIndex:i] CGRectValue], point)) {
            index=i;
            return index;
        }
    }
    return index;
}

- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
