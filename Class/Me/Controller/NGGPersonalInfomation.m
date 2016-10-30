//
//  NGGPersonalInfomation.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPersonalInfomation.h"
#import "NGGIndustryTableView.h"
#import "NGPersonalInfoCell.h"
@interface NGGPersonalInfomation ()
{
    NSArray *array;
    UILabel *lab1;
    UILabel*lab2;
    NSDictionary *dic;
    
}
@end

@implementation NGGPersonalInfomation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.bounds style:UITableViewStyleGrouped];
    array =@[@"姓名",@"手机号",@"您的行业",@"联系地址"];
    [self updateNick];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell ==nil) {
        cell = [[NGPersonalInfoCell alloc]initWithReuseIdentifier:@"cellID"];
    }
    //去除tableview 右侧滚动条
    tableView.showsVerticalScrollIndicator = NO;
    //去掉分割线 
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    cell.userInteractionEnabled = NO;
    cell.descLable.text = array[indexPath.section];
        if (indexPath.section==0) {
            cell.infoLable.text  = APPDELEGATE.userPersonalModel.userPersonalNick;
            cell.userInteractionEnabled = NO;
        }else if (indexPath.section==1){
             cell.infoLable.text  = APPDELEGATE.userPersonalModel.userPersonalPhone;
            cell.userInteractionEnabled = NO;
        }else if (indexPath.section==2){
            
    cell.infoLable.text  = APPDELEGATE.userPersonalModel.userPersonalJob;
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.section==3){
            cell.userInteractionEnabled = NO;
            //拆分并合并
            NSArray *arrAddress = [APPDELEGATE.userPersonalModel.userPersonalAddress componentsSeparatedByString:@","];
            NSMutableString *str = [[NSMutableString alloc]init];
            for (int i=0; i<arrAddress.count; i++) {
                str = [NSMutableString stringWithFormat:@"%@ %@",str, arrAddress[i]];
            }
            cell.infoLable.text  = str;

        }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        
        NGGIndustryTableView *industryVC = [[NGGIndustryTableView alloc]init];
        [self.navigationController pushViewController:industryVC animated:YES];
    }
    
}

#pragma mark-更新昵称
-(void)updateNick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updateNick = @{
                                 @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                 
                                 };
    [manager POST:LookInfoURL parameters:updateNick success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        APPDELEGATE.userPersonalModel = [NGGPersonal initWithPersonalInfoDic:responseObject[@"data"]];
        
        NGGLog(@"%@", APPDELEGATE.userPersonalModel.userPersonalAddress);
        [self.tableView reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NGGLog(@"失败");
    }];
}



@end
