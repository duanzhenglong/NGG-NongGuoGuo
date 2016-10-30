//
//  NGGIndustryTableView.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGIndustryTableView.h"

@interface NGGIndustryTableView ()
@property (strong,nonatomic)NSArray *arrayIndustry;
@property (strong,nonatomic) NSString *str;
@property  NSInteger index;
@end

@implementation NGGIndustryTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择行业";
   
    
    [self request:ShowJobURL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayIndustry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    NSDictionary *dic = self.arrayIndustry[indexPath.row];
    
    cell.textLabel.text = dic[@"profession_job"];
    cell.textLabel.textAlignment= NSTextAlignmentCenter;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.index = indexPath.row;
     NSDictionary *dic = self.arrayIndustry[self.index];
    [self alert:[NSString stringWithFormat:@"是否确定修改\n%@",dic[@"profession_job"]]];
    
    
    

    
}
#pragma mark-提示框 是否修改职业
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *dic = self.arrayIndustry[self.index];
        APPDELEGATE.userPersonalModel.userPersonalJob = dic[@"profession_job"];
        self.str = dic[@"profession_id"];
        [self updateUserProfessionid];
    }];
    [controll addAction:action1];
    [controll addAction:action2];
    [self presentViewController:controll animated:YES completion:nil];
}
//获取数据
-(void)request:(NSString *)interface
{
    
    NSURL *url = [NSURL URLWithString:interface];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error!=nil) {
            NGGLog(@"请求失败");
        }
        else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
           self.arrayIndustry = [dic objectForKey:@"data"];

            
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.tableView reloadData];
                
            });
            
        }
    }];
    
    [task resume];
}

#pragma mark-修改用户职业ID
-(void)updateUserProfessionid
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updateNick = @{
                                 @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],
                                 @"professionid":self.str
                                 };
    [manager POST:ChooseJobURL parameters:updateNick success:^(NSURLSessionDataTask *task, id responseObject) {  
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self alert2:@"网络出错！"];
    }];
}
#pragma mark-提示框
-(void)alert2:(NSString *)str{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];

}




@end
