//
//  NGGEndSupplyViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGEndSupplyViewController.h"
#import "NGGGoodsProperty.h"
#import "NGGGoodsTableViewCell.h"
@interface NGGEndSupplyViewController ()
/***数据数组***/
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGEndSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=NGGCommonBgColor;
    self.tableView.contentInset=UIEdgeInsetsMake(30, 0, 50, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    /***获取我供应中的数据***/
    [self inqureMySupplyInfo];
}

#pragma mark-获取我的供应中的数据
-(void)inqureMySupplyInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],//卖家id
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:mysupplyURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            /***判断是否过时***/
            //  if ([NGGdate Stratime:responseObject[@"agreetime"] andTimeinterval:3]==NO) {
            self.DataArray=[NGGGoodsProperty mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
            //            }
        }else{
            NGGLogFunc
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}


#pragma mark-uitableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"CellId";
    NGGGoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    NGGGoodsProperty*property=self.DataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell initWithForm:property];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

@end
