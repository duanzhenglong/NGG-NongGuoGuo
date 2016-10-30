//
//  NGGAddressViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddressViewController.h"
#import "UIView+NGGExtension.h"
#import "NGGAddressTableViewCell.h"
#import "NGGAddAddress.h"
#import "NGGUpdateTableView.h"

@interface NGGAddressViewController ()<NGGAddressTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIButton *addAddressBtn;//添加地址
@property (strong,nonatomic) UITableView *addressTableView;//地址
@property (strong,nonatomic) UIView *btnView;//放addAddressBtn
@property (strong,nonatomic) NSMutableArray *addressArray;//地址数组



@end

@implementation NGGAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    self.addressTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-48) style:UITableViewStyleGrouped];
   
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    [self.view addSubview:self.addressTableView];
    
    //承载添加地址Button的view
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.ngg_height-48, self.view.ngg_width, 48)];
    self.btnView.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:self.btnView];
    
    //添加地址Button
    self.addAddressBtn  = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, self.view.ngg_width-24, 48)];
    [self.addAddressBtn setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
    self.addAddressBtn.layer.cornerRadius = 10.0f;
    self.addAddressBtn.layer.masksToBounds = YES;
    [self.addAddressBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    self.addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:1.4];
    [self.addAddressBtn addTarget:self action:@selector(addAddressClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnView addSubview:self.addAddressBtn];

}
#pragma mark-viewWillAppear
-(void)viewWillAppear:(BOOL)animated
{
    //获取地址数据
    [self gainDataClick];
}

#pragma mark-添加新地址
-(void)addAddressClick
{
    NGGAddAddress *addAddressVC = [[NGGAddAddress alloc]init];
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] init];
    returnItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnItem;
    [self.navigationController pushViewController:addAddressVC animated:YES];
    
    
}

#pragma mark-<UITableViewDelegate,UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addressArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *dic = self.addressArray[indexPath.section];
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    NGGAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        cell = [[NGGAddressTableViewCell alloc]initWithReuseIdentifier:CellIdentifier str:dic[@"address_name"]];
    
    cell.delegate = self;
    cell.tag = indexPath.section;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setUpAddress:dic];
    if ([[NSString stringWithFormat:@"%ld",USERDEFINE.currentUser.userAddressId] isEqualToString: dic[@"address_id"]]) {
        cell.chooseImage.image = [UIImage imageNamed:@"info.png"];
    }else{
        cell.chooseImage.image = [UIImage imageNamed:@"yi.png"];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSDictionary *dic = self.addressArray[indexPath.section];
    
     NGGAddressTableViewCell*cell = [[NGGAddressTableViewCell alloc]initWithReuseIdentifier:@"cell" str:dic[@"address_name"]];
    return cell.frame.size.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}

#pragma mark-获取数据
-(void)gainDataClick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                               
                                @"addressuserid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                };
    [manager POST:LookAddressURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
       
       
        if ([code isEqualToString:@"200"]) {
            
            //获取数据
            self.addressArray =[NSMutableArray arrayWithArray:responseObject[@"data"]];
            //修改地址数组顺序
            [self modifyAddressArray:self.addressArray];
            [self.addressTableView reloadData];
        }
        else{
            [self alert:@"获取数据失败"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       [self alert:@"网络出错"];
    }];
}
#pragma mark-修改数组顺序，使默认地址靠前
-(void)modifyAddressArray:(NSMutableArray*)array{
    for (int i = 0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        if ([[NSString stringWithFormat:@"%ld",USERDEFINE.currentUser.userAddressId] isEqualToString: dic[@"address_id"]]) {
            [array removeObjectAtIndex:i];
            [array insertObject:dic atIndex:0];
        }
    }
}

#pragma mark-提示框
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}

#pragma mark-NGGAddressTableViewCellDelegate代理
#pragma mark-删除
-(void)removeClick:(NSInteger)index{

    //删除时提示框
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除条地址吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //删除地址数据数据
        NSDictionary *dic = self.addressArray[index];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *updatePwd = @{
                                    @"addressid":dic[@"address_id"]
                                    };
        [manager POST:RemoveAddressURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
            
            //删除成功，更新地址数组，刷新TableView
            [self.addressArray removeObjectAtIndex:index];
            [self.addressTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self alert:@"该地址是默认地址不可删除"];
        }];
    }];
    
    [controll addAction:action1];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}

#pragma mark-修改地址
-(void)updateClick:(NSInteger)index
{
    NGGUpdateTableView *updateVC = [[NGGUpdateTableView alloc]init];
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] init];
    returnItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnItem;
    NSDictionary *dic = self.addressArray[index];
    updateVC.dic = dic;
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark-修改默认地址
-(void)tapImageClick:(NSInteger)index
{
    
    NSDictionary *dic = self.addressArray[index];
    if ([[NSString stringWithFormat:@"%ld",USERDEFINE.currentUser.userAddressId] isEqualToString: dic[@"address_id"]]) {
        [self alert:@"该地址是默认地址"];
    }else{
        UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定修改默认地址？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //上传默认地址数据
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSDictionary *updatePwd = @{
                                        @"addressid":dic[@"address_id"],
                                        @"userid": [NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                        };
            
            [manager POST:ChooseAddrssURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
                //修改用户默认地址ID
               USERDEFINE. currentUser.userAddressId=[dic[@"address_id"] integerValue];
                //默认地址前置
                [self modifyAddressArray:self.addressArray];
                [self.addressTableView reloadData];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self alert:@"网络请求错误！"];
            }];
        }];
        [controll addAction:action1];
        [controll addAction:action2];
        [self presentViewController:controll animated:YES completion:nil];
    }
   
}


@end
