//
//  NGGRecomViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGRecomViewController.h"
#import "NGGNewsViewCell.h"
#import "NGGNewsDetailController.h"
#import "NGGSellerHomeHeaderView.h"
@interface NGGRecomViewController ()
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGRecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 49, 0);
    self.tableView.backgroundColor=NGGCommonBgColor;
    
    /*tableview表头创建*/
    self.tableView.tableHeaderView=[[NGGSellerHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    [self RequireNewsInfo];
}

#pragma mark-获取农业信息
-(void)RequireNewsInfo{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"typeid":@"2"
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:NewsURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            self.DataArray=responseObject[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellID=@"CellId";
    NGGNewsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGNewsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    NSDictionary*dic=self.DataArray[indexPath.row];
    [cell initWithForm:dic];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NGGNewsDetailController*nesw=[[NGGNewsDetailController alloc]init];
    NSDictionary*dic=self.DataArray[indexPath.row];
    nesw.url=dic[@"news_desc"];
    nesw.Title=dic[@"news_title"];
    [self.navigationController pushViewController:nesw animated:YES];
}
@end
