//
//  SettingViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/23.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "SettingViewController.h"
#import "HKUITool.h"
#import "SubscribViewController.h"

#import "ClearCachesViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "LogOutButton.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView * mainTable;
    
    NSArray * menuArray ;

}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self makeView];
    
    
    
    menuArray = @[@[@"订阅"],@[@"清理数据"],@[@"关于我们"]];
    
    
    // Do any additional setup after loading the view.
}
-(void) makeView{

    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationItem setTitleView:[HKUITool createTitleViewWithTitle:@"设置"]];
    
    [self.navigationItem setLeftBarButtonItem:[HKUITool creatCustomBackBarButtonWithTarget:self andAction:@selector(dissMiss)]];
    
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64) style:UITableViewStyleGrouped];
    
    [mainTable setDelegate:self];
    
    [mainTable setDataSource:self];
    
    [self.view addSubview:mainTable];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLaunch) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
    if([HKUITool isLogin]){
    
    LogOutButton * logout = [[LogOutButton alloc] init];
    
    [logout.Lbutton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
    logout.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - logout.frame.size.height - 40);

    
    [self.view addSubview:logout];
 
    }
}

-(void) logout:(UIButton *) button{

    [[NSNotificationCenter defaultCenter] postNotificationName:HKLogoutSucc object:nil];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        
    }];

    [JMSGUser logout:^(id resultObject, NSError *error) {
        
        if(error){
        
            NSLog(@"登出失败");
        
        }else{
        
        
        
        }
    }];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


   return  [menuArray[section] count];


}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return menuArray.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString * ID = @"ID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    
    if(cell ==nil){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    
    }

    [cell.textLabel setText:[menuArray[indexPath.section] objectAtIndex:indexPath.row] ];
    
    
    return cell;


}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0f;

}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;

}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSInteger indexNo = indexPath.section * 100 + indexPath.row;
    

    switch (indexNo) {
        case 0:
        {
        
            SubscribViewController * svc =[[SubscribViewController alloc]init];
            
            
            [self.navigationController pushViewController:svc animated:YES];
        
        
        }
            break;
        case 100:
        {
            ClearCachesViewController * clearVc = [[ClearCachesViewController alloc]init];
            
            [self.navigationController pushViewController:clearVc animated:YES];
            
            
        }
            break;
        case 200:
        {
            
            
            
        }
            break;
            
        default:
            break;
    }






}
-(void) dissMiss{


   // self.navigationController.viewControllers = nil;
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        
    }];


}

-(void) didLaunch{

    
    
    NSLog(@"哈哈");
    NSString * musicPath = [[NSBundle mainBundle]pathForResource:@"appointment" ofType:@"mp3"];
    NSURL * url = [[NSURL alloc]initFileURLWithPath:musicPath];
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [player stop];
        
    });

}
-(void) dealloc{


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
