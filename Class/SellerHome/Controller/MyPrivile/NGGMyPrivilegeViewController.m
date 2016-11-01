//
//  NGGMyPrivilegeViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyPrivilegeViewController.h"
#import "NGGResetButton.h"
#import "NGGIphoneDetailViewController.h"
#import "NGGMemberViewController.h"
@interface NGGMyPrivilegeViewController ()
 /***用户头像***/
@property (strong, nonatomic) UIImageView* imageview;
 /***用户姓名***/
@property (strong, nonatomic) UILabel* nameLabel;
 /***特权值***/
@property (strong, nonatomic) UILabel* privirlege;

@property (strong, nonatomic) UIView* infoview;
@property (strong, nonatomic) UILabel* iphonelabel;
@property (strong, nonatomic) UILabel* memberLabel;

@end

@implementation NGGMyPrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [NGGPublishSupply HiddenPublishView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognizerclick:)];
    [self.tableView.tableHeaderView addGestureRecognizer:tap];
    self.navigationItem.title=@"我的特权";
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
     /***获取用户信息及特权信息***/
    [self qurieinfoUserAndPrivilge];
}

#pragma mark-获取用户信息及特权信息
-(void)qurieinfoUserAndPrivilge{
     /***下载用户头像***/
    NSString* urlstring=[NSString stringWithFormat:@"%@%@",HeaderPrefix,USERDEFINE.currentUser.userHeadimage];
    NSURL*url=[NSURL URLWithString:urlstring];
    [self.imageview sd_setImageWithURL:url];
    self.nameLabel.text=USERDEFINE.currentUser.userNick;
    
     /***获取特权信息***/
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                                                      };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inqurePrivilegeURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        int num1=0;
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功!"]) {
            NSArray*arr=responseObject[@"result"];
            for (int i=0; i<arr.count; i++) {
                NSDictionary*dic=arr[i];
                if ([dic[@"privilege_id"] isEqualToString:@"1"]) {
                    num1+=100;
                }else{
                    num1+=200;
                }
            }
            self.privirlege.text=[NSString stringWithFormat:@"%d",num1];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
    /***背景***/
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view2.backgroundColor=NGGColorFromRGB(0x41a5fd);
    [self.tableView.tableHeaderView addSubview:view2];
    /*图像*/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 30, 30)];
    imageview.layer.cornerRadius=imageview.ngg_height/2;
    imageview.layer.masksToBounds=YES;
    [view2 addSubview:imageview];
    self.imageview=imageview;
    /*姓名*/
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+5, 0, 60, 20)];
    label1.ngg_centerY=imageview.ngg_centerY;
    [label1 setTextColor:[UIColor blackColor]];
    label1.text=@"姓名";
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [view2 addSubview:label1];
    self.nameLabel=label1;
    /*圈圈图像*/
    UIImageView*Circleimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    Circleimage.ngg_centerX=SCREEN_WIDTH/2;
    Circleimage.ngg_centerY=SCREEN_HEIGHT/4;
    Circleimage.backgroundColor=[UIColor whiteColor];
    Circleimage.layer.cornerRadius=Circleimage.ngg_height/2;
    Circleimage.layer.masksToBounds=YES;
    [view2 addSubview:Circleimage];
    /*圈圈图像*/
    UIImageView*Circleimage1=[[UIImageView alloc]initWithFrame:CGRectMake(0.5,0.5 , SCREEN_WIDTH/2-1, SCREEN_WIDTH/2-1)];
    Circleimage1.backgroundColor=NGGColorFromRGB(0x41a5fd);
    Circleimage1.layer.cornerRadius=Circleimage1.ngg_height/2;
    Circleimage1.layer.masksToBounds=YES;
    [Circleimage addSubview:Circleimage1];
    /*特权值标签*/
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 20)];
    label2.ngg_centerY=Circleimage1.ngg_centerY-25;
    label2.ngg_centerX=Circleimage1.ngg_centerX;
    [label2 setTextColor:[UIColor whiteColor]];
    label2.text=@"特权值";
    label2.textAlignment=NSTextAlignmentCenter;
    [label2 setFont:[UIFont systemFontOfSize:15 weight:1]];
    [Circleimage1 addSubview:label2];
    /*特权值*/
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0,label2.ngg_bottom+5,80, 40)];
    label3.ngg_centerX=Circleimage1.ngg_centerX;
    [label3 setTextColor:[UIColor whiteColor]];
    label3.text=@"668";
    label3.textAlignment=NSTextAlignmentCenter;
    [label3 setFont:[UIFont systemFontOfSize:30 ]];
    [Circleimage1 addSubview:label3];
    self.privirlege=label3;
    view2.ngg_height=view2.subviews.lastObject.ngg_bottom+20;
    /***查看我的特权信息***/
    UILabel*Alabel7=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, 25, 92, 30)];
    Alabel7.textColor=[UIColor whiteColor];
    [Alabel7 setFont:[UIFont systemFontOfSize:14]];
    Alabel7.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.4];
    Alabel7.textAlignment=NSTextAlignmentCenter;
    Alabel7.layer.cornerRadius=5;
    Alabel7.layer.masksToBounds=YES;
    Alabel7.text=@"查看我的特权";
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognizer:)];
    [Alabel7 addGestureRecognizer:tap];
    Alabel7.userInteractionEnabled=YES;
    [self.tableView.tableHeaderView addSubview:Alabel7];
    
     /*背景view2*/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(12,Circleimage.ngg_bottom+30, SCREEN_WIDTH-24, SCREEN_HEIGHT/4)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.cornerRadius=8;
    view1.layer.masksToBounds=YES;
    [self.tableView.tableHeaderView addSubview:view1];
    /*提示文字*/
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(0,10,150, 30)];
    label4.ngg_centerX=view1.ngg_centerX;
    [label4 setTextColor:[UIColor redColor]];
    label4.text=@"目前可享受以下特权:";
    label4.textAlignment=NSTextAlignmentCenter;
    [label4 setFont:[UIFont systemFontOfSize:15 ]];
    [view1 addSubview:label4];
     /*电话特权按钮*/
    NGGResetButton *iphoneBtn = [NGGResetButton buttonWithType:UIButtonTypeCustom];
    iphoneBtn.frame=CGRectMake(0,label4.ngg_bottom+18, view1.ngg_width/3, 65);
    [iphoneBtn setImage:[UIImage imageNamed:@"MyGoods_normal"] forState:UIControlStateNormal];
    [iphoneBtn setImage:[UIImage imageNamed:@"MyGoods_Selected"] forState:UIControlStateHighlighted];
    [iphoneBtn setTitle:@"电话特权" forState:UIControlStateNormal];
    [iphoneBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [iphoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iphoneBtn addTarget:self action:@selector(iphoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:iphoneBtn];
    /*会员特权按钮*/
    NGGResetButton *memberBtn = [NGGResetButton buttonWithType:UIButtonTypeCustom];
    memberBtn.frame=CGRectMake(view1.ngg_width/3,label4.ngg_bottom+18, view1.ngg_width/3, 65);
    [memberBtn setImage:[UIImage imageNamed:@"MyGoods_normal"] forState:UIControlStateNormal];
    [memberBtn setImage:[UIImage imageNamed:@"MyGoods_Selected"] forState:UIControlStateHighlighted];
    [memberBtn setTitle:@"会员特权" forState:UIControlStateNormal];
    [memberBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [memberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [memberBtn addTarget:self action:@selector(memberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:memberBtn];
    /*更多特权按钮*/
    NGGResetButton *moreBtn = [NGGResetButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame=CGRectMake(view1.ngg_width/3*2,label4.ngg_bottom+18, view1.ngg_width/3, 65);
    [moreBtn setImage:[UIImage imageNamed:@"MyGoods_normal"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"MyGoods_Selected"] forState:UIControlStateHighlighted];
    [moreBtn setTitle:@"更多特权" forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:moreBtn];
    
    /***标签***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(0, view1.ngg_bottom+5, 80, 20)];
    Alabel.textColor=[UIColor blackColor];
    Alabel.ngg_centerX=SCREEN_WIDTH/2;
    [Alabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"特权说明";
    [self.tableView.tableHeaderView addSubview:Alabel];
    /***分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, view1.ngg_bottom+15, 60, 1)];
    view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.6];
    view.ngg_right=Alabel.ngg_x;
    [self.tableView.tableHeaderView addSubview:view];
    /***分割线***/
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(Alabel.ngg_right, view1.ngg_bottom+15, 60, 1)];
    view4.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.tableView.tableHeaderView addSubview:view4];
    /***说明***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(20, Alabel.ngg_bottom+10, SCREEN_WIDTH-30, 20)];
    Alabel1.textColor=[UIColor blackColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:11]];
    Alabel1.text=@"1.电话特权是平台为中小注册用户开放的快速成长特权,可帮助大家快速找到自己的目标用户\n2.排名优先，让卖家更快的发现，扩大商机";
    Alabel1.numberOfLines=0;
    [Alabel1 sizeToFit];
    [self.tableView.tableHeaderView addSubview:Alabel1];
}

-(void)tapRecognizer:(UITapGestureRecognizer*)Gesture{
    UIView*privilView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 25, SCREEN_WIDTH/2, SCREEN_HEIGHT/3)];
    privilView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.6];
    privilView.layer.cornerRadius=5;
    privilView.layer.masksToBounds=YES;
    [UIView animateWithDuration:0.5 animations:^{
        privilView.ngg_x=SCREEN_WIDTH/2;
    }];
    
    [self.tableView.tableHeaderView addSubview:privilView];
    self.infoview=privilView;
    /***特权信息标签***/
    UILabel*Alabel8=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, privilView.ngg_width, 15)];
    Alabel8.textColor=[UIColor whiteColor];
    [Alabel8 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel8.textAlignment=NSTextAlignmentCenter;
    Alabel8.text=@"特权信息";
    [privilView addSubview:Alabel8];
    /***分割线***/
    UIView *view0=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel8.ngg_bottom+8, privilView.ngg_width-24, 1)];
    view0.backgroundColor=[UIColor whiteColor];
    [privilView addSubview:view0];
    /***剩余电话次数***/
    UILabel*Alabel9=[[UILabel alloc]initWithFrame:CGRectMake(12, view0.ngg_bottom+10, privilView.ngg_width-24, 20)];
    Alabel9.textColor=[UIColor whiteColor];
    [Alabel9 setFont:[UIFont systemFontOfSize:12]];
    Alabel9.text=@"还剩7次电话特权。";
    [Alabel9 sizeToFit];
    [privilView addSubview:Alabel9];
    self.iphonelabel=Alabel9;
    /***剩余电话次数***/
    UILabel*Alabel11=[[UILabel alloc]initWithFrame:CGRectMake(12, Alabel9.ngg_bottom+10, privilView.ngg_width-24, 20)];
    Alabel11.textColor=[UIColor whiteColor];
    [Alabel11 setFont:[UIFont systemFontOfSize:12]];
    Alabel11.text=@"还剩26天会员特权。";
    [Alabel11 sizeToFit];
    [privilView addSubview:Alabel11];
    self.memberLabel=Alabel11;
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognizerclick:)];
    privilView.userInteractionEnabled=YES;
    [privilView addGestureRecognizer:tap];
    
}

-(void)tapRecognizerclick:(UITapGestureRecognizer*)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.infoview.ngg_x=SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [self.infoview removeFromSuperview];
    }];
}

#pragma mark-电话特权按钮事件
-(void)iphoneBtnClick:(NGGResetButton*)sender{
    NGGIphoneDetailViewController* iphoneDet=[[NGGIphoneDetailViewController alloc]init];
    [self.navigationController pushViewController:iphoneDet animated:YES];
}

#pragma mark-会员特权按钮事件
-(void)memberBtnClick:(NGGResetButton*)sender{
    NGGMemberViewController* iphoneDet=[[NGGMemberViewController alloc]init];
    [self.navigationController pushViewController:iphoneDet animated:YES];
}

#pragma mark-更多特权按钮事件
-(void)moreBtnClick:(NGGResetButton*)sender{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"更多特权等待开放中..." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark-刷新界面
-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
}

@end
