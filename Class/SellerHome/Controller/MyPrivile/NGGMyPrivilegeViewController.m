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

@end

@implementation NGGMyPrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [NGGPublishSupply HiddenPublishView];
    
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
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
    /*图像*/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 30, 30)];
    imageview.layer.cornerRadius=imageview.ngg_height/2;
    imageview.layer.masksToBounds=YES;
    [self.view addSubview:imageview];
    self.imageview=imageview;
    /*姓名*/
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+5, 0, 60, 20)];
    label1.ngg_centerY=imageview.ngg_centerY;
    [label1 setTextColor:[UIColor blackColor]];
    label1.text=@"姓名";
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:label1];
    self.nameLabel=label1;
    /*圈圈图像*/
    UIImageView*Circleimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    Circleimage.backgroundColor=NGGRandomColor;
    Circleimage.ngg_centerX=SCREEN_WIDTH/2;
    Circleimage.ngg_centerY=SCREEN_HEIGHT/4;
    Circleimage.layer.cornerRadius=Circleimage.ngg_height/2;
    Circleimage.layer.masksToBounds=YES;
    [self.view addSubview:Circleimage];
    /*特权值标签*/
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 20)];
    label2.ngg_centerY=Circleimage.ngg_centerY-25;
    label2.ngg_centerX=Circleimage.ngg_centerX;
    [label2 setTextColor:[UIColor orangeColor]];
    label2.text=@"特权值";
    label2.textAlignment=NSTextAlignmentCenter;
    [label2 setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:label2];
    /*特权值*/
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0,label2.ngg_bottom+5,80, 40)];
    label3.ngg_centerX=Circleimage.ngg_centerX;
    [label3 setTextColor:[UIColor whiteColor]];
    label3.text=@"668";
    label3.textAlignment=NSTextAlignmentCenter;
    [label3 setFont:[UIFont systemFontOfSize:30 ]];
    [self.view addSubview:label3];
    self.privirlege=label3;
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
    label4.text=@"可享受以下特权:";
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
