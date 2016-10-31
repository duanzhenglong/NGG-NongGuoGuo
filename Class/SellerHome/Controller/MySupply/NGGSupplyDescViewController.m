//
//  NGGSupplyDescViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSupplyDescViewController.h"
#import "NGGSupplydesViewCell.h"
#import "NGGSupplyImageViewCell.h"
#import "NGGMyShopViewController.h"
#import "NGGTSearchView.h"
#import "NGGAddorder.h"
@interface NGGSupplyDescViewController ()
 /***图片数组***/
@property (strong, nonatomic) NSArray* imageArray;
@end

@implementation NGGSupplyDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NGGTSearchView HiddenSeatchView];
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.sectionHeaderHeight=40;
    self.tableView.sectionFooterHeight=50;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 330)];
    self.tableView.tableHeaderView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     /***接收所有图片***/
    [self setimageArray];
     /***创建控件***/
    [self CreatCustomizeControls];
    
}

#pragma mark-接收所有图片
-(void)setimageArray{
    self.imageArray=[self.attribute.supplylist_image componentsSeparatedByString:@".png"];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
     /***创建顶部图片***/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.view addSubview:imageview];
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,self.imageArray[0]];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    [imageview sd_setImageWithURL:UrlImageUrl];
    /***货品名称***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, imageview.ngg_bottom+15, SCREEN_WIDTH/2, 20)];
    Alabel.textColor=[UIColor blackColor];
    [Alabel setFont:[UIFont systemFontOfSize:17 weight:1]];
    Alabel.text=self.attribute.supplylist_goodsname;
    [self.view addSubview:Alabel];
    
    /***地区***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel.ngg_bottom+10, SCREEN_WIDTH/2, 20)];
    Alabel1.textColor=[UIColor grayColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:14]];
    Alabel1.text=self.attribute.address_name;
    [self.view addSubview:Alabel1];
    /***价格***/
    UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel1.ngg_bottom+10, 0, 40)];
    Alabel2.textColor=[UIColor orangeColor];
    [Alabel2 setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel2.text=[NSString stringWithFormat:@"%@元/斤",self.attribute.supplylist_price];
    NSDictionary *attrs1 = @{NSFontAttributeName : [UIFont systemFontOfSize:20]};
    CGSize size1=[Alabel2.text sizeWithAttributes:attrs1];
    Alabel2.ngg_width=size1.width;
    [self.view addSubview:Alabel2];
    /***最小起批量***/
    UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(Alabel2.ngg_right+5, Alabel2.ngg_y+10,0, 20)];
    Alabel3.textColor=[UIColor whiteColor];
    [Alabel3 setFont:[UIFont systemFontOfSize:12 weight:1]];
    Alabel3.backgroundColor=[UIColor orangeColor];
    Alabel3.text=[NSString stringWithFormat:@"%@斤起批",self.attribute.supplylist_minnumber];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size=[Alabel3.text sizeWithAttributes:attrs];
    Alabel3.ngg_width=size.width;
    [self.view addSubview:Alabel3];
    /***下划线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 330, SCREEN_WIDTH, 1)];
    view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:view];
    /***剩余时间***/
    UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, Alabel.ngg_y, 110, 20)];
    Alabel4.textColor=[UIColor grayColor];
    [Alabel4 setFont:[UIFont systemFontOfSize:12 weight:1]];
    Alabel4.textAlignment=NSTextAlignmentCenter;
    Alabel4.text=self.attribute.supplylist_time;
    [self.view addSubview:Alabel4];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        static NSString* CellID=@"Cellid";
        NGGSupplydesViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell=[[NGGSupplydesViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        [cell setLabelContent:self.attribute.supplylist_desc];
        return cell;
    }
    static NSString* CellID=@"CellId";
   NGGSupplyImageViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGSupplyImageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    [cell setimageviewfrom:self.imageArray[indexPath.row-1]];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    /***详情描述***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor=NGGCommonBgColor;
    /***描述***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 10, 100, 30)];
    Alabel.textColor=[UIColor darkGrayColor];
    [Alabel setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel.text=@"详情描述：";
    [view addSubview:Alabel];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    /***详情描述***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor=NGGCommonBgColor;
    /***立即买按钮***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 50)];
    [Btn setBackgroundColor:NGGTheMeColor];
    [Btn setTitle:@"立即买" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    [Btn addTarget:self action:@selector(BuyGoods:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    /***聊一聊***/
    UIButton* Btn1=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+1, 0, SCREEN_WIDTH/2-1, 50)];
    [Btn1 setBackgroundColor:NGGTheMeColor];
    [Btn1 setTitle:@"聊一聊" forState:UIControlStateNormal];
    [Btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Btn1.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    [Btn1 addTarget:self action:@selector(ClickChat:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn1];
    return view;
}

#pragma mark-下订单
-(void)BuyGoods:(UIButton*)sender{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    NGGAddorder *addorder=[[NGGAddorder alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [UIView animateWithDuration:0.5 animations:^{
        addorder.ngg_y=0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            addorder.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
        }];
    }];
    addorder.property=self.attribute;
    [window addSubview:addorder];
    
}

#pragma mark-聊一聊事件
-(void)ClickChat:(UIButton*)sender{
    NGGLogFunc;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return self.attribute.desHegiht;
    }
    return 300;
}

@end
