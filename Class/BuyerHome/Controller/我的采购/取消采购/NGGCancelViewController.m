//
//  NGGCancelViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//


#import "NGGCancelViewController.h"
#import "NGGDscViewController.h"
#import "NGGPurchaseViewController.h"
#import "NGGGoodsClassifyMenuController.h"
@interface NGGCancelViewController ()

@property(nonatomic, strong) NSArray *DataArray;

@end

@implementation NGGCancelViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  /*标题*/
  self.navigationItem.title = @"取消采购";
  /*背景色*/
  self.view.backgroundColor = NGGCommonBgColor;
  /*创建View*/
  [self createView];
}
/*创建*/
- (void)createView {

  /*创建2个空白view*/
  UIView *viewOne = [[UIView alloc]
      initWithFrame:CGRectMake(0, 50, self.view.ngg_width, 150)];

  viewOne.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:viewOne];

  UIView *views = [[UIView alloc]
      initWithFrame:CGRectMake(0, 203, self.view.ngg_width, 50)];
  views.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:views];

  /*创建ProductLab*/
  self.ProductLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 80)];
  self.ProductLab.text = @"品种:";
  [self.ProductLab setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.ProductLab];

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.ngg_y + 30, 200, 80)];
  self.VarietyLab.text = @"产品:";
  [self.VarietyLab setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.VarietyLab];

  /*创建TimeLab*/
  self.TimeLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.ngg_y + 60, 200, 80)];
  self.TimeLab.text = @"时间:";
  [self.TimeLab setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.TimeLab];

  // 创建删除Button
  self.DelBtn =
      [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 6.5, 10,
                                                 SCREEN_WIDTH / 3.75, 30)];
  [self.DelBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
  [self.DelBtn setTitle:@"删除" forState:UIControlStateNormal];
  [self.DelBtn setTitleColor:[UIColor whiteColor]
                    forState:UIControlStateNormal];
  [self.DelBtn setTitleColor:[UIColor lightGrayColor]
                    forState:UIControlStateHighlighted];
  self.DelBtn.layer.cornerRadius = 5;
  self.DelBtn.layer.masksToBounds = YES;
  [self.DelBtn setBackgroundColor:NGGTheMeColor];
  [self.DelBtn addTarget:self
                  action:@selector(DelBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
  [views addSubview:self.DelBtn];

  /*创建查看详情Button*/
  self.DscButton =
      [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.3, 10,
                                                 SCREEN_WIDTH / 3.75, 30)];
  [self.DscButton.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
  [self.DscButton setTitle:@"查看详情" forState:UIControlStateNormal];
  [self.DscButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
  [self.DscButton setTitleColor:[UIColor lightGrayColor]
                       forState:UIControlStateHighlighted];
  self.DscButton.layer.cornerRadius = 5;
  self.DscButton.layer.masksToBounds = YES;
  [self.DscButton setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
  [self.DscButton addTarget:self
                     action:@selector(DscBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
  [views addSubview:self.DscButton];

  /*创建重新发布Button*/
  self.AgainBtn =
      [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 1.4, 10,
                                                 SCREEN_WIDTH / 3.75, 30)];
  [self.AgainBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
  [self.AgainBtn setTitle:@"重新发布" forState:UIControlStateNormal];
  [self.AgainBtn setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
  [self.AgainBtn setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateHighlighted];
  self.AgainBtn.layer.cornerRadius = 5;
  self.AgainBtn.layer.masksToBounds = YES;
  [self.AgainBtn setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
  [self.AgainBtn addTarget:self
                    action:@selector(AgainBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
  [views addSubview:self.AgainBtn];

  /**********显示数据库数据Lab************/
  /*创建ProductLab*/
  self.ProductLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 80)];

  self.ProductLab.text = self.Att.goodsclassify_name;
  [viewOne addSubview:self.ProductLab];

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc]
      initWithFrame:CGRectMake(60, self.ProductLab.ngg_y + 30, 200, 80)];
  self.VarietyLab.text = self.Att.needlist_goodsname;
  [viewOne addSubview:self.VarietyLab];

  /*创建TimeLab*/
  self.TimeLab = [[UILabel alloc]
      initWithFrame:CGRectMake(60, self.ProductLab.ngg_y + 60, 200, 80)];
  self.TimeLab.text = self.Att.needlist_time;

  [viewOne addSubview:self.TimeLab];
}

#pragma mark -获取网络信息
- (void)RequireCancelPurchase {

  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = CancelPurchaseURL;

  NSDictionary *QueryMyPurchase = @{
    @"userid" : [NSString stringWithFormat:@"%d", self.Att.user_id],
    @"needlistid" : [NSString stringWithFormat:@"%d", self.Att.needlist_id]

  };
  [manager POST:urlPath
      parameters:QueryMyPurchase
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *responseDic = (NSDictionary *)responseObject;

        NSString *str = [NSString
            stringWithFormat:@"%@", [responseDic valueForKey:@"code"]];

        if ([str isEqualToString:@"500"]) {
          NGGLog(@"没有数据可删除！");
        } else {
          if ([str isEqualToString:@"200"]) {
            NGGLog(@"删除数据成功！");
            self.DataArray = [NGGGoodsAttribute
                mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          }
        }

      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@", error);
      }];
}

#pragma mark--删除点击事件
- (void)DelBtnClick:(UIButton *)sender {
  [self RequireCancelPurchase];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.navigationController popViewControllerAnimated:YES];
    });
    
 
}
#pragma mark--产品详情点击事件
- (void)DscBtnClick:(UIButton *)sender {
  NGGDscViewController *DscVc = [[NGGDscViewController alloc] init];

  DscVc.Attribute = self.Att;

  [self.navigationController pushViewController:DscVc animated:YES];
}
#pragma mark--重新发布点击事件
- (void)AgainBtnClick:(UIButton *)sender {
  NGGGoodsClassifyMenuController *AgainVc = [[NGGGoodsClassifyMenuController alloc] init];
  [self.navigationController pushViewController:AgainVc animated:YES];
}

@end
