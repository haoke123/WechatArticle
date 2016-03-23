//
//  LDrawerViewController.m
//  LDrawerViewController
//
//  Created by 林海 on 15/12/2.
//  Copyright © 2015年 林海. All rights reserved.
//

#import "LDrawerViewController.h"
#import "LCnterView.h"

static const CGFloat LdrawerLeftViewOffset = -60;    //左边的图层的宽度
static const NSTimeInterval LDrawerAnimationDuration = 0.5f;  //动画时间
static const NSTimeInterval LDrawerAnimationOpenSpringDamping = 1.0f; //打开的弹簧时间
static const CGFloat LDrawerAnimationOpenSpringInitialVelocity = 0.05f; //打开的弹簧初始速度
static const CGFloat LDrawerAnimationCloseSpringDamping = 1.0; //关闭的弹簧时间
static const CGFloat LDrawerAnimationCloseSpringInitialVelocity = 0.2f; //关闭的弹簧初始速度





@interface LDrawerViewController (){

     CGFloat LDrawerLeftViewWidth;


}
@property (nonatomic,weak) UIView *leftView;
@property (nonatomic,weak) LCnterView *centerView;

@property (nonatomic,assign) CGPoint locationStart;



@end

@implementation LDrawerViewController

-(instancetype)initWithCenterController:(UIViewController <LDrawerChild> *)centerController leftController:(UIViewController <LDrawerChild> *)leftController
{
    self = [super init];
    if (self) {
        LDrawerLeftViewWidth = [UIScreen mainScreen].bounds.size.width - 128;
        _centerController = centerController;
        _leftController = leftController;
        if ([_centerController respondsToSelector:@selector(setDrawer:)]) {
            _centerController.drawer = self;
        }
        if ([_leftController respondsToSelector:@selector(setDrawer:)]) {
            _leftController.drawer = self;
        }
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    LCnterView *centerView = [[LCnterView alloc] initWithFrame:self.view.bounds];
    _centerView = centerView;
    _centerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_centerView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    _leftView = leftView;
    _leftView.backgroundColor = [UIColor grayColor];
    [self.view insertSubview:_leftView belowSubview:_centerView];
    
    [self addChildViewController:_centerController];
    _centerController.view.frame = self.view.bounds;
    [_centerView addSubview:_centerController.view];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapMoive:)];
    [_centerView addGestureRecognizer:gesture];

}

-(void)tapMoive:(UIPanGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    CGPoint velocity = [gesture velocityInView:self.view];
    
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan:
            _locationStart = location;  //记录最开始的位置
            if (_drawerState == LDrawerStateClose) {
                [self willOpen];
            }else{
                [self willClose];
            }
            break;
        case UIGestureRecognizerStateChanged:   //当手势滑动
        {
            CGFloat delta = 0;
            if (_drawerState == LDrawerStateOpening) {
                delta = location.x - self.locationStart.x;
            }else if (_drawerState == LDrawerStateClosing){
                delta = LDrawerLeftViewWidth - (self.locationStart.x - location.x);
            }
            
            CGRect l = _leftView.frame;
            CGRect c = _centerView.frame;
            
            if (delta > LDrawerLeftViewWidth) {
                l.origin.x = 0;
                c.origin.x = LDrawerLeftViewWidth;
            }else if (delta < 0){
                l.origin.x = LdrawerLeftViewOffset;
                c.origin.x = 0;
            }else{
                l.origin.x = LdrawerLeftViewOffset - (delta * LdrawerLeftViewOffset) / LDrawerLeftViewWidth;
                
                c.origin.x = delta;
            }
            _leftView.frame = l;
            _centerView.frame = c;
            break;
        }
        case UIGestureRecognizerStateEnded:   //当手势结束
        {
            CGFloat centerViewLocation = _centerView.frame.origin.x;
            if (_drawerState == LDrawerStateOpening) {
                if (centerViewLocation == LDrawerLeftViewWidth) {
                    [self setNeedsStatusBarAppearanceUpdate];
                    [self didOpen];
                }else if (centerViewLocation < LDrawerLeftViewWidth / 3){
                    [self animateCloseing];
                    [self didClose];
                }else{
                    [self didOpen];
                    [self animateOpening];
                }
                
            }else if (_drawerState == LDrawerStateClosing){
                if (centerViewLocation == 0.0f) {
                    [self setNeedsStatusBarAppearanceUpdate];
                    [self didClose];
                }
                else if (centerViewLocation < (2 * self.view.bounds.size.width) / 3
                         && velocity.x < 0.0f) {
                    [self animateCloseing];
                }
                else {

                    [self didClose];
                    
                    CGRect l = self.leftView.frame;
                    [self willOpen];
                    self.leftView.frame = l;
                    
                    [self animateOpening];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)willOpen
{
    _drawerState = LDrawerStateOpening;
    CGRect f = self.view.bounds;
    f.origin.x = LdrawerLeftViewOffset;
    _leftView.frame = f;
    _centerView.userInteractionEnabled = NO;
    
    _leftController.view.frame = _leftView.bounds;
    [self addChildViewController:_leftController];
    [_leftView addSubview:_leftController.view];
}

-(void)willClose
{
    _drawerState = LDrawerStateClosing;
}

-(void)animateOpening
{
    CGRect centerViewFinelFrame = self.view.bounds;
    centerViewFinelFrame.origin.x = LDrawerLeftViewWidth;
    [UIView animateWithDuration:LDrawerAnimationDuration delay:0 usingSpringWithDamping:LDrawerAnimationOpenSpringDamping initialSpringVelocity:LDrawerAnimationOpenSpringInitialVelocity options:UIViewAnimationOptionCurveLinear  animations:^{
        _centerView.frame = centerViewFinelFrame;
        _leftView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        [self didOpen];
    }];
}

-(void)animateCloseing
{
    CGRect leftViewFinalFrame = self.leftView.frame;
    leftViewFinalFrame.origin.x = - 60;
    [UIView animateWithDuration:LDrawerAnimationDuration delay:0 usingSpringWithDamping:LDrawerAnimationCloseSpringDamping initialSpringVelocity:LDrawerAnimationCloseSpringInitialVelocity options:UIViewAnimationOptionCurveLinear animations:^{
        _centerView.frame = self.view.bounds;
        _leftView.frame = leftViewFinalFrame;
    } completion:^(BOOL finished) {
        [self didClose];
    }];
}

-(void)didOpen
{
    _drawerState = LDrawerStateOpen;
    _centerView.userInteractionEnabled = YES;
}

-(void)didClose
{
    _drawerState = LDrawerStateClose;
    _centerView.userInteractionEnabled = YES;
}


-(void)open
{
    [self willOpen];
    [self animateOpening];
}

-(void)close
{
    [self willClose];
    [self animateCloseing];
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
