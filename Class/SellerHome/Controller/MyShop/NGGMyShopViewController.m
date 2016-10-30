//
//  NGGMyShopViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyShopViewController.h"
#import "NGGNewsViewCell.h"
#import "NGGGoodsProperty.h"
#import "NGGGoodsTableViewCell.h"
@interface NGGMyShopViewController ()
 /***用户头像***/
@property (strong, nonatomic) UIImageView* imageview;
 /***用户姓名***/
@property (strong, nonatomic) UILabel* nameLabel;
 /***地点***/
@property (strong, nonatomic) UILabel* addreLabel;
 /***职务***/
@property (strong, nonatomic) UILabel* professionLabel;
 /***认证头像***/
@property (strong, nonatomic) UIImageView* Vimageview;
 /***聊一聊按钮***/
@property (strong, nonatomic) UIButton* ChatBtn;
 /***数据数组***/
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGMyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [NGGPublishSupply HiddenPublishView];
    
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.sectionHeaderHeight=40;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
     /***获取用户信息***/
    [self RequireUserInfo];
    
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    view.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:view];
    
     /*图像*/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.ngg_height*2/3, view.ngg_height*2/3)];
    imageview.ngg_centerX=SCREEN_WIDTH/6;
    imageview.ngg_centerY=view.ngg_height/2;
    imageview.layer.cornerRadius=imageview.ngg_height/2;
    imageview.layer.masksToBounds=YES;
    [view addSubview:imageview];
    self.imageview=imageview;
     /*姓名*/
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+25, imageview.ngg_y, 80, 20)];
    [label1 setTextColor:NGGTheMeColor];
    label1.text=@"姓名";
    [label1 setFont:[UIFont systemFontOfSize:15 weight:1]];
    [view addSubview:label1];
    self.nameLabel=label1;
    /*地点*/
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+25, label1.ngg_bottom+5,150, 20)];
    [label2 setTextColor:NGGTheMeColor];
    label2.text=@"地点";
    [label2 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:label2];
    self.addreLabel=label2;
    /*职务*/
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+25, label2.ngg_bottom+5, 80, 20)];
    [label3 setTextColor:NGGTheMeColor];
    label3.text=@"职务";
    [label3 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:label3];
    self.professionLabel=label3;
     /*实名认证的图像*/
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 25, 25)];
    imageView1.ngg_centerX=imageview.ngg_centerX+25;
    imageView1.ngg_centerY=imageview.ngg_centerY-25;
    imageView1.image=[UIImage imageNamed:@"shi"];
    [view addSubview:imageView1];
    self.Vimageview=imageView1;
     /*聊一聊*/
    UIButton*ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 50, 25)];
    ChatBtn.ngg_x=SCREEN_WIDTH-64;
    ChatBtn.layer.cornerRadius=5;
    ChatBtn.layer.masksToBounds=YES;
    [ChatBtn setBackgroundColor:NGGTheMeColor];
    [ChatBtn setTitle:@"聊一聊" forState:UIControlStateNormal];
    [ChatBtn.titleLabel setFont:[UIFont systemFontOfSize:13 weight:1]];
    [ChatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ChatBtn addTarget:self action:@selector(ChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:ChatBtn];
    self.ChatBtn=ChatBtn;
}

#pragma mark-获取用户信息
-(void)RequireUserInfo{
    
    // **判断聊一聊按钮存在情况，如果与当前登陆用户的id一致则移除**
    if (self.userid==USERDEFINE.currentUser.userId) {
        [self.ChatBtn removeFromSuperview];
    }
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",self.userid],//用户id 
                                   @"type":@"1"
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inquireUserInfoURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            NSDictionary*dic=responseObject[@"data"];
            self.nameLabel.text=dic[@"user_nick"];
            self.addreLabel.text=dic[@"address_name"];
            self.professionLabel.text=dic[@"profession_job"];
            NSString*path=[NSString stringWithFormat:@"%@%@",HeaderPrefix,dic[@"user_headimage"]];
            NSURL *url=[NSURL URLWithString:path];
            /***下载用户头像***/
            [self.imageview sd_setImageWithURL:url];
            if ([dic[@"user_certification"] isEqualToString:@"0"]) {
                [self.Vimageview removeFromSuperview];
            }
             /***获取在售数据***/
            [self inqureMySupplyInfo];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-获取我的在售的数据
-(void)inqureMySupplyInfo{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",self.userid],//self.userid;
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:mysupplyURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            /***判断是否过时***/
            //  if ([NGGdate Stratime:responseObject[@"agreetime"] andTimeinterval:3]==YES) {
            self.DataArray=[NGGGoodsProperty mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
            //            }
        }else{
            NGGLogFunc
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-聊一聊Button的点击事件
-(void)ChatBtnClick:(UIButton *)sender{
    NGGLogFunc
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellID=@"CellId";
    NGGGoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    NGGGoodsProperty*property=self.DataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell initWithForm:property];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel*Label=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 20)];
    Label.ngg_centerY=view.ngg_height/2;
    Label.text=@"在售货品";
    [Label setTextColor:NGGTheMeColor];
    [Label setFont:[UIFont systemFontOfSize:12 weight:1]];
    [view addSubview:Label];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

@end
