//
//  NGGPurchaseCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGCancelViewController.h"
#import "NGGCancelViewController.h"
#import "NGGDscViewController.h"
#import "NGGPurchaseCell.h"
@interface NGGPurchaseCell ()
@property(nonatomic, strong) NGGGoodsAttribute *Attribute;
@end
@implementation NGGPurchaseCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setFrame:(CGRect)frame {
  frame.origin.y += 11;
  frame.size.height -= 10;
  [super setFrame:frame];
}

#pragma mark-- 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    self.backgroundColor = NGGColor(255, 255, 255);
    /**
     *  创建控件
     */
    [self createViewOne];
    //[self createViewTwo];
  }
  return self;
}

#pragma mark -添加两个UIView
- (void)createViewOne {

  UIView *BigView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
  BigView.backgroundColor = NGGCommonBgColor;
  [self addSubview:BigView];
  /*创建2个空白view*/
  UIView *viewOne =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];

  viewOne.backgroundColor = [UIColor whiteColor];

  [BigView addSubview:viewOne];

  UIView *views =
      [[UIView alloc] initWithFrame:CGRectMake(0, 142, SCREEN_WIDTH, 45)];
  views.backgroundColor = [UIColor whiteColor];
  [BigView addSubview:views];

  /*创建ProductLab*/
  self.ProductLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 80)];
  self.ProductLab.text = @"产品:";
  [self.ProductLab setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.ProductLab];

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 30, 200,
                               80)];
  self.VarietyLab.text = @"品种:";
  [self.VarietyLab setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.VarietyLab];

  /*创建TimeLab*/
  self.TimeLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 60, 200,
                               80)];
  self.TimeLabel.text = @"采购时间:";
  [self.TimeLabel setTextColor:NGGTheMeColor];
  [viewOne addSubview:self.TimeLabel];

  /***************创建显示数据库对应字段数据的lab**************/

  /*创建ProductLab*/
  self.ProductLab =
      [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 80)];

  [viewOne addSubview:self.ProductLab];

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.ProductLab.frame.origin.y + 30, 200,
                               80)];

  [viewOne addSubview:self.VarietyLab];

  /*创建TimeLab*/
  self.TimeLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.ProductLab.frame.origin.y + 60, 200,
                               80)];

  [viewOne addSubview:self.TimeLabel];

  // 创建查看详情Button
  self.CancelBtn = [[UIButton alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 2.5, 8, SCREEN_WIDTH / 3.75, 30)];
  [self.CancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
  [self.CancelBtn setTitle:@"取消采购" forState:UIControlStateNormal];
  [self.CancelBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
  [self.CancelBtn setTitleColor:[UIColor lightGrayColor]
                       forState:UIControlStateHighlighted];
  self.CancelBtn.layer.cornerRadius = 5;
  self.CancelBtn.layer.masksToBounds = YES;
  [self.CancelBtn setBackgroundColor:NGGTheMeColor];
  [self.CancelBtn addTarget:self
                     action:@selector(CancelBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
  [views addSubview:self.CancelBtn];

  /*创建查看详情Button*/
  self.DscButton =
      [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 1.45, 8,
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
                     action:@selector(DscButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
  [views addSubview:self.DscButton];
}

#pragma mark -给每个控件进行赋值
- (void)initWithForm:(NGGGoodsAttribute *)Attribute {

  self.Attribute = Attribute;

  self.VarietyLab.text = Attribute.goodsclassify_name;
  self.ProductLab.text = Attribute.needlist_goodsname;
  self.TimeLabel.text = Attribute.needlist_time;
}

#pragma mark--取消采购点击事件
- (void)CancelBtnClick:(UIButton *)sender {

  UITabBarController *tabBarVc =
      (UITabBarController *)self.window.rootViewController;
   UINavigationController*nav=tabBarVc.selectedViewController;

  NGGCancelViewController *Cancel = [[NGGCancelViewController alloc] init];
  Cancel.Att = self.Attribute;
  Cancel.hidesBottomBarWhenPushed = YES;
  [nav pushViewController:Cancel animated:YES];
}
#pragma mark--产品详情点击事件
- (void)DscButtonClick:(UIButton *)sender {
  UITabBarController *tabBarVc =
      (UITabBarController *)self.window.rootViewController;
  UINavigationController*nav=tabBarVc.selectedViewController;
  NGGDscViewController *Desc = [[NGGDscViewController alloc] init];
  Desc.Attribute = self.Attribute;
  Desc.hidesBottomBarWhenPushed = YES;
  [nav pushViewController:Desc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
