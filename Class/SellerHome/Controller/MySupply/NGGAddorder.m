//
//  NGGAddorder.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddorder.h"
#import "NGGAddressSelectView.h"
#import "NGGAlertView.h"
@interface NGGAddorder()<UITextFieldDelegate>
 /***图片***/
@property (strong, nonatomic) UIImageView* Goodsimage;
 /***货品名称***/
@property (strong, nonatomic) UILabel* nameLabel;
 /***剩余时间***/
@property (strong, nonatomic) UILabel* timeLabel;
 /***采购数量***/
@property (strong, nonatomic) UITextField* numTextField;
 /***总价***/
@property (strong, nonatomic) UILabel* priceLabel;
 /***补充说明***/
@property (strong, nonatomic) UITextView* addTextview;
 /***收货地址***/
@property (strong, nonatomic) UIButton* addressBtn;
@end

@implementation NGGAddorder

-(void)setProperty:(NGGGoodsProperty *)property{
    _property=property;
     /***下载图片***/
    NSArray*array=[self.property.supplylist_image componentsSeparatedByString:@".png"];
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,array[0]];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    [self.Goodsimage sd_setImageWithURL:UrlImageUrl];
    self.nameLabel.text=self.property.supplylist_goodsname;
    self.timeLabel.text=self.property.supplylist_time;
}

#pragma mark-取消按钮
-(void)cancelClick:(UIButton*)sender{
    NGGAlertView *alert=[[NGGAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [alert settitle:@"您确定取消本次订单吗?" subtitle:@"如有任何疑问可随时联系我们:2199396197" cancelTitle:@"放弃" okTitle:@"继续填写"];
    alert.cancelBlock=^{
        [self removeFromSuperview];
    };
    __weak NGGAlertView *weakalert=alert;
    alert.OkBlock=^{
        [weakalert removeFromSuperview];
    };
    [self addSubview:alert];
}

#pragma mark-提交订单按钮
-(void)commitClick:(UIButton*)sender{
     /***进行判断***/
    if ([self.numTextField.text isEqualToString:@""]){
        [self NoticeInfo:@"采购数量不能为空!"];return;
    }
    if ([self.addressBtn.titleLabel.text isEqualToString:@"您还未选择收货地址"]){
        [self NoticeInfo:@"您还没有选择收货地址!"];return;
    }
    [self loadOrderInfo];
}

#pragma mark-获取提示信息
-(void)NoticeInfo:(NSString *)message{
    UILabel *NoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NoticeLabel.center=CGPointMake(self.ngg_width/2, self.ngg_height-65);
    NoticeLabel.text=message;
    NoticeLabel.textAlignment=NSTextAlignmentCenter;
    NoticeLabel.textColor=[UIColor whiteColor];
    NoticeLabel.backgroundColor=[UIColor grayColor];
    NoticeLabel.layer.cornerRadius=6;
    NoticeLabel.layer.masksToBounds=YES;
    //动画效果
    [UIView animateWithDuration:2.5 animations:^{
        NoticeLabel.alpha=1;
        [self addSubview:NoticeLabel];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.5 animations:^{
            NoticeLabel.alpha=0;
        }];
    }];
}

#pragma mark-地址按钮
-(void)AddressClick:(UIButton*)sender{
    NGGLogFunc
}

#pragma mark-上传订单信息
-(void)loadOrderInfo{
    NSString*numNo=[self generateTradeNO];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"num":numNo,
                                   @"goodsname":self.property.supplylist_goodsname,
                                   @"goodsprice":self.property.supplylist_price,
                                   @"goodsimage":self.property.supplylist_image,
                                   @"goodsdesc":self.property.supplylist_desc,
                                   @"linkman":self.property.user_nick,
                                   @"address":self.addressBtn.titleLabel.text,
                                   @"goodsnum":self.numTextField.text,
                                   @"allprice":self.priceLabel.text,
                                   @"sellerid":@(self.property.user_id),
                                   @"buyid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],//买家id
                                   @"complement":self.addTextview.text//补充说明信息
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:addorderURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NGGLog(@"上传成功");
        [self removeFromSuperview];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NGGLog(@"上传失败");
    }];
}

#pragma mark-产生订单号
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark-text代理
-(void)textFieldDidEndEditing:(UITextField *)textField{
    double num=[textField.text doubleValue];
    double price=[self.property.supplylist_price doubleValue];
    double sum=num *price;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%.2f元",sum];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        /***购买背景***/
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, SCREEN_HEIGHT*2/3)];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        /***图片***/
        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/7, -30, SCREEN_WIDTH/4, SCREEN_WIDTH/4)];
        imageview.backgroundColor=NGGRandomColor;
        [view addSubview:imageview];
        self.Goodsimage=imageview;
        /***货品标题***/
        UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, 15, SCREEN_WIDTH*17/28-22, 20)];
        Alabel.textColor=[UIColor orangeColor];
        [Alabel setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel.textAlignment=NSTextAlignmentLeft;
        Alabel.text=@"好吃的水果";
        [view addSubview:Alabel];
        self.nameLabel=Alabel;
        /***剩余时间***/
        UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, Alabel.ngg_bottom, 15, 15)];
        imageview1.backgroundColor=NGGRandomColor;
        [view addSubview:imageview1];
        /***剩余时间***/
        UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(imageview1.ngg_right+5, Alabel.ngg_bottom, SCREEN_WIDTH/3, 20)];
        Alabel1.textColor=[UIColor orangeColor];
        [Alabel1 setFont:[UIFont systemFontOfSize:10]];
        Alabel1.textAlignment=NSTextAlignmentLeft;
        Alabel1.text=@"还剩余12天";
        [view addSubview:Alabel1];
        self.timeLabel=Alabel1;
        /***下画线***/
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, imageview.ngg_bottom+10, SCREEN_WIDTH, 0.5)];
        view1.backgroundColor=NGGCutLineColor;
        [view addSubview:view1];
        /***数量金额标签***/
        UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(12, view1.ngg_bottom, SCREEN_WIDTH, 25)];
        Alabel2.textColor=[UIColor grayColor];
        [Alabel2 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel2.backgroundColor=NGGCommonBgColor;
        Alabel2.textAlignment=NSTextAlignmentLeft;
        Alabel2.text=@"数量金额";
        [view addSubview:Alabel2];
        /***采购数量标签***/
        UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(15, Alabel2.ngg_bottom+10, 80, 25)];
        Alabel3.textColor=[UIColor blackColor];
        [Alabel3 setFont:[UIFont systemFontOfSize:16 weight:1]];
        Alabel3.textAlignment=NSTextAlignmentLeft;
        Alabel3.text=@"采购数量";
        [view addSubview:Alabel3];
        /***输入的金额***/
        UITextField*Text=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/3-45, Alabel3.ngg_y, SCREEN_WIDTH/3+20, 25)];
        Text.placeholder=@"请输入采购数量";
        [Text setFont:[UIFont systemFontOfSize:15]];
        Text.textAlignment=NSTextAlignmentRight;
        [view addSubview:Text];
        self.numTextField=Text;
        self.numTextField.delegate=self;
        /***斤***/
        UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(Text.ngg_right+5, Text.ngg_y, 20, 25)];
        Alabel4.textColor=[UIColor orangeColor];
        [Alabel4 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel4.textAlignment=NSTextAlignmentLeft;
        Alabel4.text=@"斤";
        [view addSubview:Alabel4];
        /***合计标签***/
        UILabel*Alabel5=[[UILabel alloc]initWithFrame:CGRectMake(15, Alabel3.ngg_bottom+10, 60, 25)];
        Alabel5.textColor=[UIColor blackColor];
        [Alabel5 setFont:[UIFont systemFontOfSize:16 weight:1]];
        Alabel5.textAlignment=NSTextAlignmentLeft;
        Alabel5.text=@"合计";
        [view addSubview:Alabel5];
        /***合计金额***/
        UILabel*Alabel6=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-105, Alabel5.ngg_y, 100, 25)];
        Alabel6.textColor=[UIColor blackColor];
        [Alabel6 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel6.textAlignment=NSTextAlignmentCenter;
        Alabel6.text=@"¥0.00元";
        [view addSubview:Alabel6];
        self.priceLabel=Alabel6;
        /***补充说明标签***/
        UILabel*Alabel7=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel5.ngg_bottom, SCREEN_WIDTH, 25)];
        Alabel7.textColor=[UIColor grayColor];
        [Alabel7 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel7.backgroundColor=NGGCommonBgColor;
        Alabel7.textAlignment=NSTextAlignmentLeft;
        Alabel7.text=@"补充说明";
        [view addSubview:Alabel7];
        /***补充说明内容***/
        UITextView *textview=[[UITextView alloc]initWithFrame:CGRectMake(0, Alabel7.ngg_bottom, SCREEN_WIDTH, 50)];
        textview.backgroundColor=[UIColor whiteColor];
        textview.textColor=[UIColor lightGrayColor];
        [view addSubview:textview];
        self.addTextview=textview;
        /***收货地址标签***/
        UILabel*Alabel8=[[UILabel alloc]initWithFrame:CGRectMake(12, textview.ngg_bottom, SCREEN_WIDTH, 25)];
        Alabel8.textColor=[UIColor grayColor];
        [Alabel8 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel8.backgroundColor=NGGCommonBgColor;
        Alabel8.textAlignment=NSTextAlignmentLeft;
        Alabel8.text=@"收货地址";
        [view addSubview:Alabel8];
        /***收货地址图标***/
        UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(18, Alabel8.ngg_bottom+15, 15, 15)];
        imageview2.backgroundColor=NGGRandomColor;
        [view addSubview:imageview2];
        /***收货地址button***/
        UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(imageview2.ngg_right, Alabel8.ngg_bottom+10, SCREEN_WIDTH-30, 30)];
        [Btn setTitle:@"您还未选择收货地址" forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
        [Btn addTarget:self action:@selector(AddressClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
        self.addressBtn=Btn;
        /***确认订单***/
        UIButton* Btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, view.ngg_height-45, SCREEN_WIDTH, 45)];
        [Btn1 setBackgroundColor:NGGTheMeColor];
        [Btn1 setTitle:@"提交订单" forState:UIControlStateNormal];
        [Btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [Btn1.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1]];
        [Btn1 addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn1];
        /***取消按钮***/
        UIButton* Btn2=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 5, 25, 25)];
        [Btn2 setBackgroundColor:NGGTheMeColor];
        [Btn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [Btn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [Btn2 addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn2];
    }
    return self;
}
@end
