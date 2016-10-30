//
//  NGGNewPhoneViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGNewPhoneViewController.h"
#import "UIView+NGGExtension.h"
#import <SMS_SDK/SMSSDK.h>
@interface NGGNewPhoneViewController ()<UITextFieldDelegate>
{
    int TotalTime; //验证总时长
}
@property (strong,nonatomic)UITextField *newsPhone;//新手机号
@property (strong,nonatomic)UITextField *securityCode;//验证码
@property (strong,nonatomic)UIButton *gainBtn;//获取验证码
@property (strong,nonatomic)UIButton *completeBtn;//下一步
@property (strong, nonatomic) NSTimer* Timer;//创建计时器
@end

@implementation NGGNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    //线条1
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 3)];
    view1.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view1];
    //手机号
    self.newsPhone  = [[UITextField alloc]initWithFrame:CGRectMake(20, view1.ngg_bottom+10, SCREEN_WIDTH-40, 36)];
    self.newsPhone.placeholder =@"请输入新手机号";
    [self.view addSubview:self.newsPhone];
    self.newsPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newsPhone.delegate = self;
    
    self.newsPhone.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, self.newsPhone.ngg_size.height)];
    self.newsPhone.leftViewMode = UITextFieldViewModeAlways;
    UILabel *oldPhoneLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.newsPhone.leftView.ngg_width, self.newsPhone.ngg_size.height)];
    oldPhoneLab.textAlignment=NSTextAlignmentCenter;
    oldPhoneLab.text = @"+86";
    [self.newsPhone.leftView addSubview:oldPhoneLab];
    //线条2
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(40, self.newsPhone.ngg_bottom+10, SCREEN_WIDTH-40, 3)];
    view2.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view2];
    
    //接受验证码
    self.securityCode = [[UITextField alloc]initWithFrame:CGRectMake(20, view2.ngg_bottom+10, SCREEN_WIDTH/2-20, 36)];
    
    self.securityCode.placeholder = @"请输入收到的验证码";
    self.securityCode.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview: self.securityCode];

    //点击发送验证码
    self.gainBtn = [[UIButton alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3-20, view2.ngg_bottom+10, SCREEN_WIDTH/3, 36)];
    self.gainBtn.backgroundColor = NGGTheMeColor;
    self.gainBtn.layer.cornerRadius=7.0f;
    [self.gainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:self.gainBtn];
    [self.gainBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];

    //线条3
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.gainBtn.ngg_bottom+10, SCREEN_WIDTH, 3)];
    view3.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view3];
    //线条4
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake((self.securityCode.frame.origin.x+self.securityCode.ngg_width+self.gainBtn.frame.origin.x)/2, view2.ngg_bottom+10, 2, 36)];
    view4.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view4];
    
    //完成Button
    self.completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, view3.ngg_bottom+20, SCREEN_WIDTH-60, 44)];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.completeBtn.layer.cornerRadius=5.0f;
    self.completeBtn.layer.masksToBounds = YES;

    [self.completeBtn setBackgroundColor:NGGTheMeColor];
    [self.completeBtn addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.completeBtn];
}

//完成事件
-(void)completeClick
{//    //判断手机号码是否一致
    
        //进行文本框内容判断
        if ([self textIsNUll]==NO) return;
    
        //验证验证码是否正确
        [SMSSDK commitVerificationCode:self.securityCode.text phoneNumber:self.newsPhone.text zone:@"86" result:^(NSError *error) {
            if (!error) {
                NGGLog(@"验证成功");
                //上传手机号
                [self updatePhoneClick];
            
            }else
            {
                [self alert:@"验证失败"];
                NGGLog(@"错误信息:%@",error);
            }
        }];
    
}
#pragma mark-修改手机号
-(void)updatePhoneClick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                                @"userphone":self.newsPhone.text,
                                @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                };
    [manager POST:UpdatePhoneURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
       
        if ([code isEqualToString:@"200"]) {
            
           USERDEFINE.currentUser.userPhone=self.newsPhone.text;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [self alert:@"密码修改失败"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self alert:@"网络请求失败"];
    }];
}
#pragma mark- UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.newsPhone) {
        if (string.length == 0) return YES;
        if (textField.text.length - range.length + string.length > 11) {
            [self alert:@"手机号不能超过11位!"];
            return NO;
        }
    }
    return YES;
}

#pragma mark-提示框
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
}



#pragma mark-获取验证码
-(void)getCode:(UIButton*)btn
{
    //进行文本框内容判断
    if ([self textIsNUll]==NO) return;
    /*进行倒计时*/
    TotalTime=59;
    [btn setTitle:@"60s" forState:UIControlStateNormal];
    btn.enabled=NO;
    [self AddTimer];
    /*获取验证码*/
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.newsPhone.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            
            NGGLog(@"获取验证码成功");
        } else {
            
            [self alert:@"手机号码格式错误"];
            NGGLog(@"错误信息：%@",error);
        };
    }];
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
        [self.gainBtn setTitle:str forState:UIControlStateNormal];
    }else{
        self.gainBtn.enabled=YES;
        [self.gainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self RemoveTimer];
    }
}
-(BOOL)textIsNUll{
    
    /*进行文本框内容判断*/
    if ([self.newsPhone.text isEqualToString:@""]) {
        [self alert:@"用户名不能为空!"];
        return NO;
    }
    if (self.newsPhone.text.length<11) {
        [self alert:@"手机号应为11位!"];
        return NO;
    }
    
    return YES;
}
@end
