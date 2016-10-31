//
//  NGGOrderdescController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOrderdescController.h"
#import "NGGSellerHomeHeaderView.h"
#import "NGGAlertView.h"
@interface NGGOrderdescController ()

@end

@implementation NGGOrderdescController
static CGFloat height;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.navigationItem.title=self.order.order_goodsname;
     /***轮播图片***/
    NSArray*arr=[self.order.order_goodsimage componentsSeparatedByString:@".png"];
    NSMutableArray*array=[[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        NSString* imageurl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,arr[i]];
        [array addObject:imageurl];
    }
    NGGSellerHomeHeaderView *header=[[NGGSellerHomeHeaderView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [header setimageArray:array];
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    [self.tableView.tableHeaderView addSubview:header];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"CellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    [self cellsetorderInfo:cell];
    height=cell.subviews.lastObject.ngg_bottom+10;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height;
}

-(void)cellsetorderInfo:(UITableViewCell*)cell{
    /***价格***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH-40, 20)];
    Alabel.textColor=[UIColor orangeColor];
    [Alabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel.textAlignment=NSTextAlignmentLeft;
    Alabel.text=[NSString stringWithFormat:@"%@元/斤",self.order.order_goodsprice];
    [cell addSubview:Alabel];
     /***地址***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel.ngg_bottom+5, SCREEN_WIDTH/2-12, 20)];
    Alabel1.textColor=[UIColor grayColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:13]];
    Alabel1.textAlignment=NSTextAlignmentLeft;
    Alabel1.text=self.order.order_address;
    [cell addSubview:Alabel1];
    /***时间***/
    UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(Alabel1.ngg_right, Alabel1.ngg_y, SCREEN_WIDTH/2-12, 20)];
    Alabel2.textColor=[UIColor lightGrayColor];
    [Alabel2 setFont:[UIFont systemFontOfSize:13 weight:1]];
    Alabel2.textAlignment=NSTextAlignmentRight;
    Alabel2.text=self.order.order_time;
    [cell addSubview:Alabel2];
    /***详情标签***/
    UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(10, Alabel2.ngg_bottom, SCREEN_WIDTH, 25)];
    Alabel3.textColor=[UIColor grayColor];
    [Alabel3 setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel3.backgroundColor=NGGCommonBgColor;
    Alabel3.textAlignment=NSTextAlignmentLeft;
    Alabel3.text=@"货品详情";
    [cell addSubview:Alabel3];
    /***详情描述***/
    UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(20, Alabel3.ngg_bottom+10, SCREEN_WIDTH-20, 50)];
    Alabel4.textColor=[UIColor blackColor];
    [Alabel4 setFont:[UIFont systemFontOfSize:12 weight:1]];
    Alabel4.textAlignment=NSTextAlignmentCenter;
    Alabel4.text=self.order.order_goodsdesc;
    Alabel4.numberOfLines=0;
    [Alabel4 sizeToFit];
    [cell addSubview:Alabel4];
    /***补充说明标签***/
    UILabel*Alabel5=[[UILabel alloc]initWithFrame:CGRectMake(10, Alabel4.ngg_bottom, SCREEN_WIDTH, 25)];
    Alabel5.textColor=[UIColor grayColor];
    [Alabel5 setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel5.backgroundColor=NGGCommonBgColor;
    Alabel5.textAlignment=NSTextAlignmentLeft;
    Alabel5.text=@"补充说明";
    [cell addSubview:Alabel5];
    /***补充说明***/
    UILabel*Alabel6=[[UILabel alloc]initWithFrame:CGRectMake(20, Alabel5.ngg_bottom+5, SCREEN_WIDTH-20, 20)];
    Alabel6.textColor=[UIColor blackColor];
    [Alabel6 setFont:[UIFont systemFontOfSize:12 weight:1]];
    Alabel6.textAlignment=NSTextAlignmentLeft;
    Alabel6.text=self.order.order_complement;
    Alabel6.numberOfLines=0;
    [Alabel6 sizeToFit];
    [cell addSubview:Alabel6];
    /***下画线***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(10, Alabel6.ngg_bottom+8, SCREEN_WIDTH-10, 0.5)];
    view1.backgroundColor=NGGCutLineColor;
    [cell addSubview:view1];
    /***联系人标签***/
    UILabel*Alabel7=[[UILabel alloc]initWithFrame:CGRectMake(10, Alabel6.ngg_bottom+15, 60, 20)];
    Alabel7.textColor=[UIColor blackColor];
    [Alabel7 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel7.textAlignment=NSTextAlignmentCenter;
    Alabel7.text=@"联系人:";
    [cell addSubview:Alabel7];
    /***联系人***/
    UILabel*Alabel8=[[UILabel alloc]initWithFrame:CGRectMake(Alabel7.ngg_right+5, Alabel7.ngg_y, SCREEN_WIDTH-85, 20)];
    Alabel8.textColor=[UIColor grayColor];
    [Alabel8 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel8.textAlignment=NSTextAlignmentLeft;
    Alabel8.text=self.order.order_linkman;
    [cell addSubview:Alabel8];
    /***合计***/
    UILabel*Alabel9=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-135, Alabel8.ngg_bottom+20, 40, 20)];
    Alabel9.textColor=[UIColor blackColor];
    [Alabel9 setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel9.textAlignment=NSTextAlignmentRight;
    Alabel9.text=@"合计:";
    [cell addSubview:Alabel9];
    /***总价***/
    UILabel*Alabel10=[[UILabel alloc]initWithFrame:CGRectMake(Alabel9.ngg_right+5, Alabel9.ngg_y, 80, 20)];
    Alabel10.textColor=[UIColor orangeColor];
    [Alabel10 setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel10.textAlignment=NSTextAlignmentLeft;
    Alabel10.text=self.order.order_allprice;
    [cell addSubview:Alabel10];
    /***下画线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, Alabel10.ngg_bottom+8, SCREEN_WIDTH-10, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [cell addSubview:view];
    /***取消订单***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-95, view.ngg_bottom+20, 80, 25)];
    [Btn setBackgroundColor:NGGTheMeColor];
    [Btn setTitle:@"取消订单" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:16 weight:1]];
    Btn.layer.cornerRadius=5;
    Btn.layer.masksToBounds=YES;
    [Btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:Btn];
}

-(void)click:(UIButton*)sender{
    NGGAlertView *alert=[[NGGAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [alert settitle:@"您确定要取消订单?" subtitle:nil cancelTitle:@"手滑了一下" okTitle:@"决定要取消"];
    __weak NGGAlertView*weakalert=alert;
    alert.OkBlock=^{
        [self cancelOrderInfo];
        [weakalert removeFromSuperview];
    };
    alert.cancelBlock=^{
        [weakalert removeFromSuperview];
    };
    UIWindow*window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:alert];
}

#pragma mark-取消订单信息
-(void)cancelOrderInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"orderid":@(self.order.order_id)
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:CancleorderURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
        NGGLog(@"取消成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NGGLog(@"失败");
    }];
}


@end
