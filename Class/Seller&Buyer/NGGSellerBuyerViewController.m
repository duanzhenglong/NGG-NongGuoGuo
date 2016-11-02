//
//  NGGSellerBuyerViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSellerBuyerViewController.h"
#import "NGGSellerHomeViewController.h"
#import "NGGBuyerHomeViewController.h"
@interface NGGSellerBuyerViewController ()

@end

@implementation NGGSellerBuyerViewController

static int flg;

- (void)viewDidLoad {
    [super viewDidLoad];

    flg=USERDEFINE.currentUser.Usermark;
    
    UINavigationController*buyer=[[UINavigationController alloc]initWithRootViewController:[[NGGBuyerHomeViewController alloc]init]];
    UINavigationController*seller=[[UINavigationController alloc]initWithRootViewController:[[NGGSellerHomeViewController alloc]init]];
     /***添加子控制器***/
    if (USERDEFINE.currentUser.Usermark==0) {
        [self addChildViewController:buyer];
        [self.view addSubview:buyer.view];
    }else{
        [self addChildViewController:seller];
        [self.view addSubview:seller.view];
    }
   
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
    if (flg==USERDEFINE.currentUser.Usermark)  return;
    
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    [self viewDidLoad];
}



@end
