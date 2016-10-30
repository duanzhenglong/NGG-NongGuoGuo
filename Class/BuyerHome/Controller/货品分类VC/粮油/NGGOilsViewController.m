//
//  NGGOilsViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOilsViewController.h"
#import "NGGGoodsTableViewCell.h"
@interface NGGOilsViewController ()
@property(strong, nonatomic) NSArray *DataArray;
@end

@implementation NGGOilsViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self createInitdate];
  /*获取网络数据进行解析*/
  [self requestOils];
}

- (void)createInitdate {

  self.navigationItem.title = @"粮油";
  self.tableView.backgroundColor = NGGCommonBgColor;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.sectionHeaderHeight = 50;
  /*初始化数据*/
  self.DataArray = [NSArray array];
}

//获取网络数据进行解析
- (void)requestOils {

  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = OilsURL;

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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

  return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NGGGoodsTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[NGGGoodsTableViewCell alloc]
          initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:@"cell"];
  }
  NGGGoodsProperty *Attribute = self.DataArray[indexPath.row];
  [cell initWithForm:Attribute];

  /*设置cell被中的样式，这里让它没有变化*/
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  return cell;
}
#pragma mark--返回每个cell高度
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 122;
}
@end
