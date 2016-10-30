//
//  NGGQuoteViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//  报价单

#import "NGGQuoteViewController.h"
#import "NGGLobbyViewController.h"
@interface NGGQuoteViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextField* textfield1;
@property (strong, nonatomic) UITextField* textfield2;
@property (strong, nonatomic) UITextField* textfield3;
@property (strong, nonatomic) UITextField* textfield4;
@property (strong, nonatomic) UITextView* textview;
@end

@implementation NGGQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=NGGCommonBgColor;
    self.navigationItem.title=@"报价";
     /*创建控件*/
    [self CreatCustomizeControls];
}

#pragma mark-创建控件
-(void)CreatCustomizeControls{
     /*添加1视图*/
    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 84, SCREEN_WIDTH, 40)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel*Label1=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label1.ngg_centerY=view1.ngg_height/2;
    Label1.text=@"供货地:";
    [Label1 setTextColor:NGGTheMeColor];
    [Label1 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view1 addSubview:Label1];
    
    self.textfield1=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-16, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield1.borderStyle=UITextBorderStyleLine;
    self.textfield1.layer.borderWidth=1;
    self.textfield1.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield1.ngg_centerY=view1.ngg_height/2;
    [view1 addSubview:self.textfield1];
    /*添加2视图*/
    UIView*view2=[[UIView alloc]initWithFrame:CGRectMake(0, view1.ngg_bottom+10, SCREEN_WIDTH, 40)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel*Label2=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label2.ngg_centerY=view2.ngg_height/2;
    Label2.text=@"供货量:";
    [Label2 setTextColor:NGGTheMeColor];
    [Label2 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view2 addSubview:Label2];
    
     self.textfield2=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-16, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield2.borderStyle=UITextBorderStyleLine;
    self.textfield2.layer.borderWidth=1;
    self.textfield2.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield2.ngg_centerY=view2.ngg_height/2;
    [view2 addSubview:self.textfield2];
    /*添加3视图*/
    UIView*view3=[[UIView alloc]initWithFrame:CGRectMake(0, view2.ngg_bottom+10, SCREEN_WIDTH, 40)];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view3];
    
    UILabel*Label3=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label3.ngg_centerY=view3.ngg_height/2;
    Label3.text=@"供货价格:";
    [Label3 setTextColor:NGGTheMeColor];
    [Label3 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view3 addSubview:Label3];
    
    self.textfield3=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-14, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield3.borderStyle=UITextBorderStyleLine;
    self.textfield3.layer.borderWidth=1;
    self.textfield3.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield3.ngg_centerY=view3.ngg_height/2;
    [view3 addSubview:self.textfield3];
    /*添加4视图*/
    UIView*view4=[[UIView alloc]initWithFrame:CGRectMake(0, view3.ngg_bottom+10, SCREEN_WIDTH, 40)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    UILabel*Label4=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label4.ngg_centerY=view4.ngg_height/2;
    Label4.text=@"联系人:";
    [Label4 setTextColor:NGGTheMeColor];
    [Label4 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view4 addSubview:Label4];
    
    self.textfield4=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-16, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield4.borderStyle=UITextBorderStyleLine;
    self.textfield4.layer.borderWidth=1;
    self.textfield4.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield4.ngg_centerY=view4.ngg_height/2;
    [view4 addSubview:self.textfield4];
    /*添加5视图*/
    UIView*view5=[[UIView alloc]initWithFrame:CGRectMake(0, view4.ngg_bottom+10, SCREEN_WIDTH, 200)];
    view5.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view5];
    
    self.textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.textview.text=@"填写更多关于你的产品信息.......";
    self.textview.textColor=[UIColor lightGrayColor];
    [self.textview setFont:[UIFont systemFontOfSize:16 weight:3]];
    self.textview.textAlignment=NSTextAlignmentCenter;
    [view5 addSubview:self.textview];
    self.textview.delegate=self;
    
     /*创建报价button*/
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-60, SCREEN_WIDTH-40, 45)];
    [button setBackgroundColor:NGGTheMeColor];
    [button setTitle:@"报  价" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:22 weight:3]];
    [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [self.view addSubview:button];
}

-(void)ButtonClick:(UIButton*)sender{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"place":self.textfield1.text,
                                   @"number":self.textfield2.text,
                                   @"price":self.textfield3.text,
                                   @"desc":self.textview.text,
                                   @"userid":@"1",//卖家id
                                   @"userid1":[NSString stringWithFormat:@"%d",self.byerid],//买家id
                                   @"goodsname":self.goodsname,
                                   @"mask":@"0",
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:publishQuotationURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"报价成功!"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-textview代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.textview.text=@"";
    self.textview.textAlignment=NSTextAlignmentLeft;
    [self.textview setFont:[UIFont systemFontOfSize:15 weight:1]];
    self.textview.textColor=[UIColor blackColor];
}

#pragma mark-键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
