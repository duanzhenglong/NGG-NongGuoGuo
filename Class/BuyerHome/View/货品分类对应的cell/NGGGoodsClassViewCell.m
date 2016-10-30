//
//  NGGGoodsClassViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGFisheriesViewController.h"
#import "NGGFruitViewController.h"
#import "NGGGoodsClassViewCell.h"
#import "NGGLivestockViewController.h"
#import "NGGOilsViewController.h"
#import "NGGResetButton.h"
#import "NGGSupplyViewController.h"
#import "NGGVegetableViewController.h"
#import "NGGButton.h"
@implementation NGGGoodsClassViewCell

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame {
  frame.origin.y += 2;
  frame.size.height -= 7;
  [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.backgroundColor =NGGCutLineColor;
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
  }
  return self;
}

#pragma mark -创建控件
- (void)CreatCustomizeControls {
  /*水果按钮*/
  NGGButton *FruitBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
  FruitBtn.frame = CGRectMake(1, 0.5, SCREEN_WIDTH/4-0.5, 72.5);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
    [FruitBtn setImage:[UIImage imageNamed:@"Fruits_normal"]
            forState:UIControlStateNormal];
////  [FruitBtn setImage:[UIImage imageNamed:@"MyGoods_Selected"]
//            forState:UIControlStateHighlighted];
  [FruitBtn setTitle:@"水果" forState:UIControlStateNormal];
  [FruitBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [FruitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [FruitBtn addTarget:self
                action:@selector(FruitBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:FruitBtn];
  /*蔬菜按钮*/
  NGGButton *VegetableBtn =
      [NGGButton buttonWithType:UIButtonTypeCustom];
  VegetableBtn.frame = CGRectMake(FruitBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH / 4, 72.5);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
    [VegetableBtn setImage:[UIImage imageNamed:@"Vegetables_normal"]
                forState:UIControlStateNormal];
////  [VegetableBtn setImage:[UIImage imageNamed:@"Abrufbildung_Selected"]
//                forState:UIControlStateHighlighted];
  [VegetableBtn setTitle:@"蔬菜" forState:UIControlStateNormal];
  [VegetableBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [VegetableBtn setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [VegetableBtn addTarget:self
                   action:@selector(VegetableBtnClick:)
         forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:VegetableBtn];

  /*粮油按钮*/
  NGGButton *OilsBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
  OilsBtn.frame = CGRectMake(VegetableBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH / 4, 72.5);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
    [OilsBtn setImage:[UIImage imageNamed:@"Oils_normal"]
           forState:UIControlStateNormal];
//  [OilsBtn setImage:[UIImage imageNamed:@"MyShop_Selected"]
//           forState:UIControlStateHighlighted];
  [OilsBtn setTitle:@"粮油" forState:UIControlStateNormal];
  [OilsBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [OilsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [OilsBtn addTarget:self
                action:@selector(OilsBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:OilsBtn];

  /*水产按钮*/
  NGGButton *FisheriesBtn =
      [NGGButton buttonWithType:UIButtonTypeCustom];
  FisheriesBtn.frame =
      CGRectMake(OilsBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH / 4, 72.5);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
    [FisheriesBtn setImage:[UIImage imageNamed:@"Fisheries_normal"]
                forState:UIControlStateNormal];
//  [FisheriesBtn setImage:[UIImage imageNamed:@"Lobby_Selected"]
//                forState:UIControlStateHighlighted];
  [FisheriesBtn setTitle:@"水产" forState:UIControlStateNormal];
  [FisheriesBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [FisheriesBtn setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [FisheriesBtn addTarget:self
                   action:@selector(FisheriesBtnClick:)
         forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:FisheriesBtn];

  /*禽畜按钮*/
  NGGButton *LivestockBtn =
      [NGGButton buttonWithType:UIButtonTypeCustom];
  LivestockBtn.frame =
      CGRectMake(FisheriesBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH / 4, 72.5);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
    [LivestockBtn setImage:[UIImage imageNamed:@"Livestock_normal"]
                forState:UIControlStateNormal];
//  [LivestockBtn setImage:[UIImage imageNamed:@"Lobby_Selected"]
//                forState:UIControlStateHighlighted];
  [LivestockBtn setTitle:@"禽畜" forState:UIControlStateNormal];
  [LivestockBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [LivestockBtn setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [LivestockBtn addTarget:self
                   action:@selector(LivestockBtnClick:)
         forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:LivestockBtn];

  /*把五大类添加到UIScrllView上*/
  UIScrollView *scrollview =
      [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 72.5)];
  scrollview.pagingEnabled = YES;
  scrollview.userInteractionEnabled = YES;
  scrollview.showsHorizontalScrollIndicator = NO;
  scrollview.contentSize = CGSizeMake((SCREEN_WIDTH / 4 * 5)+5, 0);
  scrollview.backgroundColor = [UIColor clearColor];

  [scrollview addSubview:FruitBtn];
  [scrollview addSubview:VegetableBtn];
  [scrollview addSubview:OilsBtn];
  [scrollview addSubview:FisheriesBtn];
  [scrollview addSubview:LivestockBtn];
  [self addSubview:scrollview];
}

#pragma mark -水果点击事件处理
- (void)FruitBtnClick:(NGGResetButton *)sender {
     [self setViewController:[[NGGFruitViewController alloc]init]];
}

#pragma mark -蔬菜事件处理
- (void)VegetableBtnClick:(NGGResetButton *)sender {
    [self setViewController:[[NGGVegetableViewController alloc]init]];
}

#pragma mark -粮油点击事件处理
- (void)OilsBtnClick:(NGGResetButton *)sender {

     [self setViewController:[[NGGOilsViewController alloc]init]];
}

#pragma mark -水产事件处理
- (void)FisheriesBtnClick:(NGGResetButton *)sender {
    [self setViewController:[[NGGFisheriesViewController alloc]init]];
}

#pragma mark -禽畜点击事件处理
- (void)LivestockBtnClick:(NGGResetButton *)sender {
    [self setViewController:[[NGGLivestockViewController alloc]init]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

#pragma mark-跳转事件方法
-(void)setViewController:(UIViewController*)ViewController{
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController*nav=tabBarVc.selectedViewController;
    ViewController.hidesBottomBarWhenPushed=YES;
    [nav pushViewController:ViewController animated:YES];
}

@end
