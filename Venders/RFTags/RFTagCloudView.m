
//
//  TagCloudView.m
//  RFTagCloud
//
//  Created by Arvin on 15/11/18.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//

#import "RFTagCloudView.h"

CGFloat const kRFTagCloudPageViewStartTag = 10;
CGFloat const kRFTagCloudPageAnimationDur = 0.3;

@implementation RFTagCloudView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    self.panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hanleViewWithPanGes:)];
}

- (void)drawCloudWithWords:(NSArray *)words colors:(NSArray *)colors rowHeight:(float)height {
    self.clouds = words;
    self.colors = colors;
    self.rowHeight = height;
    self.curPageIndex = 0;
    self.clipsToBounds = YES;
    
    self.numsOfRowInEveryPage = self.frame.size.height / self.rowHeight;
    
    self.totalPages = (int)(self.clouds.count/self.numsOfRowInEveryPage);
    self.numsOfRowInLastPage = self.clouds.count%self.numsOfRowInEveryPage;
    if (self.numsOfRowInLastPage) {
        self.totalPages ++;
    }
    
    if (self.totalPages > 1) {  //大于一页才添加手势
        [self addGestureRecognizer:self.panGes];
    }
    
    [self drawPageViews];
}

-(void)drawPageViews{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<self.totalPages; i++) {
        
        RFTagCloudPageView *pageView = [[RFTagCloudPageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        pageView.delegate = self;
        pageView.tag = kRFTagCloudPageViewStartTag + i;
        pageView.alpha = 0;
        
        
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        int start = i*self.numsOfRowInEveryPage;
        int end = (i+1)*self.numsOfRowInEveryPage;
        
        if (i == self.totalPages - 1) {
            end = (int)self.clouds.count;
        }
        
        for (int j = start; j <end ; j++) {
            [tempArray addObject:[self.clouds objectAtIndex:j]];
        }
        
        BOOL isHandleTheLastPage=NO;
        if (i == self.totalPages - 1 && self.numsOfRowInLastPage) {  //最后一页，且最后一页有东西。。。最后一页个数不是那么多的话，上下居中。。
            isHandleTheLastPage=YES;
        }
        [pageView drawCloudWithWords:tempArray colors:self.colors rowHeight:self.rowHeight isHandle:isHandleTheLastPage];
        [self addSubview:pageView];
        
    }
    
    self.curPageIndex = [self validPageValue:-1];  //一开始是最后一页。
    self.curPageView=[self getPageViewWithIndex:self.curPageIndex];

    self.panGesDir = DirLeft;
    [self handleTheValViewWhenBegan];
    [UIView animateWithDuration:kRFTagCloudPageAnimationDur*2 animations:^{
        [self handleTheValViewWhenToLeftWithDesPer:0 andChangeCurPageFrameOrNot:NO];
    } completion:^(BOOL finished) {
        self.curPageIndex=[self validPageValue:self.curPageIndex+1];
    }];
    
}



-(void)hanleViewWithPanGes:(UIPanGestureRecognizer *)gestureRecognizer{
    float dur = 0.3;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {  //开始的时候，判断方向
        CGPoint point = [gestureRecognizer translationInView:self];
        
        float curX = point.x;
        float curY = point.y;
        
        if (curX > dur && curY < dur) {
            self.panGesDir=DirRight;
        }else if (curX < -dur && curY <dur){
            self.panGesDir=DirLeft;
        }else if ( curX<=dur && curX >= -dur){
            if (curY >= dur) {
                self.panGesDir=DirDown;
            }else if (curY <= -dur){
                self.panGesDir=DirUp;
            }else{
                self.panGesDir=DirNo;
            }
        }else{
            self.panGesDir=DirNo;
        }
        
        [self handleTheValViewWhenBegan];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGPoint point = [gestureRecognizer translationInView:self];
        float curX = point.x;
        float curY = point.y;
        
        if (self.panGesDir != DirNo) {
            if (self.panGesDir == DirLeft) {
                self.per = 1 - (-curX/self.frame.size.width);
                [self handleTheValViewWhenToLeftWithDesPer:self.per andChangeCurPageFrameOrNot:YES];
            }else if(self.panGesDir == DirUp){
                self.per = 1 - (-curY/self.frame.size.height);
                [self handleTheValViewWhenToLeftWithDesPer:self.per andChangeCurPageFrameOrNot:YES];
            }else if (self.panGesDir == DirRight){
                self.per = 1 - curX/self.frame.size.width;
                [self handleTheValViewWhenToRightWithDesPer:self.per];
            }else if(self.panGesDir == DirDown){
                self.per = 1 - curY/self.frame.size.height;
                [self handleTheValViewWhenToRightWithDesPer:self.per];
            }
            
        }
        
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.panGesDir != DirNo) {
            if (self.panGesDir == DirLeft || self.panGesDir == DirUp) {
                float desPer = 0;
                if (self.per > 0.8) {  //back
                    desPer = 1;
                }else{
                    desPer = 0;
                    self.curPageIndex = [self validPageValue:self.curPageIndex+1];
                }
                
                [UIView animateWithDuration:kRFTagCloudPageAnimationDur animations:^{
                    [self handleTheValViewWhenToLeftWithDesPer:desPer andChangeCurPageFrameOrNot:YES];
                }];
                
                
            }else if (self.panGesDir == DirRight || self.panGesDir == DirDown){
                float desPer = 0;
                if (self.per > 0.8) {  //back
                    desPer = 1;
                }else{
                    desPer = 0;
                    self.curPageIndex=[self validPageValue:self.curPageIndex-1];
                }
                
                [UIView animateWithDuration:kRFTagCloudPageAnimationDur animations:^{
                    [self handleTheValViewWhenToRightWithDesPer:desPer];
                }];
                
            }
            
        }
        
    }
}

- (void)handleTheValViewWhenBegan{
    if (self.panGesDir != DirNo) {
        float flag = 0;
        if (self.panGesDir == DirLeft || self.panGesDir == DirUp) {
            flag = 1;
        }else if (self.panGesDir == DirRight || self.panGesDir == DirDown){
            flag = -1;
        }
        
        self.curPageView = [self getPageViewWithIndex:self.curPageIndex];
        int preDisplayIndex = [self validPageValue:self.curPageIndex+flag];
        self.preDisplayView = [self getPageViewWithIndex:preDisplayIndex];
        self.preDisplayView.frame = CGRectMake(-flag*self.frame.size.width/2, -flag*self.frame.size.height/2, self.frame.size.width*(1 + flag), self.frame.size.height*(1+flag));
        
    }
}

- (UIView *)getPageViewWithIndex:(int )index{
    for (UIView *pageView in self.subviews) {
        if (pageView.tag == index + kRFTagCloudPageViewStartTag) {
            return pageView;
        }
    }
    return nil;
}

- (int)validPageValue:(NSInteger)value {
    if(value == -1) value = self.totalPages-1;
    if(value == self.totalPages) value = 0;
    return (int)value;
}

- (void)handleTheValViewWhenToRightWithDesPer:(float )desPer{
    self.curPageView.alpha = desPer;
    self.curPageView.frame = CGRectMake((1-desPer)/2*self.frame.size.width, (1-desPer)/2*self.frame.size.height, self.frame.size.width*desPer, self.frame.size.height*desPer);
    
    self.preDisplayView.alpha = 1 - desPer;
    self.preDisplayView.frame = CGRectMake((-desPer)/2*self.frame.size.width,(-desPer)/2*self.frame.size.height,self.frame.size.width*(1+desPer) , self.frame.size.height*(1+desPer));
}

- (void)handleTheValViewWhenToLeftWithDesPer:(float )desPer andChangeCurPageFrameOrNot:(BOOL) isChange{
    self.curPageView.alpha = desPer;
    
    if (isChange) {
        self.curPageView.frame = CGRectMake((desPer-1)/2*self.frame.size.width,(desPer-1)/2*self.frame.size.height, self.frame.size.width*(2-desPer) , self.frame.size.height*(2-desPer));
    }
    
    
    self.preDisplayView.alpha = 1-desPer;
    self.preDisplayView.frame = CGRectMake(desPer/2*self.frame.size.width, (desPer)/2*self.frame.size.height, self.self.frame.size.width*(1-desPer), self.frame.size.height*(1-desPer));
}

- (void)tagCloudPageView:(RFTagCloudPageView *)tagCloudPage clickedIndex:(int)index clickedStr:(NSString *)str {
    int pageIndex = (int)(tagCloudPage.tag - kRFTagCloudPageViewStartTag);
    int tureIndex = pageIndex*self.numsOfRowInEveryPage + index;
    
    if ([self.delegate respondsToSelector:@selector(tagCloudView:clickedIndex:clickedStr:)]) {
        [self.delegate tagCloudView:self clickedIndex:tureIndex clickedStr:str];
    }
}

@end
