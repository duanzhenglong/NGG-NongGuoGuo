//
//  NGGPurchaseOrderController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPurchaseOrderController.h"
#import "NGGOrderTableViewCell.h"
#import "NGGOrder.h"
#import "NGGOrderdescController.h"
@interface NGGPurchaseOrderController ()
@property (strong, nonatomic) NSArray* OrderArrary;
@end

@implementation NGGPurchaseOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.navigationItem.title=@"我的采购订单";
    [self GetOrderInfo];
}


#pragma mark-查询订单信息
-(void)GetOrderInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"buyid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],//买家id
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:buyorderURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        self.OrderArrary=[NGGOrder mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NGGLog(@"失败");
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.OrderArrary.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NGGOrderTableViewCell *cell=[NGGOrderTableViewCell cellWithTable:tableView];
    cell.Order=self.OrderArrary[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NGGOrderdescController*desc=[[NGGOrderdescController alloc]init];
    desc.order=self.OrderArrary[indexPath.row];
    [self.navigationController pushViewController:desc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetOrderInfo];
}

@end
