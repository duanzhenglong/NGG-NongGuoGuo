//
//  NGGForgetPwdViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGForgetPwdViewController.h"
#import "NGGEditTextField.h"
#import <SMS_SDK/SMSSDK.h>
@interface NGGForgetPwdViewController ()<UITextFieldDelegate>{
    NGGEditTextField* iphoneText;
    NGGEditTextField* passwordText;
    NGGEditTextField* RepasswordText;
    NGGEditTextField* VerificationText;
    int TotalTime; //总时长
}
 /*创建计时器*/
@property (strong, nonatomic) NSTimer* Timer;
 /*获得验证码的按钮*/
@property (strong, nonatomic) UIButton* Verifibtn;
@end

@implementation NGGForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*初始化*/
    [self layoutLoginView];
    //设置所有代理
    [self deletesInSelf];
    
}

#pragma mark-所有代理
-(void)deletesInSelf{
    passwordText.delegate=self;
    iphoneText.delegate=self;
}

#pragma mark-布局
-(void)layoutLoginView{
    /*背景颜色*/
    self.view.backgroundColor=[UIColor whiteColor];
    
    /*创建手机号label*/
    UILabel*userLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 106, 80, 25)];
    userLabel.textColor=NGGColorFromRGB(0x333333);
    [userLabel setFont:[UIFont systemFontOfSize:20]];
    userLabel.text=@"手机号";
    [self.view addSubview:userLabel];
    
    /*创建新密码label*/
    UILabel*passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, userLabel.ngg_bottom+40, 80, 25)];
    passwordLabel.textColor=NGGColorFromRGB(0x333333);
    [passwordLabel setFont:[UIFont systemFontOfSize:20]];
    passwordLabel.text=@"新密码";
    [self.view addSubview:passwordLabel];
    
    /*创建再次新密码label*/
    UILabel*RepasswordLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, passwordLabel.ngg_bottom+40, 100, 25)];
    RepasswordLabel.textColor=NGGColorFromRGB(0x333333);
    [RepasswordLabel setFont:[UIFont systemFontOfSize:20]];
    RepasswordLabel.text=@"确认密码";
    [self.view addSubview:RepasswordLabel];
    
    /*创建验证码label*/
    UILabel*VerifiLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, RepasswordLabel.ngg_bottom+40, 80, 25)];
    VerifiLabel.textColor=NGGColorFromRGB(0x333333);
    [VerifiLabel setFont:[UIFont systemFontOfSize:20]];
    VerifiLabel.text=@"验证码";
    [self.view addSubview:VerifiLabel];
    
    /*创建账号Text*/
    iphoneText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(userLabel.ngg_right+10, userLabel.ngg_y, SCREEN_WIDTH-userLabel.ngg_width*2, userLabel.ngg_height)];
    iphoneText.placeholder=@"手机号";
    [iphoneText setFont:[UIFont systemFontOfSize:18]];
    iphoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:iphoneText];
    
    /*创建密码Text*/
    passwordText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(passwordLabel.ngg_right+10, passwordLabel.ngg_y, SCREEN_WIDTH-passwordLabel.ngg_width*2, passwordLabel.ngg_height)];
    passwordText.placeholder=@"6-16位数字字母";
    [passwordText setFont:[UIFont systemFontOfSize:18]];
    passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordText.secureTextEntry=YES;
    [self.view addSubview:passwordText];
    
    /*创建再次输入密码Text*/
    RepasswordText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(RepasswordLabel.ngg_right+5, RepasswordLabel.ngg_y, SCREEN_WIDTH-passwordLabel.ngg_width*2, passwordLabel.ngg_height)];
    RepasswordText.placeholder=@"6-16位数字字母";
    [RepasswordText setFont:[UIFont systemFontOfSize:18]];
    RepasswordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    RepasswordText.secureTextEntry=YES;
    [self.view addSubview:RepasswordText];
    
    /*创建验证码Text*/
    VerificationText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(VerifiLabel.ngg_right, VerifiLabel.ngg_y, SCREEN_WIDTH-VerifiLabel.ngg_width*2, VerifiLabel.ngg_height)];
    VerificationText.placeholder=@"请输入验证码";
    [VerificationText setFont:[UIFont systemFontOfSize:18]];
    VerificationText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:VerificationText];
    
    /*创建下画线1*/
    UIView *View1=[[UIView alloc]initWithFrame:CGRectMake(15, userLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View1.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View1];
    
    /*创建下画线2*/
    UIView *View2=[[UIView alloc]initWithFrame:CGRectMake(15, passwordLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View2.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View2];
    
    /*创建下画线3*/
    UIView *View3=[[UIView alloc]initWithFrame:CGRectMake(15, VerifiLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View3.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View3];
    
    /*创建下画线4*/
    UIView *View4=[[UIView alloc]initWithFrame:CGRectMake(15, RepasswordLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View4.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View4];
    
    /*创建完成Button*/
    UIButton *FinishBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, View3.ngg_bottom+40, SCREEN_WIDTH-30, 40)];
    [FinishBtn setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
    [FinishBtn setTitle:@"完  成" forState:UIControlStateNormal];
    [FinishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FinishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [FinishBtn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    FinishBtn.layer.cornerRadius=8;
    FinishBtn.layer.masksToBounds=YES;
    [FinishBtn addTarget:self action:@selector(FinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FinishBtn];
    
    /*创建验证Button*/
    UIButton *VerifiBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-95,VerificationText.ngg_y, 80, 25)];
    [VerifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [VerifiBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    [VerifiBtn setBackgroundColor:NGGTheMeColor];
    VerifiBtn.layer.cornerRadius=5;
    VerifiBtn.layer.masksToBounds=YES;
    [VerifiBtn addTarget:self action:@selector(VerifiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VerifiBtn];
    self.Verifibtn=VerifiBtn;
    
}

#pragma mark-textFideld代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //限制字数
    if (textField == iphoneText) {
        if (string.length == 0) return YES;
        if (textField.text.length - range.length + string.length > 11) {
            [self NoticeInfo:@"手机号不能超过11位！"];
            return NO;
        }
    }
    if (textField == passwordText) {
        if (string.length == 0) return YES;
        if (textField.text.length - range.length + string.length > 16) {
            [self NoticeInfo:@"密码不能超过16位！"];
            return NO;
        }
    }
    return YES;
}

#pragma mark-获取提示信息
-(void)NoticeInfo:(NSString *)message{
    
    UILabel *NoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NoticeLabel.center=CGPointMake(self.view.ngg_width/2, self.view.ngg_height-100);
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

#pragma mark-注册的具体操作
-(void)RegisterUser{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"tel":iphoneText.text,
                                   @"password":passwordText.text
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:ForgetPwdURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"修改成功"]) {
            NSDictionary*dic=responseObject[@"data"];
             /*立即登陆当前用户*/
            USERDEFINE.currentUser=[NGGUser setUserInfoByDic:dic];
             /*再将当前用户信息储存到沙盒中*/
            NSString *path=[NSString stringWithFormat:@"%@/Documents/user.plist",NSHomeDirectory()];
            [dic writeToFile:path atomically:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@"%@",str);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-完成按钮触发事件
-(void)FinishBtn:(UIButton*)sender{
    /*进行文本框内容判断*/
    if ([self textIsNUll]==NO) return;
    /*验证验证码是否正确*/
    [SMSSDK commitVerificationCode:VerificationText.text phoneNumber:iphoneText.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
            /*验证码验证成功进行注册*/
           [self RegisterUser];
        }else
        {
            NSLog(@"错误信息:%@",error);
        }
    }];
}

#pragma mark-验证按钮触发事件
-(void)VerifiBtn:(UIButton*)sender{
//    /*进行文本框内容判断*/
    if ([self textIsNUll]==NO) return;
    
     /*进行倒计时*/
    TotalTime=59;
    [sender setTitle:@"60s" forState:UIControlStateNormal];
    sender.enabled=NO;
    [self AddTimer];
    
    /*获取验证码*/
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:iphoneText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        };
    }];
}

#pragma mark-文本框内容判断
-(BOOL)textIsNUll{
    /*进行文本框内容判断*/
    if ([passwordText.text isEqualToString:@""]||[iphoneText.text isEqualToString:@""]) {
        if ([iphoneText.text isEqualToString:@""]||[RepasswordText.text isEqualToString:@""]) {
            [self NoticeInfo:@"用户名不能为空!"];
            return NO;
        }else{
            [self NoticeInfo:@"密码不能为空!"];
            return NO;
        }
    }
    if (iphoneText.text.length<11) {
        [self NoticeInfo:@"手机号应为11位!"];
        return NO;
    }
    if (passwordText.text.length<6) {
        [self NoticeInfo:@"密码长度在6~16位!"];
        return NO;
    }
    if (![passwordText.text isEqualToString:RepasswordText.text]) {
        [self NoticeInfo:@"再次输入的密码不一致！"];
        return NO;
    }
    return YES;
}

#pragma mark-添加计时器
-(void)AddTimer{
    self.Timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ChangeTime) userInfo:nil repeats:YES];
}

#pragma mark-移除计时器
-(void)RemoveTimer{
    [self.Timer invalidate];
    self.Timer=nil;
}

#pragma mark-计时开始
-(void)ChangeTime{
    if (TotalTime>0) {
        NSString *str=[NSString stringWithFormat:@"%ds",TotalTime--];
        [self.Verifibtn setTitle:str forState:UIControlStateNormal];
    }else{
        self.Verifibtn.enabled=YES;
        [self.Verifibtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self RemoveTimer];
    }
}

#pragma mark-键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
