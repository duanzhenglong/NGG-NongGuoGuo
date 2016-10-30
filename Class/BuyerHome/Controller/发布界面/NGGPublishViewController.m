//
//  NGGPublishViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPublishSupply.h"
#import "NGGPublishViewController.h"
#import "NGGAddressSelectView.h"
@interface NGGPublishViewController () <UITextViewDelegate>{
    __block NSInteger addressid;
}

@property(strong, nonatomic) UITextField *textfield1;
@property(strong, nonatomic) UITextField *textfield2;
@property(strong, nonatomic) UITextField *textfield3;
@property(strong, nonatomic) UITextField *textfield4;
@property(strong, nonatomic) UITextField *textfield5;
@property(strong, nonatomic) UITextField *textfield6;
@property(strong, nonatomic) UITextField *textfield7;
@property(strong, nonatomic) UITextView *textview;
@property(nonatomic, strong) NSArray *DataArray;
 /***当前被选中的采购时长的按钮***/
@property (strong, nonatomic) UIButton* selectButton;
 /***采购时长***/
@property (strong, nonatomic) NSString* timeinterrval;

@end

@implementation NGGPublishViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  /*标题*/
  self.navigationItem.title = @"发布采购";
  self.textview.delegate = self;
  self.tableView.showsVerticalScrollIndicator = NO;
//  self.tableView.scrollEnabled = NO;
  /*隐藏小球*/
  [NGGPublishSupply HiddenPublishView];

  /*创建控件*/
  [self CreatCustomizeControls];
}

#pragma mark -自定义控件
- (void)CreatCustomizeControls {
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   self.tableView.tableHeaderView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  /*背景颜色*/
  self.tableView.tableHeaderView.backgroundColor = NGGCommonBgColor;

  /*添加1视图*/
  UIView *view1 =
      [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
  view1.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view1];

  UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label1.ngg_centerY = view1.ngg_height / 2;
  Label1.text = @"品种:";
  [Label1 setTextColor:NGGTheMeColor];
  [Label1 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view1 addSubview:Label1];

  self.textfield1 = [[UITextField alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 30)];
  self.textfield1.borderStyle =  UITextBorderStyleNone;
  self.textfield1.ngg_centerY = view1.ngg_height / 2;
  [view1 addSubview:self.textfield1];

  /*添加2视图*/
  UIView *view2 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view1.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view2.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view2];

  UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label2.ngg_centerY = view2.ngg_height / 2;
  Label2.text = @"产品:";
  [Label2 setTextColor:NGGTheMeColor];
  [Label2 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view2 addSubview:Label2];

  self.textfield2 = [[UITextField alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0,  SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 30)];
    self.textfield2.borderStyle = UITextBorderStyleNone;
  self.textfield2.layer.borderColor = NGGCommonBgColor.CGColor;
  self.textfield2.ngg_centerY = view2.ngg_height / 2;
  [view2 addSubview:self.textfield2];
  self.textfield1.text = self.goodsClassify;
  self.textfield2.text = self.goodsname;
  /*添加3视图*/
  UIView *view3 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view2.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view3.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view3];

  UILabel *Label3 =
      [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 23, 0, 80, 25)];
  Label3.ngg_centerY = view3.ngg_height / 2;
  Label3.text = @"采购时长:";
  [Label3 setTextColor:NGGTheMeColor];
  [Label3 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view3 addSubview:Label3];
    for (int i=0; i<3; i++) {
        /***采购时长 ***/
        UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3+i*SCREEN_WIDTH / 5, 10, 20, 20)];
        [Btn setBackgroundColor:NGGTheMeColor];
        [Btn setImage:[UIImage imageNamed:@"Oils_normal"] forState:UIControlStateSelected];    ///后期更改图片
        Btn.layer.cornerRadius=10;
        Btn.layer.masksToBounds=YES;
        Btn.tag=i*4+3+100;
        [Btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view3 addSubview:Btn];
    }
    /***3天时长***/
    for (int i=0; i<3; i++) {
        UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3+20+i*SCREEN_WIDTH / 5, 10, SCREEN_WIDTH / 5, 20)];
        Alabel.textColor=[UIColor grayColor];
        [Alabel setFont:[UIFont systemFontOfSize:14]];
        Alabel.textAlignment=NSTextAlignmentLeft;
        if (i==0) {
            Alabel.text=@"  3天";
        }else if (i==1){
            Alabel.text=@"  7天";
        }else{
            Alabel.text=@"  11天";
        }
        [view3 addSubview:Alabel];
    }
    
    UIButton *firstButton=view3.subviews[1];
    firstButton.selected=YES;
    self.selectButton=firstButton;

  /*添加4视图*/
  UIView *view4 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view3.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view4.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view4];
  UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label4.ngg_centerY = view4.ngg_height / 2;
  Label4.text = @"采购数量:";
  [Label4 setTextColor:NGGTheMeColor];
  [Label4 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view4 addSubview:Label4];

  self.textfield4 = [[UITextField alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0,  SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 30)];
    self.textfield4.borderStyle = UITextBorderStyleNone;
  self.textfield4.layer.borderColor = NGGCommonBgColor.CGColor;
  self.textfield4.ngg_centerY = view4.ngg_height / 2;
  [view4 addSubview:self.textfield4];

  /*添加5视图*/
  UIView *view5 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view4.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view5.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view5];
  UILabel *Label5 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label5.ngg_centerY = view5.ngg_height / 2;
  Label5.text = @"联系人:";
  [Label5 setTextColor:NGGTheMeColor];
  [Label5 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view5 addSubview:Label5];

  self.textfield5 = [[UITextField alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0,  SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 30)];
    self.textfield5.borderStyle = UITextBorderStyleNone;
  self.textfield5.layer.borderColor = NGGCommonBgColor.CGColor;
  self.textfield5.ngg_centerY = view5.ngg_height / 2;
  [view5 addSubview:self.textfield5];

  /*添加6视图*/
  UIView *view6 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view5.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view6.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view6];
  UILabel *Label6 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label6.ngg_centerY = view5.ngg_height / 2;
  Label6.text = @"电话:";
  [Label6 setTextColor:NGGTheMeColor];
  [Label6 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view6 addSubview:Label6];

  self.textfield6 = [[UITextField alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0,  SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 30)];
    self.textfield6.borderStyle =UITextBorderStyleNone;
  self.textfield6.layer.borderColor = NGGCommonBgColor.CGColor;
  self.textfield6.ngg_centerY = view5.ngg_height / 2;
  [view6 addSubview:self.textfield6];

  /*添加7视图*/
  UIView *view7 = [[UIView alloc]
      initWithFrame:CGRectMake(0, view6.ngg_bottom + 5, SCREEN_WIDTH, 40)];
  view7.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view7];
  UILabel *Label7 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 80, 25)];
  Label7.ngg_centerY = view6.ngg_height / 2;
  Label7.text = @"所在地:";
  [Label7 setTextColor:NGGTheMeColor];
  [Label7 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [view7 addSubview:Label7];

    /***所在地***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 10, SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 20)];
    [Btn setTitle:@"选择地区" forState:UIControlStateNormal];
    Btn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    Btn.layer.cornerRadius=5;
    Btn.layer.masksToBounds=YES;
    [Btn addTarget:self action:@selector(AddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [view7 addSubview:Btn];

  /*添加第8个label*/
  UILabel *Label8 = [[UILabel alloc]
      initWithFrame:CGRectMake(16, view7.ngg_bottom + 5, 80, 25)];
  Label8.text = @"货品描述:";
  [Label8 setTextColor:[UIColor blackColor]];
  [Label8 setFont:[UIFont systemFontOfSize:17 weight:2]];
  [self.view addSubview:Label8];

  /*添加8视图*/
  UIView *view8 = [[UIView alloc]
      initWithFrame:CGRectMake(0, Label8.ngg_bottom + 5, SCREEN_WIDTH, 100)];
  view8.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view8];
  self.textview =
      [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
  self.textview.text = @"   如产品描述、采购规模、期望价格....";
  self.textview.textColor = [UIColor lightGrayColor];
  [self.textview setFont:[UIFont systemFontOfSize:15 weight:1]];
  self.textview.textAlignment = NSTextAlignmentLeft;
  [view8 addSubview:self.textview];
  self.textview.delegate = self;

  /*创建发布button*/
  UIButton *button =
      [[UIButton alloc] initWithFrame:CGRectMake(20, view8.ngg_bottom + 75,
                                                 SCREEN_WIDTH - 40, 35)];
  [button setBackgroundColor:NGGTheMeColor];
  [button setTitle:@"确认采购" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
  [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:2]];
  [button addTarget:self
                action:@selector(ButtonClick:)
      forControlEvents:UIControlEventTouchUpInside];
  button.layer.cornerRadius = 5;
  button.layer.masksToBounds = YES;
  [self.view addSubview:button];
}

#pragma mark-所在地按钮点击事件
-(void)AddressClick:(UIButton*)sender{
    NGGAddressSelectView *address=[[NGGAddressSelectView alloc]initWithFrame:CGRectMake(-SCREEN_WIDTH/4-SCREEN_WIDTH/2, SCREEN_HEIGHT/6, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [UIView animateWithDuration:0.5 animations:^{
        address.ngg_x=SCREEN_WIDTH/4;
    }];
    [self.tableView addSubview:address];
    address.addressBlock=^(NSInteger tag,NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        addressid=tag;
    };
}

#pragma mark-采购时长的按钮点击事件
-(void)Click:(UIButton*)sender{
    self.selectButton.selected=NO;
    sender.selected=YES;
    self.selectButton=sender;
    self.timeinterrval=[NSString stringWithFormat:@"%ld",sender.tag-100];
}

#pragma mark -信息
- (void)RequireMyPurchase:(NSString *)data {
  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = myPurchaseURL;
  NSDictionary *QueryMyPurchase = @{
    @"userid" : @(USERDEFINE.currentUser.userId),
    @"status" : @"0",
    @"needlistid" : [NSString stringWithFormat:@"%@", data]

  };
  [manager POST:urlPath
      parameters:QueryMyPurchase
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NGGLog(@"发布成功！");
          [self.navigationController popToRootViewControllerAnimated:YES];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@", error);
      }];
}

#pragma mark -信息
- (void)RequirePublishPurchase {
  //初始化格式器。
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  //定义时间为这种格式： YYYY-MM-dd
  [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
  //将NSDate  ＊对象 转化为 NSString ＊对象。
  NSString *currentTime = [formatter stringFromDate:[NSDate date]];
  AFHTTPRequestOperationManager *manager =
      [[AFHTTPRequestOperationManager alloc] init];
  //必须设置
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  NSString *urlPath = AddNeedURL;
  NSDictionary *QueryMyPurchase = @{
    @"goodclassid" : [NSString stringWithFormat:@"%ld", self.tags],
    @"goodsname" : self.goodsname,
    @"timeinterrval" : self.timeinterrval,
    @"linkman" : self.textfield5.text,
    @"tel" : self.textfield6.text,
    @"desc" : self.self.textview.text,
    @"goodid" : [NSString stringWithFormat:@"%ld", self.BtnTag],
    @"plustime" : currentTime,
    @"number" : self.textfield4.text,
    @"userid" : @(USERDEFINE.currentUser.userId),
    @"addressid" :@(addressid),
    @"time" : currentTime
  };
  [manager POST:urlPath
      parameters:QueryMyPurchase
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSString *str = [NSString
            stringWithFormat:@"%@", [responseDic valueForKey:@"code"]];
        if ([str isEqualToString:@"500"]) {
        } else {
          if ([str isEqualToString:@"200"]) {
            NSString *str = [NSString
                stringWithFormat:@"%@", [responseDic valueForKey:@"data"]];
            [self RequireMyPurchase:str];
            NGGLog(@"发布成功！");
          }
        }
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@", error);
      }];
}

#pragma mark--确认发布点击事件
- (void)ButtonClick:(UIButton *)sender {
  [self RequirePublishPurchase];
}

#pragma mark -textview代理
- (void)textViewDidBeginEditing:(UITextView *)textView {
  self.textview.text = @"";
  self.textview.textAlignment = NSTextAlignmentLeft;
  [self.textview setFont:[UIFont systemFontOfSize:17 weight:1]];
  self.textview.textColor = [UIColor blackColor];
    self.tableView.ngg_y-=80;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.tableView.ngg_y+=80;
}

@end
