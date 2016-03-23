//
//  TagCloudPageView.h
//  RFTagCloud
//
//  Created by Arvin on 15/11/18.
//  Copyright © 2015年 mobi.refine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RFTagCloudPageViewDelegate;

@interface RFTagCloudPageView : UIView

@property (strong, nonatomic) NSArray *clouds;
@property (strong, nonatomic) NSMutableArray *frames;
@property (strong, nonatomic) NSArray *colors;
@property (assign, nonatomic) float rowHeight;
@property (assign, nonatomic) BOOL isHandle;
@property (weak, nonatomic) id<RFTagCloudPageViewDelegate>delegate;

- (void)drawCloudWithWords:(NSArray *)words colors:(NSArray *)colors rowHeight:(float)height isHandle:(BOOL)isHandle;

@end

@protocol RFTagCloudPageViewDelegate <NSObject>

@optional

- (void)tagCloudPageView:(RFTagCloudPageView *)tagCloudPage clickedIndex:(int)index clickedStr:(NSString *)str;

@end
