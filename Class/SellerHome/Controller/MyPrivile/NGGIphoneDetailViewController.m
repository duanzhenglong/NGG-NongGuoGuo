//
//  NGGIphoneDetailViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGIphoneDetailViewController.h"
#import "NGGResetButton.h"
#import "NGGOrderViewController.h"
@interface NGGIphoneDetailViewController ()
@property (strong, nonatomic) UIView* view3;
@end

@implementation NGGIphoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.sectionHeaderHeight=50;
    self.tableView.sectionFooterHeight=50;
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3-30)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
    /*特权按钮*/
    NGGResetButton *PrivilegeBtn = [NGGResetButton buttonWithType:UIButtonTypeCustom];
    PrivilegeBtn.frame=CGRectMake(0,0, SCREEN_WIDTH/3,SCREEN_WIDTH/3 );
    PrivilegeBtn.ngg_centerX=SCREEN_WIDTH/2;
    PrivilegeBtn.ngg_centerY=self.tableView.tableHeaderView.ngg_height/2;
    [PrivilegeBtn setImage:[UIImage imageNamed:@"MyGoods_normal"] forState:UIControlStateNormal];
    [PrivilegeBtn setTitle:@"电话特权" forState:UIControlStateNormal];
    [PrivilegeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [PrivilegeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tableView.tableHeaderView addSubview:PrivilegeBtn];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellID=@"CellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
     /*在cell上添加控件*/
    [self CreatCustomizeControl:cell];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel*Label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 50)];
    Label.text=@"特权说明";
    [Label setTextColor:[UIColor blackColor]];
    [Label setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:Label];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor=NGGTheMeColor;
    UIButton*Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [Btn setTitle:@"立即购买" forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT*2/3-50;
}

#pragma mark-自定义控件
-(void)CreatCustomizeControl:(UITableViewCell*)cell{
     /*分割线*/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    view.backgroundColor=NGGCommonBgColor;
    [cell addSubview:view];
     /*有效时间*/
    UILabel*Label1=[[UILabel alloc]initWithFrame:CGRectMake(12, view.ngg_bottom+10, 100, 20)];
    Label1.text=@"| 有效时间";
    [Label1 setTextColor:[UIColor orangeColor]];
    [Label1 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label1];
    /*有效时间内容*/
    UILabel*Label2=[[UILabel alloc]initWithFrame:CGRectMake(12, Label1.ngg_bottom+5, SCREEN_WIDTH-24,0)];
    Label2.text=@"自购买起至特权次数结束";
    [Label2 setTextColor:[UIColor blackColor]];
    Label2.numberOfLines=0;
    [Label2 sizeToFit];
    [Label2 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label2];
    /*特权内容标签*/
    UILabel*Label3=[[UILabel alloc]initWithFrame:CGRectMake(12, Label2.ngg_bottom+5, 100, 20)];
    Label3.text=@"| 特权内容";
    [Label3 setTextColor:[UIColor orangeColor]];
    [Label3 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label3];
    /*特权内容*/
    UILabel*Label4=[[UILabel alloc]initWithFrame:CGRectMake(12, Label3.ngg_bottom+5, SCREEN_WIDTH-24, 50)];
    Label4.text=@"1.主动联系采购商\n2.用户的出电话后且通话时长大于10秒后，计入一次电话消耗\n3.相互为好友的用户，拨打电话，不计入电话消耗次数\n4.最近（2天）联系人回拔，不计入电话消耗次数";
    [Label4 setTextColor:[UIColor blackColor]];
    Label4.numberOfLines=0;
    [Label4 sizeToFit];
    [Label4 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label4];
    /*特权对象标签*/
    UILabel*Label5=[[UILabel alloc]initWithFrame:CGRectMake(12, Label4.ngg_bottom+5, 100, 20)];
    Label5.text=@"| 特权对象";
    [Label5 setTextColor:[UIColor orangeColor]];
    [Label5 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label5];
    /*特权对象内容*/
    UILabel*Label6=[[UILabel alloc]initWithFrame:CGRectMake(12, Label5.ngg_bottom+5, SCREEN_WIDTH-24, 50)];
    Label6.text=@"凡购买此特权用户；";
    [Label6 setTextColor:[UIColor blackColor]];
    Label6.numberOfLines=0;
    [Label6 sizeToFit];
    [Label6 setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:Label6];
}

#pragma mark-立即购买事件
-(void)BtnClick:(UIButton*)sender{
    NGGOrderViewController* Order=[[NGGOrderViewController alloc]init];
    Order.flg=1;
    [self.navigationController pushViewController:Order animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.view3 removeFromSuperview];
}
@end
