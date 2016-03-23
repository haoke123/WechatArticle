//
//  FaveViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/19.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "FaveViewController.h"

//
//  HistoryViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/19.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "HistoryViewController.h"

#import "HKUITool.h"

#import "FMDBManager.h"


#import "CoverCell.h"

#import "WeichatArticleModel.h"

#import "UIImageView+WebCache.h"

#import "WebController.h"

@interface FaveViewController () < UITableViewDelegate ,UITableViewDataSource> {
    
    
    NSArray * hisArr;
    
    
    UITableView * mainTable;
    
    
}
@end

@implementation FaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHistory];
    [self setTitle:@"我的收藏"];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"LeftButtonMore"] style:UIBarButtonItemStylePlain target:self action:@selector(open:)];
    
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage * buttonImage =  [UIImage imageNamed:@"locationSharing_icon_back"];
    [button setImage:[UIImage imageNamed:@"locationSharing_icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go2Top) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - buttonImage.size.width - 10, [UIScreen mainScreen].bounds.size.height - buttonImage.size.height - 30 -64, buttonImage.size.width, buttonImage.size.height)];
    
    [self.view addSubview:button];

    
    // Do any additional setup after loading the view.
}
-(void) updateList{
    
    
    hisArr = [FMDBManager selectFaverate];
    
    if(hisArr ==nil){
        
        NSLog(@"数据获取失败");
    }
 
    [mainTable reloadData];
    
    
}
-(void) getHistory{
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
    
    [mainTable setDelegate:self];
    
    [mainTable setDataSource:self];
    
    
    
    [self.view addSubview:mainTable];
}
-(void) go2Top{
    
    [mainTable setContentOffset:CGPointZero animated:YES];
    
    
}
-(void) open:(id) isForceOpen {
    
    [HKUITool APPRootCloseOrOpen];
}
-(NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return hisArr.count;
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 128.0f;
    
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ID = @"CoverCell";
    
    
    CoverCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if(cell == nil){
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CoverCell" owner:nil options:nil] lastObject];
        
        
        
    }
    WeichatArticleModel * model = hisArr[indexPath.row];
    
    
    
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImg] placeholderImage:[UIImage imageNamed:@"PicDefault"]];
    [cell.titleLabel setText:model.title];
    
    
    
//    if([FMDBManager isArticleExists:model.url]){
//        
//        [cell.titleLabel setTextColor:[UIColor colorWithWhite:0.6 alpha:1]];
//        
//        
//        
//    }else{
//        
//        [cell.titleLabel setTextColor:[UIColor blackColor]];
//        
//    }
    
    
    
    [cell.deslabel setText:[NSString stringWithFormat:@"%@ %@ ",model.userName,model.typeName]];
    return cell;
    
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WeichatArticleModel * model = hisArr[indexPath.row];
    
    
    
    [FMDBManager insertModel:model];
    
    
    
    WebController * WebVC = [[WebController alloc]init];
    [WebVC setModel:model];
    [self.navigationController pushViewController:WebVC animated:YES];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
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

