//
//  NGGDetailTableViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGDetailTableViewController.h"
#import "NGGQuoteViewController.h"
#import "NGGSearchView.h"
#import "NGGLobbydetailViewCell.h"
#import "NSCalendar+NGGCalendar.h"
@interface NGGDetailTableViewController ()<UITableViewDataSource,UITableViewDelegate>
 /***买家头像***/
@property (strong, nonatomic) UIImageView* imageview;
 /***实名认证图片***/
@property (strong, nonatomic) UIImageView* Vimageview;
 /***买家姓名***/
@property (strong, nonatomic) UILabel* nameLabel;
 /***地点***/
@property (strong, nonatomic) UILabel* addreLabel;
 /***职务***/
@property (strong, nonatomic) UILabel* professionLabel;
 /***还剩多长时间的Label***/
@property (strong, nonatomic) UILabel* surplustimeLabel;
@property (strong, nonatomic) UIView* view7;
@end

@implementation NGGDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     /*隐藏供应和搜索view*/
    [NGGPublishSupply HiddenPublishView];
    [NGGSearchView HiddenSeatchView];
    
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    self.tableView.sectionFooterHeight=60;
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(collectClick:)];
    self.navigationItem.rightBarButtonItem=button;
    /**]
     *  创建控件
     */
    [self CreatCustomizeControls];
     /***查询用户信息***/
    [self RequireUserInfo];
     /***获取还剩多长时间***/
     self.surplustimeLabel.text=[NGGdate stratime:self.attribute.needlist_surplustime andTimeinterval:[self.attribute.needlist_timeinterval intValue]];

}

-(void)collectClick:(UIBarButtonItem*)sender{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"userid":@(USERDEFINE.currentUser.userId),
                                   @"needlistid":@(self.attribute.needlist_id)
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:scollectgoodsURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        [self NoticeInfo:str];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


#pragma mark-获取提示信息
-(void)NoticeInfo:(NSString *)message{
    
    UILabel *NoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NoticeLabel.center=CGPointMake(self.view.ngg_width/2, self.view.ngg_height/2);
    NoticeLabel.text=message;
    NoticeLabel.textAlignment=NSTextAlignmentCenter;
    NoticeLabel.textColor=[UIColor whiteColor];
    NoticeLabel.backgroundColor=[UIColor grayColor];
    NoticeLabel.layer.cornerRadius=6;
    NoticeLabel.layer.masksToBounds=YES;
    //动画效果
    [UIView animateWithDuration:2.5 animations:^{
        NoticeLabel.alpha=1;
        [self.view addSubview:NoticeLabel];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.5 animations:^{
            NoticeLabel.alpha=0;
        }];
    }];
}

#pragma mark-查询用户信息
-(void)RequireUserInfo{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",self.attribute.user_id],
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
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
    }];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
     /***时间Label***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
     Alabel.textColor=[UIColor orangeColor];
    [Alabel setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"剩余还有多少时间";
    [self.view addSubview:Alabel];
    self.surplustimeLabel=Alabel;
     /***个人信息背景***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 105)];
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
    [label2 setTextColor:[UIColor grayColor]];
    label2.text=@"地点";
    [label2 setFont:[UIFont systemFontOfSize:13]];
    [view addSubview:label2];
    self.addreLabel=label2;
    /*职务*/
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+25, label2.ngg_bottom+5, 80, 20)];
    [label3 setTextColor:[UIColor grayColor]];
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
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    /***背景***/
    UIView *view7=[[UIView alloc]initWithFrame:CGRectMake(0, window.ngg_height-50, SCREEN_WIDTH, 50)];
    view7.backgroundColor=[UIColor whiteColor];
    [window addSubview:view7];
    self.view7=view7;
    /*创建去报价Button*/
    UIButton*DscButton=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 40)];
    [DscButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    [DscButton setTitle:@"去报价" forState:UIControlStateNormal];
    [DscButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [DscButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    DscButton.layer.cornerRadius=5;
    DscButton.layer.masksToBounds=YES;
    [DscButton setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
    [DscButton addTarget:self action:@selector(DscButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view7 addSubview:DscButton];

}

#pragma tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"CellId";
    NGGLobbydetailViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[NGGLobbydetailViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    [cell setContentFrom:self.attribute];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT-180;
}

#pragma mark-报价
-(void)DscButtonClick:(UIButton*)sender{
    NGGQuoteViewController*quote=[[NGGQuoteViewController alloc]init];
    quote.goodsname=self.attribute.needlist_goodsname;
    quote.byerid=self.attribute.user_id;
    [self.navigationController pushViewController:quote animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view7 removeFromSuperview];
}

@end
