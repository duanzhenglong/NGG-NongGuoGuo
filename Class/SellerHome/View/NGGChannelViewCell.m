//
//  NGGChannelViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGChannelViewCell.h"
#import "NGGResetButton.h"
#import "NGGLobbyViewController.h"
#import "NGGMyViewController.h"
#import "NGGNewsViewController.h"
@implementation NGGChannelViewCell

- (void)awakeFromNib {
    // 通道cell
}


/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=NGGHomeBgColor;
        /**
         *  创建控件
         */
        [self CreatCustomizeControls];
    }
    return self;
}

#pragma mark-创建控件
-(void)CreatCustomizeControls{
    /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
    /***下面的分割线***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5)];
    view1.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view1];
     /*大厅按钮*/
    NGGResetButton *LobbyBtn = [NGGResetButton buttonWithType:UIButtonTypeCustom];
    LobbyBtn.frame=CGRectMake(1, 0.5, SCREEN_WIDTH/3-1, 74);
    /**
     *  给重写button设置图片的时候，设置是它的image，不是背景图片
     */
    [LobbyBtn setImage:[UIImage imageNamed:@"Lobby_normal"] forState:UIControlStateNormal];
    [LobbyBtn setImage:[UIImage imageNamed:@"Lobby_Selected"] forState:UIControlStateHighlighted];
    [LobbyBtn setTitle:@"采购大厅" forState:UIControlStateNormal];
    [LobbyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [LobbyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LobbyBtn addTarget:self action:@selector(LobbyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:LobbyBtn];
    /***中间的分割线***/
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(LobbyBtn.ngg_right, 0, 0.5, 74.5)];
    view2.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view2];
     /*我的供应*/
    NGGResetButton* SupplyBtn=[[NGGResetButton alloc]initWithFrame:CGRectMake(LobbyBtn.ngg_right+0.5,0.5, SCREEN_WIDTH/3-1, 74)];
    [SupplyBtn setImage:[UIImage imageNamed:@"Supply_Purchase_normal"] forState:UIControlStateNormal];
    [SupplyBtn setImage:[UIImage imageNamed:@"Supply_Purchase_Selected"] forState:UIControlStateHighlighted];
    [SupplyBtn setTitle:@"我的供应" forState:UIControlStateNormal];
    [SupplyBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [SupplyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SupplyBtn addTarget:self action:@selector(SupplyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:SupplyBtn];
    /***中间的分割线***/
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(SupplyBtn.ngg_right, 0, 0.5, 74.5)];
    view3.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view3];
     /*新闻*/
    NGGResetButton* NewsBtn=[[NGGResetButton alloc]initWithFrame:CGRectMake(SupplyBtn.ngg_right+1,0.5, SCREEN_WIDTH/3-0.5, 74)];
    [NewsBtn setImage:[UIImage imageNamed:@"News_normal"] forState:UIControlStateNormal];
    [NewsBtn setImage:[UIImage imageNamed:@"News_Selected"] forState:UIControlStateHighlighted];
    [NewsBtn setTitle:@"农业新闻" forState:UIControlStateNormal];
    [NewsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [NewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [NewsBtn addTarget:self action:@selector(NewsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:NewsBtn];
    
}

#pragma mark-大厅事件处理
-(void)LobbyClick:(NGGResetButton*)sender{
    [self setViewController:[[NGGLobbyViewController alloc]init]];
}

#pragma mark-我的供应事件处理
-(void)SupplyBtnClick:(NGGResetButton*)sender{
    [self setViewController:[[NGGMyViewController alloc]init]];
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
