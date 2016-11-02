//
//  NGGVegetablesController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/16.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGVegetablesController.h"
#import "NGGSupplyViewController.h"
@interface NGGVegetablesController ()

/***数据数组***/
@property (strong, nonatomic) NSArray* DataArray;

@end

@implementation NGGVegetablesController

- (void)viewDidLoad {
    [super viewDidLoad];
    /***获取物品信息***/
    [self RequireGoodsInfo];
}

#pragma mark-获取物品信息
-(void)RequireGoodsInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];    NSDictionary *myParameters = @{
                                                                                                    @"goodscalssify":@"2"
                                                                                                    };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:lookGoodsURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            self.DataArray=responseObject[@"result"];
            [self CreatCustomizeControls:self.DataArray];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-创建Button
-(void)CreatCustomizeControls:(NSArray*)Array{
    /***创建装button的背景***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-94)];
    [self.view addSubview:view];
    
    
    CGFloat buttonW=(SCREEN_WIDTH-60)/4;
    CGFloat buttonH=25;
    for (int i=0; i<Array.count; i++) {
        NSDictionary*dic=Array[i];
        /***物品选项***/
        UIButton* Btn=[[UIButton alloc]init];
        
        /***设置frame***/
        Btn.ngg_x=(i%4)*buttonW+12*(i%4+1);
        Btn.ngg_y=(i/4)*buttonH+10*(i/4+1);
        Btn.ngg_width=buttonW;
        Btn.ngg_height=buttonH;
        /***设置属性***/
        [Btn setBackgroundColor:NGGTheMeColor];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
        Btn.layer.cornerRadius=8;
        Btn.layer.masksToBounds=YES;
        /***赋值***/
        [Btn setTitle:dic[@"goods_name"] forState:UIControlStateNormal];
        Btn.tag=[dic[@"goods_id"] integerValue]+100;
        
        [Btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
    }
}

#pragma mark-事件触发
-(void)Click:(UIButton*)sender{
    if (USERDEFINE.currentUser.Usermark==1) {
        NGGSupplyViewController*supply=[[NGGSupplyViewController alloc]init];
        supply.goodsclassifyid=@"2";
        supply.goodsid=[NSString stringWithFormat:@"%ld",sender.tag-100];
        [self.navigationController pushViewController:supply animated:YES];return;
    }
    
    NGGPublishViewController *Publish = [[NGGPublishViewController alloc] init];
    Publish.tags = 2;
    Publish.BtnTag = sender.tag-100;
    Publish.goodsClassify=@"蔬菜";
    Publish.goodsname = sender.currentTitle;
    [self.navigationController pushViewController:Publish animated:YES];
}
@end
