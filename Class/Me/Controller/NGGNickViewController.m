//
//  NGGNickViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGNickViewController.h"
#import "UIView+NGGExtension.h"
@interface NGGNickViewController ()<UITextFieldDelegate>
{
    UITextField *nickTextField;//昵称
    UIButton *referBtn;//提交Button
    
}
@end

@implementation NGGNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=NGGCommonBgColor;
    //线条1(间隔线)
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 95, SCREEN_WIDTH, 1)];
    view1.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view1];
    //昵称
    nickTextField  = [[UITextField alloc]initWithFrame:CGRectMake(20, view1.ngg_bottom+5, SCREEN_WIDTH-40, 36)];
    nickTextField.placeholder =@"请输入新昵称";
    [self.view addSubview:nickTextField];
    nickTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nickTextField.delegate = self;

    nickTextField.leftView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, nickTextField.ngg_size.height)];
    nickTextField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *nickLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, nickTextField.leftView.ngg_width, nickTextField.ngg_size.height)];
    nickLab.textAlignment=NSTextAlignmentCenter;
    nickLab.text = @"新昵称";
    [nickTextField.leftView addSubview:nickLab];
    
    //线条2(间隔线)
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, nickTextField.ngg_bottom+5, SCREEN_WIDTH, 1)];
    view2.backgroundColor = NGGColorA(220, 220, 220, 255);
    [self.view addSubview:view2];
    //提交按钮
    referBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, view2.ngg_bottom+40, self.view.ngg_width-40, 40)];
    [referBtn setTitle:@"提交" forState:UIControlStateNormal];
    [referBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [referBtn setBackgroundColor:NGGTheMeColor];
    referBtn.layer.cornerRadius = 5.0f;
    referBtn.layer.masksToBounds = YES;
    [referBtn addTarget:self action:@selector(referClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:referBtn];
}


#pragma mark-提交按钮
-(void)referClick{
    if (nickTextField.text.length>=2) {
         [self updateNick];
    }
    else{
        
        [self alert:@"请输入不少于两位数的昵称!"];
    }
   
    
}


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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark-修改用户昵称
-(void)updateNick
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updateNick = @{
                                @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],
                                @"usernick":nickTextField.text
                                };
    [manager POST:UpdateNickURL parameters:updateNick success:^(NSURLSessionDataTask *task, id responseObject) {
        //更新用户信息
       USERDEFINE.currentUser.userNick = nickTextField.text;
        [self alert2:@"昵称修改成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       NGGLog(@"失败");
    }];
}

@end
