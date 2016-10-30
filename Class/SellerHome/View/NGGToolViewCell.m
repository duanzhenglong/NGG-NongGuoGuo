//
//  NGGToolViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGToolViewCell.h"
#import "NGGResetButton.h"
#import "NGGButton.h"
#import "NGGStatisticsViewController.h"
#import "NGGAbrufbildungViewController.h"
#import "NGGMyShopViewController.h"
#import "NGGMyPrivilegeViewController.h"
@implementation NGGToolViewCell

- (void)awakeFromNib {
    // Initialization code
}
/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{   frame.origin.y += 2;
    frame.size.height -= 7;
    [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=NGGCutLineColor;
        /**
         *  创建控件
         */
        [self CreatCustomizeControls];
    }
    return self;
}

#pragma mark-创建控件
-(void)CreatCustomizeControls{
    /*有人要货按钮*/
    NGGButton *AbrufbildungBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
    AbrufbildungBtn.frame=CGRectMake(1, 0.5, SCREEN_WIDTH/4-0.5, 72);
    /**
     *  给重写button设置图片的时候，设置是它的image，不是背景图片
     */
    [AbrufbildungBtn setImage:[UIImage imageNamed:@"Abrufbildung_normal"] forState:UIControlStateNormal];
    [AbrufbildungBtn setImage:[UIImage imageNamed:@"Abrufbildung_Selected"] forState:UIControlStateHighlighted];
    [AbrufbildungBtn setTitle:@"有人要货" forState:UIControlStateNormal];
    [AbrufbildungBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [AbrufbildungBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AbrufbildungBtn addTarget:self action:@selector(AbrufbildungBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:AbrufbildungBtn];
    
    /*我的店铺按钮*/
    NGGButton *MyShopBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
    MyShopBtn.frame=CGRectMake(AbrufbildungBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH/4, 72);
    /**
     *  给重写button设置图片的时候，设置是它的image，不是背景图片
     */
    [MyShopBtn setImage:[UIImage imageNamed:@"MyShop_nomal"] forState:UIControlStateNormal];
    [MyShopBtn setImage:[UIImage imageNamed:@"MyShop_Selected"] forState:UIControlStateHighlighted];
    [MyShopBtn setTitle:@"我的店铺" forState:UIControlStateNormal];
    [MyShopBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [MyShopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [MyShopBtn addTarget:self action:@selector(MyShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:MyShopBtn];
    /*我的特权按钮*/
    NGGButton *DiamondBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
    DiamondBtn.frame=CGRectMake(MyShopBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH/4, 72);
    /**
     *  给重写button设置图片的时候，设置是它的image，不是背景图片
     */
    [DiamondBtn setImage:[UIImage imageNamed:@"Diamond_normal"] forState:UIControlStateNormal];
    [DiamondBtn setImage:[UIImage imageNamed:@"Lobby_Selected"] forState:UIControlStateHighlighted];
    [DiamondBtn setTitle:@"我的特权" forState:UIControlStateNormal];
    [DiamondBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [DiamondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [DiamondBtn addTarget:self action:@selector(DiamondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:DiamondBtn];
    /*效果统计按钮*/
    NGGButton *StatisticsBtn = [NGGButton buttonWithType:UIButtonTypeCustom];
    StatisticsBtn.frame=CGRectMake(DiamondBtn.ngg_right+0.5, 0.5, SCREEN_WIDTH/4, 72);
    [StatisticsBtn setImage:[UIImage imageNamed:@"MyGoods_normal"] forState:UIControlStateNormal];
    [StatisticsBtn setImage:[UIImage imageNamed:@"MyGoods_Selected"] forState:UIControlStateHighlighted];
    [StatisticsBtn setTitle:@"效果统计" forState:UIControlStateNormal];
    [StatisticsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [StatisticsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [StatisticsBtn addTarget:self action:@selector(StatisticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:StatisticsBtn];
}

#pragma mark-我的货品事件处理
-(void)StatisticsBtnClick:(NGGResetButton*)sender{
    [self setViewController:[[NGGStatisticsViewController alloc]init]];
}
#pragma mark-有人要货事件处理
-(void)AbrufbildungBtnClick:(NGGResetButton*)sender{
     [self setViewController:[[NGGAbrufbildungViewController alloc]init]];
}
#pragma mark-我的店铺事件处理
-(void)MyShopBtnClick:(NGGResetButton*)sender{
    NGGMyShopViewController*MyShop=[[NGGMyShopViewController alloc]init];
    MyShop.userid=USERDEFINE.currentUser.userId;
    [self setViewController:MyShop];
}
#pragma mark-会员事件处理
-(void)DiamondBtnClick:(NGGResetButton*)sender{
     [self setViewController:[[NGGMyPrivilegeViewController alloc]init]];
}

#pragma mark-跳转事件方法
-(void)setViewController:(UIViewController*)ViewController{
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController*nav=tabBarVc.selectedViewController;
    ViewController.hidesBottomBarWhenPushed=YES;
    [nav pushViewController:ViewController animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
