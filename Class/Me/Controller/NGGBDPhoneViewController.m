//
//  NGGBDPhoneViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGBDPhoneViewController.h"
#import "UIView+NGGExtension.h"
#import "NGGNewPhoneViewController.h"
#import "UIView+NGGExtension.h"
#import <SMS_SDK/SMSSDK.h>
@interface NGGBDPhoneViewController ()<UITextFieldDelegate>
{
    int TotalTime; //验证总时长
}
@property (strong,nonatomic)UITextField *oldPhone;//原始手机号
@property (strong,nonatomic)UITextField *securityCode;//验证码
@property (strong,nonatomic)UIButton *gainBtn;//获取验证码
@property (strong,nonatomic)UIButton *nextBtn;//下一步
@property (strong, nonatomic) NSTimer* Timer;//创建计时器


@end

@implementation NGGBDPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    self.view.backgroundColor=NGGCommonBgColor;
    
    //线条1
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 1)];
    view1.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:view1];
    //手机号
    self.oldPhone  = [[UITextField alloc]initWithFrame:CGRectMake(20, view1.ngg_bottom+10, SCREEN_WIDTH-40, 36)];
    self.oldPhone.placeholder =@"请输入原始手机号";
    [self.view addSubview:self.oldPhone];
    self.oldPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPhone.delegate = self;
    self.oldPhone.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, self.oldPhone.ngg_size.height)];
    self.oldPhone.leftViewMode = UITextFieldViewModeAlways;
    UILabel *oldPhoneLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.oldPhone.leftView.ngg_width, self.oldPhone.ngg_size.height)];
    oldPhoneLab.textAlignment=NSTextAlignmentCenter;
    oldPhoneLab.text = @"+86";
    [self.oldPhone.leftView addSubview:oldPhoneLab];
    //线条2
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(40, self.oldPhone.ngg_bottom+10, SCREEN_WIDTH-40, 1)];
    view2.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:view2];
    
    //接受验证码
    self.securityCode = [[UITextField alloc]initWithFrame:CGRectMake(20, view2.ngg_bottom+10, SCREEN_WIDTH/2-20, 36)];
    
     self.securityCode.placeholder = @"请输入收到的验证码";
    self.securityCode.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview: self.securityCode];
    
    
    //点击发送验证码
    self.gainBtn = [[UIButton alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH/3-20, view2.ngg_bottom+10, SCREEN_WIDTH/3, 36)];
    [self.gainBtn setBackgroundColor:NGGTheMeColor];
    self.gainBtn.layer.cornerRadius = 7.0f;
    self.gainBtn.layer.masksToBounds = YES;
    [self.gainBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.gainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:self.gainBtn];
    
    //线条3
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.gainBtn.ngg_bottom+10, SCREEN_WIDTH, 1)];
    view3.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [self.view addSubview:view3];
    //线条4
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake((self.securityCode.frame.origin.x+self.securityCode.ngg_width+self.gainBtn.frame.origin.x)/2, view2.ngg_bottom+10, 2, 36)];
    view4.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view4];
    
    //下一步Button
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, view3.ngg_bottom+20, SCREEN_WIDTH-60, 44)];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius=5.0f;
    [self.nextBtn setBackgroundColor:NGGTheMeColor];
    [self.nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
   
}


//下一步事件
-(void)nextClick:(UIButton *)btn
{
    [self nextInterface];
    //判断手机号码是否一致
    if (![self.oldPhone.text isEqualToString:USERDEFINE.currentUser.userPhone]) {
        [self alert:@"手机号与原始号码不一致"];
    }
    else{
    //进行文本框内容判断
    if ([self textIsNUll]==NO) return;
    //验证验证码是否正确
    [SMSSDK commitVerificationCode:self.securityCode.text phoneNumber:self.oldPhone.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NGGLog(@"验证成功");
            //验证码验证成功是否跳到下一页面
        [self nextInterface];
        }else
        {
            [self alert:@"验证失败"];
            NGGLog(@"错误信息:%@",error);
        }
    }];
    
    }
}
#pragma mark-跳到下一页面
-(void)nextInterface
{
    NGGNewPhoneViewController *newphoneVC = [[NGGNewPhoneViewController alloc]init];
    //定义下一页面的返回按钮
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] init];
    returnItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnItem;
    
    [self.navigationController pushViewController:newphoneVC animated:YES];
}

#pragma mark- UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.oldPhone) {
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
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.oldPhone.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
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
    if ([self.oldPhone.text isEqualToString:@""]) {
        [self alert:@"原始手机号不能为空!"];
        return NO;
    }
    if (self.oldPhone.text.length<11) {
        [self alert:@"手机号应为11位!"];
        return NO;
    }
    return YES;
}




















@end
