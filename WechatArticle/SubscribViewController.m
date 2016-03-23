//
//  SubscribViewController.m
//  WechatArticle
//
//  Created by 找房 on 15/12/24.
//  Copyright © 2015年 zhaofang. All rights reserved.
//

#import "SubscribViewController.h"
#import "HKUITool.h"
#import "NSString+Pinyin.h"
#import "OnlyMoveableCell.h"

#import "JCAlertView.h"


@interface SubscribViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView * mainTable;
    
    NSMutableArray * itemArr;
    
    BOOL isChanged;


}
@end

@implementation SubscribViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewlist) name:NotiTypeTagsUpdate object:nil];
    
     itemArr =  [[HKUITool loadTagesWithDescending:YES] mutableCopy];
    [self makeView];
    // Do any additional setup after loading the view.
}

-(void) getNewlist{


    itemArr =  [[HKUITool loadTagesWithDescending:YES] mutableCopy];
    
    [mainTable reloadData];

}
-(void) makeView{

    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:  [HKUITool createTitleViewWithTitle:@"我感兴趣的"]];
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0f) style:UITableViewStyleGrouped];
    [mainTable setDelegate:self];
    
    [mainTable setDataSource:self];
    [self.view addSubview:mainTable];
    
    [mainTable setEditing:YES animated:YES];
    
    
    [self.navigationItem setLeftBarButtonItem:[HKUITool creatCustomBackBarButtonWithTarget:self andAction:@selector(back)]];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveTagsWithCurrentArr)];

    
    [self.navigationItem setRightBarButtonItem:right];
}
-(void) back{

    if(isChanged){
    
            [JCAlertView showTwoButtonsWithTitle:@"订阅顺序已经变动" Message:@"是否保存当前的订阅顺序" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"不保存" Click:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"保存" Click:^{
                
                [self saveTagsWithCurrentArr];
                
            }];
        
        
    
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    

    
}
-(void ) saveTagsWithCurrentArr{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotiTypeTagsUpdate object:nil];

    [HKUITool saveTagsWithArray:[itemArr copy]];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotiTypeTagsUpdate object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    isChanged = NO;

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  return   itemArr.count;

}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"itemID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
    
        cell = [[OnlyMoveableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        
       
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        
   
    }
    
    
    NSDictionary * dict = itemArr[indexPath.row];
    [cell.textLabel setText:dict[@"name"]];
    
    
    return cell;


}
-(BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;


}
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;

}
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    
    NSInteger toIndex = destinationIndexPath.row;
    
    NSInteger fromIndex = sourceIndexPath.row;
    
    isChanged = YES;
    
    {
        if (toIndex != fromIndex && fromIndex < [itemArr count] && toIndex< itemArr.count) {
            id obj = [itemArr objectAtIndex:fromIndex];
            
            [itemArr removeObjectAtIndex:fromIndex];
            if (toIndex >= [itemArr count]) {
                [itemArr addObject:obj];
            } else {
                [itemArr insertObject:obj atIndex:toIndex];
            }
            
        }
    }

}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 30.0f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.0f;
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
