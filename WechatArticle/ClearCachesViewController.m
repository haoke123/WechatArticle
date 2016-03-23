//
//  ClearCachesViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/24.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "ClearCachesViewController.h"

#import "UIImageView+WebCache.h"

#import "FMDBManager.h"

#import "HKUITool.h"

#import "MBProgressHUD+Add.h"


#import "JCAlertView.h"


@interface ClearCachesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mainTable;
    
    NSArray * itemArr;
    
    NSString * imageCache;
    
    NSString * histCache;
    
    NSString * faveCache;
    
    NSArray * cacheArr;
    

}
@end

@implementation ClearCachesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getCacheSize];
    itemArr = @[@"图片缓存",@"浏览历史",@"我的收藏"];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:  [HKUITool createTitleViewWithTitle:@"清理数据"]];
    
    [self.navigationItem setLeftBarButtonItem:[HKUITool creatCustomBackBarButtonWithTarget:self andAction:@selector(back)]];
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0f) style:UITableViewStyleGrouped];
    [mainTable setDelegate:self];
    
    [mainTable setDataSource:self];
    [self.view addSubview:mainTable];
    
    //[mainTable setEditing:YES animated:YES];
    
    // Do any additional setup after loading the view.
}

-(void) back{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) getCacheSize{

    NSUInteger  imageByte =   [[SDImageCache sharedImageCache] getSize];
    
    imageCache = [NSString stringWithFormat:@"%.2fM", imageByte /1024.0f/1024.0f];
    
    
    NSArray * histArr = [FMDBManager selectHistory];
    
    
    histCache = [NSString stringWithFormat:@"%ld条",histArr.count];
    NSArray * FaveArr = [FMDBManager selectFaverate];
    
    faveCache = [NSString stringWithFormat:@"%ld条",FaveArr.count];
    
    cacheArr = @[imageCache,histCache,faveCache];
    
    [mainTable reloadData];


}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return itemArr.count;

}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ID = @"cacheCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if(cell == nil){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
        UILabel * label  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        
        [label setFont:[UIFont systemFontOfSize:10.0f]];
        
        [label setTextAlignment:NSTextAlignmentRight];
        
        [label setTextColor:[UIColor colorWithWhite:0.3 alpha:1]];
        
        [cell setAccessoryView:label];
    
    }
    
    
    UILabel * cachelabel = (UILabel *)cell.accessoryView;
    
    
    [cachelabel setText:cacheArr[indexPath.row]];
    
    [cell.textLabel setText:itemArr[indexPath.row]];
    
    
    return cell;



}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0f;

}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.0f;

}
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;

}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;

}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    

    
    
    

}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            
            
            if([imageCache hasPrefix:@"0.00"]){
            
            
            [JCAlertView showOneButtonWithTitle:@"暂时没有缓存需要清理" Message:@"去找点乐子吧！" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:^{
                
                
            }];
            
            
            
            }else{
            [JCAlertView showTwoButtonsWithTitle:@"确认清空图片缓存？" Message:@"我们只保存部分图片，建议长时间清理一次" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
                
                
                
            } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"清理" Click:^{
                
                [self gonna2ClearCaches:0];
                
            }];
            }
        }
            break;
        case 1:
        {
            
            if([histCache hasPrefix:@"0"]){
                
                
                [JCAlertView showOneButtonWithTitle:@"暂时没有浏览历史" Message:@"去找点乐子吧！" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:^{
                    
                    
                }];
                
                
                
            }else{
            [JCAlertView showTwoButtonsWithTitle:@"确认历史记录缓存？" Message:@"我们只保存记录，一般不建议清理" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
                
                
                
            } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"清理" Click:^{
                
                
                [self gonna2ClearCaches:1];
                
                
            }];
            }
            
            
        }
            break;
        case 2:
        {
            
            if([faveCache hasPrefix:@"0"]){
                
                
                [JCAlertView showOneButtonWithTitle:@"暂时没有收藏记录" Message:@"去找点乐子吧！" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:^{
                    
                    
                }];
                
                
                
            }else{
            [JCAlertView showTwoButtonsWithTitle:@"确认清空收藏缓存？" Message:@"我们只保存收藏记录，一般不建议清理" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
                
                
                
            } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"清理" Click:^{
                
                [self gonna2ClearCaches:2];
                
            }];
            }
            
        }
            break;
            
        default:
            break;
    }
    

    
    [self getCacheSize];

}
-(void) gonna2ClearCaches:(NSInteger) index{


    switch (index) {
        case 0:
        {
            [[SDImageCache sharedImageCache] clearMemory];
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
                [MBProgressHUD showSuccess:@"清理图片缓存成功" toView:self.view];
            }];
        }
            break;
        case 1:
        {
            
            [FMDBManager deleteArticlesIsFave:NO];
            [MBProgressHUD showSuccess:@"清理历史成功" toView:self.view];
            
            
        }
            break;
        case 2:
        {
            [FMDBManager deleteArticlesIsFave:YES];
            [MBProgressHUD showSuccess:@"清理收藏成功" toView:self.view];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    [self getCacheSize];


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
