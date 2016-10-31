//
//  NGGFunctionViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGFunctionViewCell.h"
#import "NGGMyPurchaseViewController.h"
#import "NGGResetButton.h"
#import "NGGSupplyVC.h"
#import "NGGNewsViewController.h"
@implementation NGGFunctionViewCell

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame {
  frame.size.height -= 5;
  [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.backgroundColor = NGGHomeBgColor;
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
  }
  return self;
}

#pragma mark -创建控件
- (void)CreatCustomizeControls {
     /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
    /***下面的分割线***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
    view1.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view1];
  /*供应大厅按钮*/
  NGGResetButton *SupplyBtn =
      [NGGResetButton buttonWithType:UIButtonTypeCustom];
  SupplyBtn.frame = CGRectMake(1, 0.5, SCREEN_WIDTH/3-0.5, 74);
  /**
   *  给重写button设置图片的时候，设置是它的image，不是背景图片
   */
  [SupplyBtn setImage:[UIImage imageNamed:@"Lobby_normal"]
             forState:UIControlStateNormal];
  [SupplyBtn setImage:[UIImage imageNamed:@"Lobby_Selected"]
             forState:UIControlStateHighlighted];
  [SupplyBtn setTitle:@"供应大厅" forState:UIControlStateNormal];
  [SupplyBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [SupplyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [SupplyBtn addTarget:self
                action:@selector(SupplyBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:SupplyBtn];
    /***中间的分割线***/
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(SupplyBtn.ngg_right, 0, 0.5, 74.5)];
    view2.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view2];
  /*我的采购*/
  NGGResetButton *PurchaseBtn = [[NGGResetButton alloc]
      initWithFrame:CGRectMake(SupplyBtn.ngg_right+1,0.5, SCREEN_WIDTH/3-0.5, 74)];
  [PurchaseBtn setImage:[UIImage imageNamed:@"Supply_Purchase_normal"]
               forState:UIControlStateNormal];
  [PurchaseBtn setImage:[UIImage imageNamed:@"Supply_Purchase_Selected"]
               forState:UIControlStateHighlighted];
  [PurchaseBtn setTitle:@"我的采购" forState:UIControlStateNormal];
  [PurchaseBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [PurchaseBtn setTitleColor:[UIColor blackColor]
                    forState:UIControlStateNormal];
  [PurchaseBtn addTarget:self
                  action:@selector(PurchaseBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:PurchaseBtn];
    /***中间的分割线***/
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(PurchaseBtn.ngg_right, 0, 0.5, 74.5)];
    view3.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view3];
  /*新闻*/
  NGGResetButton *NewsBtn = [[NGGResetButton alloc]
      initWithFrame:CGRectMake(PurchaseBtn.ngg_right+1,0.5, SCREEN_WIDTH/3-1, 74)];
    [NewsBtn setImage:[UIImage imageNamed:@"News_normal"] forState:UIControlStateNormal];
    [NewsBtn setImage:[UIImage imageNamed:@"News_Selected"]
           forState:UIControlStateHighlighted];
  [NewsBtn setTitle:@"农业新闻" forState:UIControlStateNormal];
  [NewsBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
  [NewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [NewsBtn addTarget:self
                action:@selector(NewsBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:NewsBtn];
}

#pragma mark -供应大厅事件处理
- (void)SupplyBtnClick:(NGGResetButton *)sender {
    [self setViewController:[[NGGSupplyVC alloc]init]];
}

#pragma mark -我的采购事件处理
- (void)PurchaseBtnClick:(NGGResetButton *)sender {
    [self setViewController:[[NGGMyPurchaseViewController alloc]init]];
}


#pragma mark-农业新闻事件处理
-(void)NewsBtnClick:(NGGResetButton*)sender{
    [self setViewController:[[NGGNewsViewController alloc]init]];
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
