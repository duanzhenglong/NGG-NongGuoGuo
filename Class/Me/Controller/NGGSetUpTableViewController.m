//
//  NGGSetUpTableViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSetUpTableViewController.h"
#import "UIView+NGGExtension.h"
#import "NGGUpdatePwdViewController.h"
#import "NGGAgreemenTableViewController.h"
#import "NGGFeedBackViewController.h"

@interface NGGSetUpTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSArray *arrayCellTitle;//cell标题
@property (strong,nonatomic) UISwitch *switchBtn;//开关
@property (strong,nonatomic)UIButton *backOutBtn;//退出
@end

@implementation NGGSetUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.arrayCellTitle = @[@"接受消息通知",@"修改密码",@"服务条款与协议",@"关于我们"];
    //底部退出
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    //bottomView.backgroundColor = [UIColor blackColor];
    self.tableView.tableFooterView = bottomView;
    //退出
    
    self.backOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(12,bottomView.frame.size.height/2-24 , SCREEN_WIDTH-24, 40)];
    self.backOutBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:1.5];
    self.backOutBtn.layer.cornerRadius= 5.0f;
    self.backOutBtn.layer.masksToBounds=YES;
    [self.backOutBtn setTitle:@"退出当前登录" forState:UIControlStateNormal];
    self.backOutBtn.backgroundColor = NGGTheMeColor;
    [self.backOutBtn addTarget:self action:@selector(backOutClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.backOutBtn];
   
    
}

#pragma mark-退出
-(void)backOutClick{
    
    NGGLog(@"退出登录");
    USERDEFINE.currentUser = nil;
    APPDELEGATE.userPersonalModel = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arrayCellTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    if (indexPath.section==0) {
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.arrayCellTitle[indexPath.section];
        self.switchBtn = [[UISwitch alloc] initWithFrame:CGRectZero];
        //快关按钮
        [self.switchBtn addTarget:self action:@selector(switchBtnOnAndOff) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = self.switchBtn;
        
    }

    else{
         cell.textLabel.text = self.arrayCellTitle[indexPath.section];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //修改密码
    if (indexPath.section==1) {
        NGGUpdatePwdViewController *updatePwd = [[NGGUpdatePwdViewController alloc]init];
        //setUpVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:updatePwd animated:YES];
        
    }
    else if (indexPath.section==2){
        //服务条款与协议
        NGGAgreemenTableViewController *agreementVC = [[NGGAgreemenTableViewController alloc]init];
        [self.navigationController pushViewController:agreementVC animated:YES];
    
    }else if (indexPath.section==3){
        //关于我们
        NGGFeedBackViewController *feedBackVC = [[NGGFeedBackViewController alloc]init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==self.arrayCellTitle.count) {
        return 100.0f;
    }else{
        return 20.0f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

#pragma mark-开关事件
-(void)switchBtnOnAndOff{
    if ([self.switchBtn isOn]) {
        NGGLog(@"isOn");
        [self.switchBtn setOn:YES animated:YES];
        
    }else{
        NGGLog(@"isOff");
        [self.switchBtn setOn:NO animated:YES];
    }
    
}
@end
