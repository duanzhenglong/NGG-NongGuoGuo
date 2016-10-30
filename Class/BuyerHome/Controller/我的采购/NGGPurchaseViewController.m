//
//  NGGPurchaseViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGCancelViewController.h"
#import "NGGDonePurchaseViewController.h"
#import "NGGDscViewController.h"
#import "NGGPurchaseViewController.h"
#import "NGGPurchasingViewController.h"
@interface NGGPurchaseViewController () <UIScrollViewDelegate>
@property(strong, nonatomic) UIScrollView *ScrollView;
/*当前选中的标题按钮*/
@property(strong, nonatomic) UIButton *selectedTitleButton;
/*指示器*/
@property(strong, nonatomic) UIView *indicatorView;
/*标题栏view*/
@property(strong, nonatomic) UIView *titleView;

@property(nonatomic, strong) UITableView *tableview1;

@property(nonatomic, strong) UITableView *tableview2;

@property(strong, nonatomic) NSArray *DataArray;

@end

@implementation NGGPurchaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  /*标题*/
  self.navigationItem.title = @"我的采购";

  /*设置scrollview的属性*/
  [self setScrollviewAttribute];

  /*添加标题栏*/
  [self setupTitlesView];

  /*创建2个VC*/
  [self addVC];

  [self addChildVc];
}

#pragma mark -ScrollView属性设置
- (void)setScrollviewAttribute {
  self.ScrollView = [[UIScrollView alloc] init];
  self.ScrollView.backgroundColor = NGGCommonBgColor;
  self.ScrollView.frame = self.view.bounds;
  self.ScrollView.pagingEnabled = YES;
  self.ScrollView.showsHorizontalScrollIndicator = NO;
  self.ScrollView.showsVerticalScrollIndicator = NO;
  self.ScrollView.contentSize = CGSizeMake(self.view.ngg_width * 2, 0);
  self.ScrollView.delegate = self;
  [self.view addSubview:self.ScrollView];
}

#pragma mark -添加两个tableView
- (void)addVC {

  NGGPurchasingViewController *PurchasingVC =
      [[NGGPurchasingViewController alloc] init];

  [self addChildViewController:PurchasingVC];

  NGGDonePurchaseViewController *DonePurchaseVC =
      [[NGGDonePurchaseViewController alloc] init];

  [self addChildViewController:DonePurchaseVC];
}

#pragma mark -添加子控制器到ScrollView上
- (void)addChildVc {
  //子控制器的索引
  NSUInteger index =
      self.ScrollView.contentOffset.x / self.ScrollView.ngg_width;

  UIViewController *childVc = self.childViewControllers[index];
  if ([childVc isViewLoaded])
    return;
  childVc.view.frame = self.ScrollView.bounds;
  [self.ScrollView addSubview:childVc.view];
}

#pragma mark -添加标题栏
- (void)setupTitlesView {
  UIView *titleView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.ngg_width, 30)];
  titleView.backgroundColor =
      [[UIColor whiteColor] colorWithAlphaComponent:0.7];
  [self.view addSubview:titleView];
  self.titleView = titleView;
  //标题
  NSArray *titles = @[ @"采购中", @"采购完成" ];
  NSUInteger count = titles.count;
  CGFloat titleButtonW = titleView.ngg_width / count;
  CGFloat titieButtonH = titleView.ngg_height;
  //创建Button
  for (NSUInteger i = 0; i < count; i++) {
    UIButton *titleButton =
        [[UIButton alloc] initWithFrame:CGRectMake(i * titleButtonW, 0,
                                                   titleButtonW, titieButtonH)];
    [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
    [titleButton setTitleColor:NGGTheMeColor forState:UIControlStateSelected];
    titleButton.tag = i;
    [titleButton addTarget:self
                    action:@selector(titleButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleButton];
    /*分割线*/
    UIView *view = [[UIView alloc]
        initWithFrame:CGRectMake(i * titleButtonW + titleButtonW, 5, 2,
                                 titieButtonH - 10)];
    view.backgroundColor = NGGCommonBgColor;
    [self.titleView addSubview:view];
  }
  //找出第一个按钮
  UIButton *firstTitleButton = titleView.subviews.firstObject;
  //创建底部指示器
  UIView *indicatorView = [[UIView alloc] init];
  indicatorView.backgroundColor = NGGTheMeColor;
  indicatorView.ngg_height = 2;
  indicatorView.ngg_y = titleView.ngg_height - indicatorView.ngg_height;
  [titleView addSubview:indicatorView];
  self.indicatorView = indicatorView;
  //立刻根据文字内容计算label的宽度
  [firstTitleButton.titleLabel sizeToFit];
  indicatorView.ngg_width = firstTitleButton.titleLabel.ngg_width;
  indicatorView.ngg_centerX = firstTitleButton.ngg_centerX;
  //默认选择第一个按钮
  firstTitleButton.selected = YES;
  self.selectedTitleButton = firstTitleButton;
}

#pragma mark -titleButtonClick的点击事件
- (void)titleButtonClick:(UIButton *)titleButton {
  //按钮状态控制
  self.selectedTitleButton.selected = NO;
  titleButton.selected = YES;
  self.selectedTitleButton = titleButton;
  //指示器跟随滚动
  [UIView animateWithDuration:0.25
                   animations:^{
                     self.indicatorView.ngg_width =
                         titleButton.titleLabel.ngg_width;
                     self.indicatorView.ngg_centerX = titleButton.ngg_centerX;
                   }];
  // ScrollView跟随滚动
  CGPoint offset = self.ScrollView.contentOffset;
  offset.x = titleButton.tag * self.ScrollView.ngg_width;
  [self.ScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
///**
// * 在scrollView滚动动画结束时, 就会调用这个方法
// * 前提:
// 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
// */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  [self addChildVc];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  //    // 选中\点击对应的按钮
  NSUInteger index = scrollView.contentOffset.x / scrollView.ngg_width;

  UIButton *titleButton = self.titleView.subviews[index * 2];
  [self titleButtonClick:titleButton];
  [self addChildVc];
}

@end
