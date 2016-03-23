//
//  TagCloudView.h
//  RFTagCloud
//
//  Created by Arvin on 15/11/18.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFTagCloudPageView.h"

@protocol RFTagCloudViewDelegate;

typedef enum{
    DirLeft,
    DirRight,
    DirUp,
    DirDown,
    DirNo
} PanDirection;

@interface RFTagCloudView : UIView <RFTagCloudPageViewDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGes;
@property (assign, nonatomic) PanDirection panGesDir;
@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *clouds;
@property (assign, nonatomic) float rowHeight;

@property (assign, nonatomic) int curPageIndex;
@property (strong, nonatomic) UIView *curPageView;
@property (strong, nonatomic) UIView *preDisplayView;  //准备显示的那一页
@property (assign, nonatomic) int totalPages;
@property (assign, nonatomic) int numsOfRowInEveryPage;
@property (assign, nonatomic) int numsOfRowInLastPage;
@property (assign, nonatomic) float per;
@property (weak, nonatomic) id<RFTagCloudViewDelegate>delegate;

- (void)drawCloudWithWords:(NSArray *)words colors:(NSArray *)colors rowHeight:(float)height;

@end

@protocol RFTagCloudViewDelegate <NSObject>

@optional

- (void)tagCloudView:(RFTagCloudView *)tagCloud clickedIndex:(int)index clickedStr:(NSString *)str;

@end
