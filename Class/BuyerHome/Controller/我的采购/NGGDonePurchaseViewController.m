//
//  NGGDonePurchaseViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGDonePurchaseViewController.h"
#import "NGGTwoViewCell.h"
@interface NGGDonePurchaseViewController () <UITableViewDelegate,
                                             UITableViewDataSource>
@property(nonatomic, strong) NSArray *DataArray;

@end

@implementation NGGDonePurchaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 10, 0);
  /*给tableView添加颜色*/
  self.tableView.backgroundColor = NGGCommonBgColor;
  self.DataArray = [[NSArray alloc] init];
  /*禁止垂直滚动*/
  self.tableView.showsVerticalScrollIndicator = NO;

  [self RequireQueryMyPurchase];
}

#pragma mark -获取农业信息
- (void)RequireQueryMyPurchase {

  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = QueryMyPurchaseURL;

  NSDictionary *QueryMyPurchase = @{
    @"userid" : @"1",
    @"status" : @"1"

  };

  [manager POST:urlPath
      parameters:QueryMyPurchase
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *responseDic = (NSDictionary *)responseObject;

        NSString *str = [NSString
            stringWithFormat:@"%@", [responseDic valueForKey:@"code"]];

        if ([str isEqualToString:@"500"]) {
          NGGLog(@"没有采购数据！");
        } else {
          if ([str isEqualToString:@"200"]) {
            NGGLog(@"获取数据成功！");
            self.DataArray = [NGGGoodsAttribute
                mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

            dispatch_async(dispatch_get_main_queue(), ^{
              [self.tableView reloadData];
            });
          }
        }

      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@", error);
      }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.DataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellID = @"CellId";
  NGGDonePurchaseCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellID];
  if (!cell) {
    cell =
        [[NGGDonePurchaseCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellID];
  }
  NGGGoodsAttribute *Attribute = self.DataArray[indexPath.section];
  [cell initWithForm:Attribute];

  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 260;
}

@end
