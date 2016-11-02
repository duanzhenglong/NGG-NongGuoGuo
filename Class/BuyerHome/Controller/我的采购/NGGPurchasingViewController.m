//
//  NGGPurchasingViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPurchasingViewController.h"
#import "NGGRefreshHeader.h"
@interface NGGPurchasingViewController () <UITableViewDelegate,
                                           UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *DataArray;

@end

@implementation NGGPurchasingViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 55, 0);
  /*给tableView添加颜色*/
  self.tableView.backgroundColor = NGGCommonBgColor;
  self.DataArray = [[NSMutableArray alloc] init];
  /*禁止垂直滚动*/
  self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header=[NGGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(RequireQueryMyPurchase)];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark -获取网络信息
- (void)RequireQueryMyPurchase {

  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = QueryMyPurchaseURL;

  NSDictionary *QueryMyPurchase = @{
    @"userid" : @(USERDEFINE.currentUser.userId),
    @"status" : @"0"

  };

  [manager POST:urlPath
      parameters:QueryMyPurchase
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.DataArray = [NGGGoodsAttribute
            mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          
          dispatch_async(dispatch_get_main_queue(), ^{
              [self.tableView reloadData];
          });
          [self.tableView.mj_header endRefreshing];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];

      }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

  return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellID = @"CellId";
  NGGPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
  if (!cell) {
    cell = [[NGGPurchaseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellID];
  }

  NGGGoodsAttribute *Attribute = self.DataArray[indexPath.row];
  [cell initWithForm:Attribute];

  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 200;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  [self RequireQueryMyPurchase];
}

@end
