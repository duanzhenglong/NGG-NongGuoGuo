//
//  NGGStatisticsViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/16.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGStatisticsViewController.h"

@interface NGGStatisticsViewController ()
 /***访问你店铺或货品的数量***/
@property (strong, nonatomic) UILabel* Num1;
/***聊一聊或电话联系你的数量***/
@property (strong, nonatomic) UILabel* Num2;
@end

@implementation NGGStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     /***背景颜色***/
    self.view.backgroundColor=NGGCommonBgColor;
     /***创建控件***/
    [self CreatCustomizeControls];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
    /***背景1***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT/3-10)];
    view.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:view];
     /***分割线***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, view.ngg_bottom, SCREEN_WIDTH, 1)];
    view1.backgroundColor=[[UIColor orangeColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:view1];
    /***背景2***/
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, view1.ngg_bottom, SCREEN_WIDTH, SCREEN_HEIGHT/3-10)];
    view2.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:view2];
    /***标题***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 24, 0, 20)];
    Alabel.textColor=[UIColor whiteColor];
    [Alabel setFont:[UIFont systemFontOfSize:16 weight:1]];
    Alabel.text=@"最近一个月里";
    [Alabel sizeToFit];
    [view addSubview:Alabel];
    /***几个人访问你的数量***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel.ngg_bottom+10, 100, view.ngg_height/2)];
    Alabel1.textColor=[UIColor whiteColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:80 weight:1]];
    Alabel1.text=@"2";
    [view addSubview:Alabel1];
    self.Num1=Alabel1;
    /***描述***/
    UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel1.ngg_bottom+10, 0, 20)];
    Alabel2.textColor=[UIColor whiteColor];
    [Alabel2 setFont:[UIFont systemFontOfSize:16 weight:1]];
    Alabel2.text=@"个老板访问过你的货品或者店铺";
    [Alabel2 sizeToFit];
    [view addSubview:Alabel2];
    
    /***几个人访问你的数量***/
    UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(12, 40, 100, view2.ngg_height/2)];
    Alabel3.textColor=[UIColor whiteColor];
    [Alabel3 setFont:[UIFont systemFontOfSize:80 weight:1]];
    Alabel3.text=@"2";
    [view2 addSubview:Alabel3];
    self.Num2=Alabel3;
    /***描述***/
    UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel3.ngg_bottom+10, 0, 20)];
    Alabel4.textColor=[UIColor whiteColor];
    [Alabel4 setFont:[UIFont systemFontOfSize:16 weight:1]];
    Alabel4.text=@"个老板通过聊天或电话联系你";
    [Alabel4 sizeToFit];
    [view2 addSubview:Alabel4];
    /***小贴士***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, view2.ngg_bottom+20, SCREEN_WIDTH, 30)];
    [Btn setBackgroundColor:NGGCommonBgColor];
    [Btn setTitle:@"怎样在农果果中获取更多买家的关注" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:1]];
    [Btn addTarget:self action:@selector(MoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
}

#pragma mark-更多
-(void)MoreClick:(UIButton*)sender{
    NGGLogFunc
}





@end
