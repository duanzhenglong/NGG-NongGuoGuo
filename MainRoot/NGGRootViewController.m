//
//  NGGRootViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGRootViewController.h"
#import "NGGSellerBuyerViewController.h"
#import "NGGChatViewController.h"
#import "NGGMeViewController.h"
#import "NGGTabBar.h"
#import "NGGSellerHomeViewController.h"
@interface NGGRootViewController ()

@end

@implementation NGGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*设置子控制器*/
    [self InitializeSetChildVc];
    
    /*统一文字属性*/
    [self UnifyTextFont];
}

#pragma mark-初始化设置控制器
-(void)InitializeSetChildVc{
    /*卖家&买家控制器*/
    [self setupChildVc:[[UINavigationController alloc]initWithRootViewController:[[NGGSellerHomeViewController alloc]init]] title:@"首页" image:@"HomeNormalicon" selectedImage:@"HomeSelecticon"];
    /*聊一聊控制器*/
    [self setupChildVc:[[UINavigationController alloc]initWithRootViewController:[[NGGChatViewController alloc]init]] title:@"聊一聊" image:@"ChatNormalicon" selectedImage:@"ChatSelecticon"];
    /*我的控制器*/
    [self setupChildVc:[[UINavigationController alloc]initWithRootViewController:[[NGGMeViewController alloc]init]] title:@"个人中心" image:@"MeNormalicon" selectedImage:@"MeSelecticon"];
}

#pragma mark-统一文字属性
-(void)UnifyTextFont{
    //正常状态
    NSMutableDictionary *Arr=[NSMutableDictionary dictionary];
    Arr[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    Arr[NSForegroundColorAttributeName]=[UIColor grayColor];
    //选中状态
    NSMutableDictionary *SelectedArr=[NSMutableDictionary dictionary];
    SelectedArr[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    SelectedArr[NSForegroundColorAttributeName]=NGGTheMeColor;
    
    //统一item 用appearance属性
    self.tabBarItem=[UITabBarItem appearance];
    [self.tabBarItem setTitleTextAttributes:Arr forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:SelectedArr forState:UIControlStateSelected];
}

#pragma mark-添加子控制器方法
-(void) setupChildVc:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage{
    vc.view.backgroundColor=[UIColor whiteColor];
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    
    //让图标不被渲染
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //添加为子控制器
    [self addChildViewController:vc];
}


@end
