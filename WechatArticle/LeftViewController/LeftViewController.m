//
//  LeftViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/19.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "LeftViewController.h"

#import "HistoryViewController.h"

#import "HKUITool.h"

#import "CenterNaviController.h"

#import "LDrawerViewController.h"

#import "SettingViewController.h"


#import "UIImage+UIColor.h"

#import "MMZCViewController.h"
#import "settinhHeaderViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * mainTable;
    
    NSArray * menuArr;
    
    NSArray * menuImage;
    
    UIView * bottomBoard;
    
    UIImageView * iconImageView;
    

}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self makeView];
    
    
    // Do any additional setup after loading the view.
}
-(void) makeView{

    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setHidden:YES];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height ) style:UITableViewStyleGrouped];
    
    
    [self setTitle:@"we文摘"];
    

    [mainTable setDelegate:self];
    
    
    [mainTable setDataSource:self];
    
    [mainTable setBounces:NO];
    
    [self.view addSubview:mainTable];
    
    

    menuArr = @[@"首页",@"足迹",@"收藏"];
    
    menuImage = @[@"icon_mine_collect",@"icon_mine_history",@"icon_mine_fans"];
    
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160)];
    
    [headerView setTintColor:[UIColor whiteColor]];
    
    
    
    iconImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 108, 108)];
    
    NSMutableArray * imageArr = [[NSMutableArray alloc]initWithCapacity:7];
    
    for (NSInteger i = 0; i< 7; i++) {
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"bless_%ld",i]];
        
        
        [imageArr addObject:image] ;
        
        
        
        
    }
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(go2LogInOrInfo)];
    
    
    
    [iconImageView addGestureRecognizer:tap];
    
    
    [iconImageView setUserInteractionEnabled:YES];
    
    iconImageView.animationImages = imageArr;
    
    iconImageView.animationDuration = 1.0f;
    
    iconImageView.animationRepeatCount = -1;
    
    
    [iconImageView setCenter:CGPointMake(([UIScreen mainScreen].bounds.size.width -128)/2.0f, 24 + (headerView.bounds.size.height -24.0f) /2.0f)];
    [iconImageView startAnimating];
    
    [headerView addSubview:iconImageView];
    
    
    [headerView setBackgroundColor:[UIColor orangeColor]];
    
    [mainTable setTableHeaderView:headerView];
    
    
    
    bottomBoard  = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49)];
    
    
    [bottomBoard setBackgroundColor:[UIColor orangeColor]];
    
    UIButton * settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingButton setImage:[[UIImage imageNamed:@"iconSetting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    
    
    [settingButton setTintColor:[UIColor whiteColor]];
    
    [settingButton setTitle:@"设置" forState:UIControlStateNormal];
    
    [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    [settingButton setFrame:CGRectMake(0, 0, 100, 49)];
    
    
    [settingButton addTarget:self action:@selector(go2Setting) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomBoard addSubview:settingButton];
    
    
    
    [self.view addSubview:bottomBoard];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucc) name:HKLoginMantualSucc object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:HKLogoutSucc object:nil];
    
    if([HKUITool isLogin]){
    
        [self loginSucc];
    
    
    }else{
    
        [self logout];
    
    
    }
    

}

-(void) logout{

    NSMutableArray * imageArr = [[NSMutableArray alloc]initWithCapacity:7];
    
    for (NSInteger i = 0; i< 7; i++) {
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"bless_%ld",i]];
        
        
        [imageArr addObject:image] ;
        
        
        
        
    }
    
    [iconImageView.layer setCornerRadius:0.0f];
    [iconImageView.layer setBorderWidth:0.0f];
    iconImageView.animationImages = imageArr;
    
    [iconImageView startAnimating];

}
-(void) loginSucc{

    [iconImageView stopAnimating];
    
      [[JMSGUser myInfo] largeAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
          
          
          if(error){
          
          }else{
          
              [iconImageView setImage:nil];
              [iconImageView stopAnimating];
              
              [iconImageView setImage:[UIImage imageWithData:data]];
              
              [iconImageView.layer setCornerRadius:iconImageView.frame.size.width/2.0f];
              [iconImageView.layer setMasksToBounds:YES];
              
              [iconImageView.layer setBorderWidth:3.0f];
              
              [iconImageView.layer setBorderColor:[UIColor colorWithWhite:1 alpha:0.3f].CGColor];
          
          
          }
          
      }];




}
-(void) go2Setting{
    
    if(self.parentViewController && self.parentViewController.parentViewController){
        
        
        LDrawerViewController * vc = (LDrawerViewController *)self.parentViewController.parentViewController;
        
        SettingViewController * svc = [[SettingViewController alloc]init];
        UINavigationController * naviControlVC = [[UINavigationController alloc]initWithRootViewController:svc];
        
        
        
        [naviControlVC.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
        
        [naviControlVC.navigationBar setBackgroundColor:[UIColor whiteColor]];
        
        
        [naviControlVC.navigationBar setTintColor:[UIColor whiteColor]];
        
        
        
        [vc presentViewController:naviControlVC animated:YES completion:^{
            
            
            
        }];
        
        
    }
    
    
}
-(void) go2LogInOrInfo{

    if(self.parentViewController && self.parentViewController.parentViewController){
    
    
    LDrawerViewController * vc = (LDrawerViewController *)self.parentViewController.parentViewController;
        
        
        UIViewController * svc = nil;
        
        
        
        if([JMSGUser myInfo] &&[JMSGUser myInfo].username){
        
        
            svc = [[settinhHeaderViewController alloc] init];
        }else{
        
            svc = [[MMZCViewController alloc] init];
        
        }
        
    
        UINavigationController * naviControlVC = [[UINavigationController alloc]initWithRootViewController:svc];
        
        
        
        [naviControlVC.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
        
        [naviControlVC.navigationBar setBackgroundColor:[UIColor whiteColor]];
        
        
        [naviControlVC.navigationBar setTintColor:[UIColor whiteColor]];
        
        
       
        [vc presentViewController:naviControlVC animated:YES completion:^{
            
            
            
        }];
        
    
    }


}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return menuArr.count;


}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50.0f;

}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    
    
    return 0.1f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;

}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    
    
    //[cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.textLabel setText:menuArr[indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
       
   
    [cell.imageView setImage:[UIImage imageNamed:menuImage[indexPath.row]]];
    
    return cell;



}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
        {
        
            
            
            [HKUITool setCurrentCenterViewControllerWithType:centerTypeHome];
        
        
        }
            break;
        case 1:
        {
            
            
        
            
             [HKUITool setCurrentCenterViewControllerWithType:centerTypeHistory];
            
        }
            break;
        case 2:
        {
            
            [HKUITool setCurrentCenterViewControllerWithType:centerTypeFav];
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
