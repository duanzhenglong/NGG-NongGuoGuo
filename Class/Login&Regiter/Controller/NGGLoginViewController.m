//
//  NGGLoginViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGLoginViewController.h"
#import "NGGEditTextField.h"
#import "NGGResetButton.h"
#import "NGGRegisterViewController.h"
#import "NGGForgetPwdViewController.h"
@interface NGGLoginViewController ()<UITextFieldDelegate,UINavigationControllerDelegate>{
    NGGEditTextField* iphoneText;
    NGGEditTextField* passwordText;
}
@property (strong, nonatomic) UIButton* loginBtn;
@property (strong, nonatomic) UIButton* RegisterBtn;
@property (strong, nonatomic) UIButton* forgetPwdBtn;
@end

@implementation NGGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*初始化*/
    [self layoutLoginView];
    //设置所有代理
    [self deletesInSelf];
    
}

#pragma mark-所有代理
-(void)deletesInSelf{
    self.navigationController.delegate=self;//代理隐藏导航栏
    passwordText.delegate=self;
    iphoneText.delegate=self;
}

#pragma mark-判断要显示的控制器是否是自己，如果是自己则将自己的导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

#pragma mark-布局
-(void)layoutLoginView{
    /*背景颜色*/
    self.view.backgroundColor=[UIColor whiteColor];
    
    /*创建账号label*/
    UILabel*userLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 106, 50, 25)];
    userLabel.textColor=NGGColorFromRGB(0x333333);
    [userLabel setFont:[UIFont systemFontOfSize:20]];
    userLabel.text=@"帐号";
    [self.view addSubview:userLabel];
    
    /*创建密码label*/
    UILabel*passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, userLabel.ngg_bottom+40, 50, 25)];
    passwordLabel.textColor=NGGColorFromRGB(0x333333);
    [passwordLabel setFont:[UIFont systemFontOfSize:20]];
    passwordLabel.text=@"密码";
    [self.view addSubview:passwordLabel];
    
    /*创建账号Text*/
    iphoneText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(userLabel.ngg_right+20, userLabel.ngg_y, SCREEN_WIDTH-userLabel.ngg_width*2, userLabel.ngg_height)];
    iphoneText.placeholder=@"手机号/用户名";
    [iphoneText setFont:[UIFont systemFontOfSize:18]];
    iphoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
    iphoneText.clearsOnBeginEditing=YES;
    [self.view addSubview:iphoneText];
    
    /*创建密码Text*/
    passwordText=[[NGGEditTextField alloc]initWithFrame:CGRectMake(passwordLabel.ngg_right+20, passwordLabel.ngg_y, SCREEN_WIDTH-passwordLabel.ngg_width*2, passwordLabel.ngg_height)];
    passwordText.placeholder=@"6-16位数字字母";
    [passwordText setFont:[UIFont systemFontOfSize:18]];
    passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordText.clearsOnBeginEditing=YES;
    passwordText.secureTextEntry=YES;
    [self.view addSubview:passwordText];
    
    /*创建下画线1*/
    UIView *View1=[[UIView alloc]initWithFrame:CGRectMake(15, userLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View1.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View1];
    
    /*创建下画线2*/
    UIView *View2=[[UIView alloc]initWithFrame:CGRectMake(15, passwordLabel.ngg_bottom+12, SCREEN_WIDTH-30, 1)];
    View2.backgroundColor=NGGColorA(220, 220, 220, 255);
    [self.view addSubview:View2];
    
    /*创建登陆Button*/
    self.loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, View2.ngg_bottom+46, SCREEN_WIDTH-30, 40)];
    [self.loginBtn setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
    [self.loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    self.loginBtn.layer.cornerRadius=8;
    self.loginBtn.layer.masksToBounds=YES;
    [self.loginBtn addTarget:self action:@selector(ClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    /*创建注册Button*/
    self.RegisterBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, self.loginBtn.ngg_bottom+26, 80, 20)];
    [self.RegisterBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [self.RegisterBtn setTitleColor:NGGColor(63, 167, 247) forState:UIControlStateNormal];
    [self.RegisterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.RegisterBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.RegisterBtn addTarget:self action:@selector(ClickRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.RegisterBtn];
    
    /*创建忘记密码Button*/
    self.forgetPwdBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.ngg_right-106, self.RegisterBtn.ngg_y-10, 100, 40)];
    [self.forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitleColor:NGGColor(63, 167, 247) forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.forgetPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.forgetPwdBtn addTarget:self action:@selector(ClickForgerPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPwdBtn];
    
    /*关闭按钮*/
    UIButton*CloseBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 35, 35)];
    [CloseBtn setImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    [CloseBtn addTarget:self action:@selector(CloseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CloseBtn];
    /***图标***/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-85, 60, 60)];
    imageview.ngg_centerX=SCREEN_WIDTH/2;
    imageview.backgroundColor=NGGRandomColor;
    imageview.image=[UIImage imageNamed:@"nongguoguo"];
    [self.view addSubview:imageview];
    /***提示信息***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imageview.ngg_bottom+5, SCREEN_WIDTH/2, 10)];
    Alabel.ngg_centerX=SCREEN_WIDTH/2;
    Alabel.textColor=[UIColor blackColor];
    [Alabel setFont:[UIFont systemFontOfSize:10 weight:1]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"农果果Nuoguoguo";
    [self.view addSubview:Alabel];
    
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

#pragma mark-登陆按钮触发的事件
-(void)ClickLogin:(UIButton*)sender{
    if ([passwordText.text isEqualToString:@""]||[iphoneText.text isEqualToString:@""]) {
        if ([iphoneText.text isEqualToString:@""]) {
            [self NoticeInfo:@"用户名不能为空!"];
            return;
        }else{
            [self NoticeInfo:@"密码不能为空!"];
            return;
        }
    }
    if (iphoneText.text.length<11) {
        [self NoticeInfo:@"手机号应为11位!"];
        return;
    }
    if (passwordText.text.length<6) {
        [self NoticeInfo:@"密码长度在6~16位!"];
        return;
    }
    
    //获取网络数据库中用户信息
    [self RequireUserInfo];
}

#pragma mark-获取提示信息
-(void)NoticeInfo:(NSString *)message{
    
    UILabel *NoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NoticeLabel.center=CGPointMake(self.view.ngg_width/2, self.view.ngg_height-120);
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

#pragma mark-获取用户信息
-(void)RequireUserInfo{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSDictionary *myParameters = @{
                                   @"telephone":iphoneText.text,
                                   @"password":passwordText.text,
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:LoginURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"登陆成功"]) {
            NSDictionary*dic=responseObject[@"result"];
             /*当前用户所有信息*/
            USERDEFINE.currentUser=[NGGUser setUserInfoByDic:dic];
             /***暂时默认买家：：后期更改***/
            USERDEFINE.currentUser.Usermark=0;
            /*再将当前用户信息储存到沙盒中*/
            NSString *path=[NSString stringWithFormat:@"%@/Documents/user.plist",NSHomeDirectory()];
            [dic writeToFile:path atomically:YES];
             /*环信服务器登陆*/
//            [self LoginHyphenate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self NoticeInfo:str];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self NoticeInfo:@"网络错误！请检查网络设置"];
    }];
}

#pragma mark-环信服务器登陆
-(void)LoginHyphenate{
    /*判断是否设置了自动登录*/
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:iphoneText.text password:passwordText.text];
        if (!error) {
            NSLog(@"环信服务器登陆登录成功");
            [[EMClient sharedClient].options setIsAutoLogin:YES]; //自动登录
        }
    }
}

#pragma mark-注册按钮触发事件
-(void)ClickRegister:(UIButton*)sender{
    NGGRegisterViewController*Register1=[[NGGRegisterViewController alloc]init];
    [self.navigationController pushViewController:Register1 animated:YES];
}

#pragma mark-忘记密码按钮触发事件
-(void)ClickForgerPwd:(UIButton*)sender{
    NGGForgetPwdViewController*ForgetPwd1=[[NGGForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:ForgetPwd1 animated:YES];
}

#pragma mark-关闭按钮
-(void)CloseClick:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
