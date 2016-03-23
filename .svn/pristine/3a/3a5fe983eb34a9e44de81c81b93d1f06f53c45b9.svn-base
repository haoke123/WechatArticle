//
//  MCKScanQRImage.m
//  MCKCustomQRImage
//
//  Created by touchic on 15/9/21.
//
//

#import "MCKScanQRImage.h"
#import <AVFoundation/AVFoundation.h>

#import "MBProgressHUD+Add.h"

#define DefaultSize 240.0f

#define DefaultColor [UIColor colorWithWhite:0.2 alpha:0.6]

@interface MCKScanQRImage ()<AVCaptureMetadataOutputObjectsDelegate>
{
    CGRect ScanTop;
    CGRect ScanEnd;
    
    
    BOOL isDealloc;


}
@property (nonatomic,strong) UIImageView * ScanBar;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation MCKScanQRImage


- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
        [self loadView];
    }
    return self;
}
-(void) makeView{
    
    [UIView animateWithDuration:0.2f animations:^{
        
       [self setTransform:CGAffineTransformMakeScale(1, 1)];
    }];
    
    UIView * squre = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - DefaultSize) * 0.4f)];
    
    
    [squre setBackgroundColor:DefaultColor];
    UILabel * label =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DefaultSize, 60)];
    
    
    [label setCenter:CGPointMake(squre.bounds.size.width/2.0f, squre.bounds.size.height * 0.7f)];
    
    
    [label setTextColor:[UIColor whiteColor]];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    
    [label setText:@"请将取景框对准二维码\n即可自动对焦"];
    [label setNumberOfLines:0];
    [label setFont:[UIFont systemFontOfSize:16.0f]];
    
    [squre addSubview:label];
    
    UIView * squreB = [[UIView alloc]initWithFrame:CGRectMake(0,  squre.bounds.size.height + DefaultSize ,[UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - DefaultSize) * 0.6f)];
    [squreB setBackgroundColor:DefaultColor];
    [self addSubview:squre];
    [self addSubview:squreB];
    
    UIView * squreL = [[UIView alloc]initWithFrame:CGRectMake(0, squre.bounds.size.height, ([UIScreen mainScreen].bounds.size.width - DefaultSize) /2.0f, DefaultSize)];
    
    [squreL setBackgroundColor:DefaultColor];
    UIView * squreR = [[UIView alloc]initWithFrame:CGRectMake(squreL.bounds.size.width + DefaultSize, squre.bounds.size.height, squreL.bounds.size.width, squreL.bounds.size.height)];
    [squreR setBackgroundColor:DefaultColor];

    [self addSubview:squreL];
    [self addSubview:squreR];
    
    
    UIImageView * topLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ScanQR1"]];
    
    UIImageView * topRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR2"]];
    
    UIImageView * bottomLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR3"]];
    
    UIImageView * bottomRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR4"]];
    
    [topLeft setFrame:CGRectMake(squreL.bounds.size.width -2, squre.bounds.size.height - 2, 16, 16)];
    
    [topRight setFrame:CGRectMake(squreR.frame.origin.x - 14, topLeft.frame.origin.y, 16, 16)];
    
    [bottomLeft setFrame:CGRectMake(topLeft.frame.origin.x, squreB.frame.origin.y -14, 16, 16)];
    
    
    [bottomRight setFrame:CGRectMake(topRight.frame.origin.x, bottomLeft.frame.origin.y, 16, 16)];
    
    
    [self addSubview:topLeft];
    [self addSubview:topRight];
    [self addSubview:bottomLeft];
    [self addSubview:bottomRight];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:@"Scan_cancel"] forState:UIControlStateNormal];
    
    [button.layer setCornerRadius:24];
    [button.layer setMasksToBounds:YES];
    [button setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
    
    [button setFrame:CGRectMake(0, 0, 48, 48)];
    
    [button setCenter:CGPointMake(squreB.bounds.size.width/2.0f, squreB.bounds.size.height * 0.6)];
    
    
    [button addTarget:self action:@selector(scanCancel) forControlEvents:UIControlEventTouchUpInside];
    [squreB addSubview:button];
    
    
    
    self.ScanBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DefaultSize * 1.1f, 1.5f)];
    
    
    [self.ScanBar setImage:[UIImage imageNamed:@"ScanBar"]];
    [self.ScanBar setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0f, squre.bounds.size.height)];
    
    ScanTop = self.ScanBar.frame;
    
    ScanEnd = CGRectMake(ScanTop.origin.x, ScanTop.origin.y + DefaultSize +2, ScanTop.size.width, ScanTop.size.height);
    
    [self addSubview:self.ScanBar];
    
    [self ScanAnimation];

}

-(void) ScanAnimation{

    [self.ScanBar setFrame:ScanTop];
    if(isDealloc){
    
        [self removeFromSuperview];
        return;
    }
    
    
    [UIView animateWithDuration:2.5 animations:^{
        
        [self.ScanBar setFrame:ScanEnd];
        
    } completion:^(BOOL finished) {
        
        [self ScanAnimation];
        
    }];
    



}

- (void)loadView {
    
    // 开启摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 设置输入设备
    
    if(device ==nil){
        NSLog(@"没有摄像头");
        self.delegate = nil;
        [self.session stopRunning];
        [self removeFromSuperview];
         [MBProgressHUD showError:@"摄像头不可用" toView:self.superview];
        return;
    }
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if(input == nil){
        [self.session stopRunning];
        self.delegate = nil;
        [self removeFromSuperview];
        
        [MBProgressHUD showError:@"摄像头不可用" toView:self.superview];
        
        NSLog(@"不支持摄像头");
        return;
    }
    // 设置元数据输出
    // 实例化拍摄元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 设置输出数据代理 获取扫描结果
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 添加会话输入
    [session addInput:input];
    
    // 添加会话输出
    [session addOutput:output];
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.session = session;
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = self.bounds;
    
    // 添加到层
    [self.layer addSublayer:preview];
    
    self.previewLayer = preview;
    [self makeView];
    // 开始
    [_session startRunning];
    
}
                                                                                                    // 代理结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    //  如果扫描完成，停止
    [self.session stopRunning];
    
    // 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 设置界面显示扫描结果 
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        _resultString = obj.stringValue;
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(scanResult:)])
            
          [ self.delegate scanResult:_resultString];
        
        [self scanCancel];
    }else{
    
     [self scanCancel];
    
    }
}
-(void) scanCancel{

    
    
    
    
    [self.ScanBar stopAnimating];
    [self.ScanBar removeFromSuperview];
    [self.session stopRunning];
    
    [UIView animateWithDuration:0.2f animations:^{
        
        [self setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(scanCancel)]){
        
            [self.delegate scanCancel];
        
        }
        
    } completion:^(BOOL finished) {
        isDealloc = YES;
        
    }];
    
   

}
-(void) dealloc{



}
@end
