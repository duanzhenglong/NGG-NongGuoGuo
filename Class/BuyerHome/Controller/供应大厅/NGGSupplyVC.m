//
//  NGGSupplyViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "AFNetworking.h"
#import "NGGSupplyVC.h"
#import "NGGGoodsTableViewCell.h"
#import "NGGRefreshHeader.h"
@interface NGGSupplyVC ()

@property(strong, nonatomic) NSArray *DataArray;

@end

@implementation NGGSupplyVC

- (void)viewDidLoad {
  [super viewDidLoad];

  [self createInitDate];
}

- (void)createInitDate {

  self.navigationItem.title = @"供应大厅";
  self.tableView.backgroundColor = NGGCommonBgColor;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.sectionHeaderHeight = 50;
  /*初始化数据*/
  self.DataArray = [[NSArray alloc] init];
    self.tableView.mj_header=[NGGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestSupply)];
    [self.tableView.mj_header beginRefreshing];
}

//获取网络数据进行解析
- (void)requestSupply {

  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = QuerySupplyURL;

  [manager POST:urlPath
      parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *str = [NSString
            stringWithFormat:@"%@", [responseDic valueForKey:@"code"]];
        if ([str isEqualToString:@"500"]) {
          NGGLog(@"供应大厅没有数据！");
        } else {
          if ([str isEqualToString:@"200"]) {
            NGGLog(@"获取数据成功！");
            self.DataArray = [NGGGoodsProperty
                mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
              kDISPATCH_MAIN_THREAD([self.tableView reloadData];);
              [self.tableView.mj_header endRefreshing];
          }
        }

      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@", error);
      }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

  return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ID = @"cellID";
  NGGGoodsTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:ID];
  if (!cell) {
    cell = [[NGGGoodsTableViewCell alloc]
          initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:ID];
  }
  NGGGoodsProperty *Attribute = self.DataArray[indexPath.row];
  [cell initWithForm:Attribute];
  /*设置cell被中的样式，这里让它没有变化*/
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 120;
}

@end
