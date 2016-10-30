//
//  NGGUpdatePwdViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGUpdatePwdViewController.h"
#import "UIView+NGGExtension.h"
#import "AFNetworking.h"

@interface NGGUpdatePwdViewController ()<UITextFieldDelegate>

@property (strong,nonatomic)UITextField *oldPwd;//原始密码
@property (strong,nonatomic)UITextField *newpwd;//新密码
@property (strong,nonatomic)UITextField *againNewPwd;//重新输入新密码
@property (strong,nonatomic)UIView *pwdView;//密码view容器
@property (strong,nonatomic)UIButton *determineBtn;//确定按钮
@end

@implementation NGGUpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300)];
    [self.view addSubview:self.pwdView];
    self.view.backgroundColor=NGGCommonBgColor;
    [self addControls];
    
}
#pragma mark-加载控件
-(void)addControls{
    //线条1(间隔线)
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 2)];
    view1.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.pwdView addSubview:view1];
    //原始密码
    self.oldPwd = [[UITextField alloc]initWithFrame:CGRectMake(20, view1.ngg_bottom+5, SCREEN_WIDTH-40, 36)];
    self.oldPwd.placeholder =@"请输入原始密码";
    //隐藏密码
    self.oldPwd.secureTextEntry = YES;
    //清除
    self.oldPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPwd.delegate = self;
//    self.oldPwd.layer.cornerRadius=5.0f;
//    self.oldPwd.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.oldPwd.layer.borderWidth = 0.5;
    self.oldPwd.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.oldPwd.ngg_size.height)];
    self.oldPwd.leftViewMode = UITextFieldViewModeAlways;
    UILabel *oldPwdLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.oldPwd.leftView.ngg_width, self.oldPwd.ngg_size.height)];
    oldPwdLab.textAlignment=NSTextAlignmentRight;
    oldPwdLab.text = @"原始密码:";
    
   // self.oldPwd.font = [UIFont systemFontOfSize:20];
    oldPwdLab.font = [UIFont systemFontOfSize:20];
    
    [self.oldPwd.leftView addSubview:oldPwdLab];
    [self.pwdView addSubview:self.oldPwd];
    
    //线条2(间隔线)
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(self.oldPwd.ngg_x, self.oldPwd.ngg_bottom+5, SCREEN_WIDTH-self.oldPwd.ngg_x, view1.ngg_height)];
    view2.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.pwdView addSubview:view2];
    //新密码
    self.newpwd = [[UITextField alloc]initWithFrame:CGRectMake(self.oldPwd.ngg_x, view2.ngg_bottom+5, self.oldPwd.ngg_width, self.oldPwd.ngg_height)];
    self.newpwd.placeholder = @"请输入新密码";
     self.newpwd.secureTextEntry = YES;
    self.newpwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newpwd.delegate = self;
//    self.newpwd.layer.cornerRadius=5.0f;
//    self.newpwd.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.newpwd.layer.borderWidth = 0.5;
    self.newpwd.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.oldPwd.ngg_size.height)];
    self.newpwd.leftViewMode = UITextFieldViewModeAlways;
    UILabel *newPwdLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.oldPwd.leftView.ngg_width, self.oldPwd.ngg_size.height)];
    newPwdLab.textAlignment=NSTextAlignmentRight;
    newPwdLab.text = @"新  密  码:";
    
    //self.newpwd.font = [UIFont systemFontOfSize:20];
    newPwdLab.font = [UIFont systemFontOfSize:20];
    
    [self.newpwd.leftView addSubview:newPwdLab];
    [self.pwdView addSubview:self.newpwd];
    //线条3(间隔线)
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(self.oldPwd.ngg_x, self.newpwd.ngg_bottom+5, SCREEN_WIDTH-self.oldPwd.ngg_x, view1.ngg_height)];
    view3.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.pwdView addSubview:view3];
    //重新输入密码
    self.againNewPwd = [[UITextField alloc]initWithFrame:CGRectMake(self.oldPwd.ngg_x, view3.ngg_bottom+5, self.oldPwd.ngg_width, self.oldPwd.ngg_height)];
    self.againNewPwd.placeholder = @"再次输入新密码";
    
    
    self.againNewPwd.secureTextEntry = YES;
    self.againNewPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.againNewPwd.delegate = self;
    self.againNewPwd.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.oldPwd.ngg_size.height)];
    self.againNewPwd.leftViewMode = UITextFieldViewModeAlways;
    UILabel *againNewPwdLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.oldPwd.leftView.ngg_width, self.oldPwd.ngg_size.height)];
    againNewPwdLab.textAlignment=NSTextAlignmentRight;
    againNewPwdLab.text = @"确认密码:";
    
    //self.againNewPwd.font = [UIFont systemFontOfSize:20];
    againNewPwdLab.font = [UIFont systemFontOfSize:20];
    
    [self.againNewPwd.leftView addSubview:againNewPwdLab];
    [self.pwdView addSubview:self.againNewPwd];
    //线条3(间隔线)
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.againNewPwd.ngg_bottom+5, SCREEN_WIDTH, view1.ngg_height)];
    view4.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.pwdView addSubview:view4];
    
    //确定按钮
    self.determineBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.againNewPwd.ngg_x+7, self.againNewPwd.ngg_bottom+40, SCREEN_WIDTH-2*(self.againNewPwd.ngg_x+7), 48)];
    self.determineBtn.layer.cornerRadius=10.0f;
    self.determineBtn.backgroundColor = NGGTheMeColor;
    
    [self.determineBtn setTitle:@"确  定" forState:UIControlStateNormal];
    self.determineBtn.titleLabel.font = [UIFont systemFontOfSize:22 weight:1.5];
    [self.determineBtn addTarget:self action:@selector(clickOnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.pwdView addSubview:self.determineBtn];
    
}

#pragma mark-点击确定事件
-(void)clickOnEvent
{
    //判断输入老密码，是否与数据库数据一致
    if ([USERDEFINE.currentUser.userPassword isEqualToString:self.oldPwd.text]) {
        //一致时
        
        //判断新密码长度
        if (self.newpwd.text.length>=6) {
            
            //两次输入的新密码一致时
            if ([self.newpwd.text isEqualToString:self.againNewPwd.text]) {
                //新密码与原始密码相同时
                if ([USERDEFINE.currentUser.userPassword isEqualToString:self.newpwd.text]) {
                    [self alert:@"新密码与原始密码不可相同"];
                }else{
                    
                    [self updatePwdClick];
                }
            }
             //两次输入的新密码一致时
            else{
                [self alert:@"两次输入的密码不同"];
            }
        }else{
            [self alert:@"密码不得少于6位数"];
        }
    }
    else{
        //不一致时
         [self alert:@"原始密码错误"];
    }
}

//提示框
#pragma mark-修改未成功时
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}

#pragma mark-修改成功时
-(void)alert2:(NSString *)str{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}

#pragma mark-修改密码接口
-(void)updatePwdClick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                              @"oldpwd":self.oldPwd.text,
                              @"newpwd":self.newpwd.text,
                              @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                              };
    [manager POST:UpdatePwdURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
    
       if ([code isEqualToString:@"200"]) {
            
            //更新数据用户数据
           USERDEFINE.currentUser.userPassword=self.newpwd.text;
            [self alert2:@"密码修改成功"];
        }
        else{
            [self alert:@"密码修改失败"];
       }
     
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self alert:@"网络请求失败"];
    }];
}

@end
