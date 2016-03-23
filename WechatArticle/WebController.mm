//
//  WebController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/8.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "WebController.h"

#import "UIWebView+AFNetworking.h"

#import "WXApi.h"

#import "WeichatArticleModel.h"
#import "UIImageView+WebCache.h"
//#import "HKWxMenu.h"

#import "MCKQRImage.h"

#import "MCKScanQRImage.h"

#import "HLActionSheet.h"

#import "QRCImageView.h"

#import "ZFToastView.h"

#import "FMDBManager.h"

#import "JTSImageViewController.h"

#import "JTSImageInfo.h"




@interface WebController ()<UIWebViewDelegate,WXApiDelegate,MCKScanDeleget>
{

    UIWebView * mainWeb;
    
    UIImage * cover;
    
    UIImage * userLogo;
    
    UIButton * FaveButton;
    
    NSString * fromStr;
    
    
    
    
}
@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    mainWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64)];
     [mainWeb setDelegate:self];
    [mainWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]]];
    
    [mainWeb setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    
    
    
    NSRange range =   [self.model.url rangeOfString:@"?"];
    
    
    if(range.location == NSNotFound){
    
    
    }
    else{
    
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 20.0f)];
        
        [label setTextColor:[UIColor colorWithWhite:0.2 alpha:1]];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont systemFontOfSize:10.0f]];
       // UILabel * bottomlabel = [label copy];
        
        UILabel * bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, mainWeb.bounds.size.height - 30, [UIScreen mainScreen].bounds.size.width, 20.0f)];
        [bottomlabel setTextColor:[UIColor colorWithWhite:0.2 alpha:1]];
        
        [bottomlabel setTextAlignment:NSTextAlignmentCenter];
        
        [bottomlabel setFont:[UIFont systemFontOfSize:10.0f]];
        
        
        //[bottomlabel setFrame:CGRectMake(0, mainWeb.bounds.size.height - 30, [UIScreen mainScreen].bounds.size.width, 20.0f)];
        
        

       
        [mainWeb addSubview:bottomlabel];
        
        [mainWeb sendSubviewToBack:bottomlabel];
        
        [mainWeb addSubview:label];
        
        [mainWeb sendSubviewToBack:label];
        NSRange preFix =  [self.model.url rangeOfString:@"://"];
        
        if (preFix.location != NSNotFound   ) {
            
            
            
            NSString * fromStrX = [self.model.url  substringWithRange:NSMakeRange(preFix.location + preFix.length, range.location -preFix.length -preFix.location -2)];
            
            [label setText:[NSString stringWithFormat:@"该网页由%@提供",fromStrX]];
            
            [bottomlabel setText:label.text];
            
        }else{
        
        
        
            NSString * fromStrX =[self.model.url substringWithRange:NSMakeRange(0, range.location)];
            [label setText:[NSString stringWithFormat:@"该网页由%@提供",fromStrX]];
            [bottomlabel setText:label.text];
        
        }
        
        fromStr  = label.text;
    
    }
    
    
    
    [[SDWebImageManager sharedManager] saveImageToCache:[UIImage imageWithData:[@"YES" dataUsingEncoding:NSUTF8StringEncoding]] forURL:[NSURL URLWithString:self.model.url]];

    
   // [self.navigationItem setBackBarButtonItem:[WebController creatCustomBackBarButtonWithTarget:self andAction:@selector(back)]];
    
    [self.navigationItem setLeftBarButtonItem:[WebController creatCustomBackBarButtonWithTarget:self andAction:@selector(back)]];
    
    
  //  [self.navigationItem setRightBarButtonItem:[WebController createRightBarButtonWithTarget:self andAction:@selector(gonna2Share)]];
    
    [self.navigationItem setRightBarButtonItems:@[[self createRightFaverBarButtonWithTarget:self andAction:@selector(fave)]]];
    
    [self setTitle:[NSString stringWithFormat:@"%@·%@",self.model.userName,self.model.typeName]];
    
    [self.view addSubview:mainWeb];
    [self getThumbImage];
    
    
    // Do any additional setup after loading the view.
}
-(void) fave{

    
    
    if([FMDBManager isArticleHasFaved:self.model.url]){
    
    
       
        
        [FMDBManager Fave:self.model withIsFave:NO];
    
    
    }else{
    
    
        [FMDBManager Fave:self.model withIsFave:YES];
    
       
    }
    
    
    [self checkfaveState];


}
-(void) back{

   [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
-(void) viewWillAppear:(BOOL)animated{





}
-(void) setTitle:(NSString *)title{
    
    [self.navigationItem setTitleView:nil];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 36)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:title];
    
    [titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:titleLabel];
    
  


}

-(void) gonna2Share{

    
    NSArray *titles = @[@"分享微信好友",@"分享到朋友圈",@"微信收藏",@"复制链接",@"Safari打开",@"二维码分享"];
    NSArray *imageNames = @[@"Action_Share",@"Action_Moments",@"Action_MyFavAdd",@"Action_ReadOriginal",@"AS_safari",@"ScanQRCode_HL"];
    HLActionSheet *sheet = [[HLActionSheet alloc] initWithTitles:titles iconNames:imageNames];
    
    [sheet.fromLabel setText:fromStr];
    
    [sheet showActionSheetWithClickBlock:^(int btnIndex) {
        NSLog(@"btnIndex:%d",btnIndex);
        
        [self share2WeichatWithType:btnIndex];
        
        
        
        
    } cancelBlock:^{
        NSLog(@"取消");
    }];

}
-(void) share2WeichatWithType:(int) type{

    
    
    switch (type) {
        case 0:
            case 1:
            case 2:
        {
        
        
        
        
        }
            break;
        case 3:{
        
        
            [UIPasteboard generalPasteboard].string = self.model.url;
            
            [ZFToastView showDefaultToastMessage:@"链接复制成功"];
            
            return;
            
        
        }
            break;
            
        case 4:{
        
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.url]];
            
            return;
        
        }
            break;
            
        case 5:{
        
            [self showQRCImage];
            return;
            
        
        }
            break;
            
        default:
        {
        
            return;
        }
            break;
    }
    
    
    if([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]){
       
        
        
        
        
        SendMessageToWXReq * sVReq = [[SendMessageToWXReq alloc]init];
        
        [sVReq setBText:NO];
        
        [sVReq setText:@"这是一个测试"];
        [sVReq setScene:type];
        
        WXMediaMessage * mesage = [WXMediaMessage message];
    
        WXWebpageObject * webObj = [[WXWebpageObject alloc]init];
        
        [webObj setWebpageUrl:self.model.url];
        
        if(type ==1){
        [mesage setTitle:self.model.title];
        
        }
        else{
         [mesage setDescription:self.model.title];
        
        }
        
    //
       
        
        if(cover){
        [mesage setThumbImage:cover];
        }
        mesage.mediaObject = webObj;
        [sVReq setMessage:mesage];
       
        
        [WXApi sendReq:sVReq];
        
    }else{
    
        NSLog(@"用户未安装微信或不支持微信api");
    
    }

}
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSLog(@"%@·%@",strTitle,strMsg);
        
            }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (UIBarButtonItem*)creatCustomBackBarButtonWithTarget:(id) target andAction:(SEL) action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_item"] style:UIBarButtonItemStylePlain target:target action:action];
    [item setWidth:30.0f];
    [item setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    return item;
}

-(UIBarButtonItem *) createRightFaverBarButtonWithTarget:(id) target andAction:(SEL) action{
    
    
    FaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [FaveButton setImage:[[UIImage imageNamed:@"icon_tips_attention_ok"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [FaveButton setTintColor:[UIColor whiteColor]];
    
    [FaveButton addTarget:self action:@selector(fave) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
      [button2 setImage:[[UIImage imageNamed:@"moreFunc"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [button2 setTintColor:[UIColor whiteColor]];
    
    [FaveButton setFrame:CGRectMake(5, 0, 34, 30)];
    [button2 setFrame:CGRectMake(44, 0, 34, 30)];
    

    [button2 addTarget:self action:@selector(gonna2Share) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * board = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 30)];
    [board setTintColor:[UIColor whiteColor]];
    
  //  [board setBackgroundColor:[UIColor redColor]];
    
    
    [board addSubview:FaveButton];
    
    [board addSubview:button2];
    [self checkfaveState];

    return   [[UIBarButtonItem alloc]initWithCustomView:board];
    
    
    
  

}
-(void) checkfaveState{

    if(![FMDBManager isArticleHasFaved:self.model.url]){
        
        
        [FaveButton setTintColor:[UIColor whiteColor]];
        
        // [FMDBManager Fave:self.model withIsFave:NO];
        
        
    }else{
        
        
        [FaveButton setTintColor:[UIColor redColor]];
        
        //[FMDBManager Fave:self.model withIsFave:YES];
    }


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) getThumbImage{
    NSURL *url = [NSURL URLWithString:self.model.contentImg ];

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    if ([manager diskImageExistsForURL:url]) {
     
     cover =    [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
    
       
    }else{
        
       
    }
    if(![manager diskImageExistsForURL:[NSURL URLWithString:self.model.userLogo]]){
        
    
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.model.userLogo] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        userLogo = image;
    }];
    
    
    }else{
    
        
        
        userLogo = [[manager imageCache] imageFromDiskCacheForKey:self.model.userLogo];
    
    
    }



}

-(void) showQRCImage{


    QRCImageView * QRc=     [[QRCImageView alloc]init];
    
    [QRc.QRCView setImage:[MCKQRImage addLogo:userLogo toImage:[MCKQRImage getQRImageWithInforString:self.model.url]]];
  //  [QRc.DesLabel setText:self.model.userName];
    
    [self.navigationController.view addSubview:QRc];

  //  [self.view addSubview:QRc];

}
-(void) startScan{

    MCKScanQRImage * scan = [[MCKScanQRImage alloc]init];
    
    [[UIApplication sharedApplication].keyWindow addSubview:scan];
    
    
    scan.delegate = self;
    



}
-(void) scanResult:(NSString *)result{

    NSLog(@"++++++%@______",result);
    
    if(result&& [result isKindOfClass:[NSString class]] && [result hasPrefix:@"http"]){
    
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
    
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    
    //调整字号
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'";
    [mainWeb stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    [mainWeb stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
   [mainWeb stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
    
   

    
    //调用js方法
    //    NSLog(@"---调用js方法--%@  %s  jsMehtods_result = %@",self.class,__func__,resurlt);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    //    NSLog(@"requestString is %@",requestString);
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        
        
        JTSImageInfo * imageInfo = [[JTSImageInfo alloc]init];
        
        imageInfo.imageURL = [NSURL URLWithString:imageUrl];
        
        imageInfo.image = [UIImage imageWithContentsOfFile:imageUrl];
        
        
        imageInfo.referenceRect = CGRectMake(([UIScreen mainScreen].bounds.size.width - 10) /2.0f, mainWeb.scrollView.contentOffset.y + 10 , 10, 10);
        imageInfo.referenceView = mainWeb;
        imageInfo.referenceContentMode = UIViewContentModeScaleAspectFit;
        imageInfo.referenceCornerRadius = mainWeb.bounds.size.width/2.0f;
        
        JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                               initWithImageInfo:imageInfo
                                               mode:JTSImageViewControllerMode_Image
                                               backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
        
        // Present the view controller.
        [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
        
       
        return NO;
    }
    return YES;
}
-(void) getModel:(WeichatArticleModel  **)buffer range:(NSRange)inRange{






}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = touches.allObjects.lastObject;
    
    CGPoint  point =  [touch locationInView:mainWeb];

    
    NSLog(@"");





}
-(void) dealloc{
    
    [mainWeb.scrollView setContentOffset:CGPointMake(0, 0)];
    
    [mainWeb  removeFromSuperview];
    
    [mainWeb setDelegate:nil];
 
    self.view = nil;
    
    mainWeb = nil;

}
@end
