//
//  NGGMyQuoteViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyQuoteViewController.h"
#import "NGGAbrufbilViewCell.h"
@interface NGGMyQuoteViewController ()
 /***数据数组***/
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGMyQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=NGGCommonBgColor;
    self.tableView.contentInset=UIEdgeInsetsMake(30, 0, 0, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
     /***获取我的报价中的数据***/
     [self inqureMyAbrubilungInfo];
    
}

#pragma mark-获取我的报价中的数据
-(void)inqureMyAbrubilungInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];

    NSDictionary *myParameters = @{
                                   @"userid":@"55",//卖家id
                                   @"mask":@"1",
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inqureAlrQuotationURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功!"]) {
             /***判断是否过时***/
//            if ([NGGdate Stratime:responseObject[@"agreetime"] andTimeinterval:3]==YES) {
                self.DataArray=responseObject[@"result"];
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
    NGGAbrufbilViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGAbrufbilViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
   }
   NSDictionary*dic=self.DataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setValue:dic andflg:1];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
