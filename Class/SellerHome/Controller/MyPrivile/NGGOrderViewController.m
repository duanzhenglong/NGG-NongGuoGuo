//
//  NGGOrderViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOrderViewController.h"

@interface NGGOrderViewController ()

@end

@implementation NGGOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.sectionFooterHeight=30;
    self.tableView.sectionHeaderHeight=30;
    
     /*创建支付按钮*/
    [self creatPayBtn];
}

#pragma mark-创建支付按钮
-(void)creatPayBtn{
    UIButton*Button=[[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-120, SCREEN_WIDTH-40, 45)];
    [Button setBackgroundColor:NGGTheMeColor];
    Button.layer.cornerRadius=5;
    Button.layer.masksToBounds=YES;
    [Button setTitle:@"确认支付" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1]];
    [Button addTarget:self action:@selector(PayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:Button];
}

#pragma mark-支付按钮事件
-(void)PayBtnClick:(UIButton*)sender{
    /***获取特权信息***/
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                   ,@"privilegeid":[NSString stringWithFormat:@"%d",self.flg]
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:addPrivilegeURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"购买成功!"]) {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OK=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:OK];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellID=@"CellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    if (indexPath.section==0) {
        [self CreatCustomizeControlFrist:cell];
    }else{
        if (indexPath.row==0) {
            [self CreatCustomizeControlSce:cell];
        }else{
            [self CreatCustomizeControlTre:cell];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }
    return 80;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor=NGGCommonBgColor;
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 24)];
    view1.backgroundColor=[UIColor whiteColor];
    [view addSubview:view1];
    if (section==0) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 60, 24)];
        label.text=@"订单详情";
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor blackColor]];
        [view1 addSubview:label];
    }else{
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 60, 24)];
        label.text=@"支付方式";
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor blackColor]];
        [view1 addSubview:label];
    }
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor=NGGCommonBgColor;
    if (section==0) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 24)];
        view1.backgroundColor=[UIColor whiteColor];
        [view addSubview:view1];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130, 0, 120, 24)];
        if (self.flg==1) {
            label.text=@"订单总价:  20元";
        }else{
            label.text=@"订单总价:  100元";
        }
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor blackColor]];
        [view1 addSubview:label];
        return view;
    }
    return view;
}

#pragma mark-第一个cell中的控件
-(void)CreatCustomizeControlFrist:(UITableViewCell*)cell{
    UIImageView* imageview=[[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 70, 70)];
    imageview.backgroundColor=NGGRandomColor;
    [cell addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+40, imageview.ngg_y, 80, 25)];
    label.backgroundColor=NGGRandomColor;
    if (self.flg==1) {
      label.text=@"电话特权:";
    }else{
      label.text=@"会员特权:";
    }
    [label setFont:[UIFont systemFontOfSize:14 weight:1]];
    [label setTextColor:[UIColor blackColor]];
    [cell addSubview:label];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+40, label.ngg_bottom+15, 80, 25)];
    label1.backgroundColor=NGGRandomColor;
    if (self.flg==1) {
        label1.text=@"20元 5次";
    }else{
        label1.text=@"100元 /月";
    }
    [label1 setFont:[UIFont systemFontOfSize:14]];
    [label1 setTextColor:[UIColor blackColor]];
    [cell addSubview:label1];
}

#pragma mark-第2个cell中的控件
-(void)CreatCustomizeControlSce:(UITableViewCell*)cell{
    UIImageView* imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
    imageview.backgroundColor=NGGRandomColor;
    [cell addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+30,0, 80, 25)];
    label.ngg_centerY=40;
    label.backgroundColor=NGGRandomColor;
    label.text=@"支付宝";
    [label setFont:[UIFont systemFontOfSize:14 weight:1]];
    [label setTextColor:[UIColor blackColor]];
    [cell addSubview:label];
    
    UIButton*Button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 0, 20, 20)];
    Button.backgroundColor=NGGRandomColor;
    Button.ngg_centerY=40;
    [cell addSubview:Button];
}

#pragma mark-第3个cell中的控件
-(void)CreatCustomizeControlTre:(UITableViewCell*)cell{
    UIImageView* imageview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
    imageview.backgroundColor=NGGRandomColor;
    [cell addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+30,0, 80, 25)];
    label.ngg_centerY=40;
    label.backgroundColor=NGGRandomColor;
    label.text=@"微信";
    [label setFont:[UIFont systemFontOfSize:14 weight:1]];
    [label setTextColor:[UIColor blackColor]];
    [cell addSubview:label];
    
    UIButton*Button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 0, 20, 20)];
    Button.backgroundColor=NGGRandomColor;
    Button.ngg_centerY=40;
    [cell addSubview:Button];
}


@end
