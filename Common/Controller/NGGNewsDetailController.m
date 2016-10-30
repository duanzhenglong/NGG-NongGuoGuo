//
//  NGGNewsDetailController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGNewsDetailController.h"

@interface NGGNewsDetailController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView* detailWebView;
@end

@implementation NGGNewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=self.Title;
    
    self.detailWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.detailWebView];
    
    NSURL*Url=[NSURL URLWithString:self.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    
    self.detailWebView.delegate = self;
    self.detailWebView.scalesPageToFit=YES;
   
    kDISPATCH_MAIN_THREAD([self.detailWebView loadRequest:request];);
    
}




@end
