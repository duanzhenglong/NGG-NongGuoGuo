//
//  NGGFeedBackViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGFeedBackViewController.h"
#import "UIView+NGGExtension.h"
@interface NGGFeedBackViewController ()<UITextViewDelegate>
@property (strong,nonatomic) UIImageView *imageView;//图片视图
@property (strong,nonatomic) UILabel *lab;//口号
@property (strong,nonatomic) UITextField *labZSQ;//输入时的默认提示
@property (strong,nonatomic) UITextView *textView;//建议输入框
@property (strong,nonatomic) UIButton *saveBtn;//保存建议
@end

@implementation NGGFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    //初始化图片视图
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 84, SCREEN_WIDTH/3, (4*SCREEN_WIDTH/3)/5)];
//    self.imageView.image = [UIImage imageNamed:@"myNes.png"];
    [self.view addSubview:self.imageView];
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.imageView.ngg_bottom+20, SCREEN_WIDTH-40, 36)];
    
    //初始化口号Lable
    self.lab.text = @"用科技，推动农业发展!";
    self.lab.textAlignment= NSTextAlignmentCenter;
    self.lab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.lab];
    
    //初始化输入框
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(12, self.lab.ngg_bottom+15, SCREEN_WIDTH-24, SCREEN_WIDTH/2)];
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.masksToBounds = YES;
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:18];
     self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.textView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.textView];
    
    //初始化输入时的默认提示
    self.labZSQ = [[UITextField alloc]initWithFrame:CGRectMake(2, 3,self.textView.ngg_width-2, 36)];
    self.labZSQ.enabled = NO;
     self.labZSQ.placeholder = @"我们的成长离不开你的建议!";
    [self.labZSQ setFont:[UIFont systemFontOfSize:18]];
    [self.textView addSubview:self.labZSQ];
    
    //保存按钮
    self.saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, SCREEN_HEIGHT-60, SCREEN_WIDTH-24, 48)];
    self.saveBtn.titleLabel.font = [UIFont systemFontOfSize:23 weight:1.2f];
    self.saveBtn.backgroundColor = NGGColorFromRGB(0x30c2bd);
    [self.saveBtn setTitle:@"提   交" forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius = 8.0f;
    self.saveBtn.layer.masksToBounds = YES;
    //点击事件
    [self.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
}


#pragma mark-保存用户建议
-(void)saveClick{
    //判断用户输入建议的字长
    if (self.textView.text.length<10||self.textView.text.length>=150) {
        //不和要求时
        UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入不少于10个字，不多于150个字的建议" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [controll addAction:action];
         [self presentViewController:controll animated:YES completion:nil];
        
    }else{
        //符合要求
        UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的宝贵建议,我们会积极听取!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self UploadTheFeedback];
            
        } ];
        [controll addAction:action];
        [self presentViewController:controll animated:YES completion:nil];
    }
    
}

#pragma mark-上反馈信息
-(void)UploadTheFeedback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                                @"content":self.textView.text,
                                @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                };
    [manager POST:AddAdviceURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self alert:@"网络请求失败"];
    }];
}

#pragma mark-提示框
-(void)alert:(NSString *)str
{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    } ];
    [controll addAction:action];
    [self presentViewController:controll animated:YES completion:nil];
}
#pragma mark-<UITextViewDelegate>代理
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length ==0) {
        self.labZSQ.hidden = NO;
    }else
    {
        self.labZSQ.hidden=YES;
    }
}

#pragma mark-关闭键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
