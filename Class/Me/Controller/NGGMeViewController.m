//
//  NGGMeViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMeViewController.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "UIView+NGGExtension.h"
#import "NGGSetUpTableViewController.h"
#import "NGGFeedBackViewController.h"
#import "NGGMyNesTableViewController.h"
#import "NGGDetailedInfo.h"
#import "NGGAddressViewController.h"
#import "NGGInfoViewController.h"
#import "NGGLoginViewController.h"
@interface NGGMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIImageView *headerImageView;//头像
@property (strong,nonatomic) UIImageView *infoImageView;//通知图标
@property (strong,nonatomic) UILabel *nickOrPhoneLable;//用户昵称或号码
@property (strong,nonatomic) UILabel *infoLable;//通知

@property (strong,nonatomic) NSArray *arrayCellTitle;//每个cell的标题
@property (strong,nonatomic) UIBarButtonItem *rightBtn;//导航栏右侧button

@end
#define Size1 self.tableView.tableHeaderView.frame.size//视图容器
#define Size self.view.frame.size
static int flg;
@implementation NGGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"个人中心";
    self.tableView.backgroundColor=NGGCommonBgColor;
    flg=USERDEFINE.currentUser.Usermark;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //添加tableView滑动图片
    self.tableView.yz_headerScaleImage = [UIImage imageNamed:@"yi.png"];
    
    self.tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Size.width, 150)];
//     /***设置CellTitle***/
//    [self setCellTitle];
//    
    //加载控件
    [self loadingControls];

    //右侧设置按钮
    self.rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setUpRightBtn)];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    
    //登录
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

#pragma mark-设置arrayCellTitle
-(void)setCellTitle{
    if (USERDEFINE.currentUser.Usermark==0) {
        self.arrayCellTitle = @[@"我是买家",@"实名认证",@"收货地址管理",@"意见反馈",@"联系客服"];
    }else{
        self.arrayCellTitle = @[@"我是卖家",@"实名认证",@"收货地址管理",@"意见反馈",@"联系客服"];
    }
}

#pragma mark-viewWillAppear
-(void )viewWillAppear:(BOOL)animated
{    
    [self updataImg];
    [self setCellTitle];
}

#pragma mark-登录
-(void)login{
    
   [self presentViewController:LoginView animated:YES completion:nil];
}
#pragma mark-设置按钮
-(void)setUpRightBtn{
    if (USERDEFINE.currentUser==nil) {
        [self login];
    }else{
        //跳转到设置界面
        NGGSetUpTableViewController *setUpVC = [[NGGSetUpTableViewController alloc]init];
        setUpVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:setUpVC animated:YES];
    }
}

#pragma mark-加载控件
-(void)loadingControls{
    //初始化头像
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Size1.width/8, Size1.height/4, Size1.height/2, Size1.height/2)];
    
    self.headerImageView.layer.cornerRadius= self.headerImageView.frame.size.height/2;
    self.headerImageView.layer.masksToBounds=YES;
    [self.tableView.tableHeaderView addSubview:self.headerImageView];
    //昵称
    self.nickOrPhoneLable = [[UILabel alloc]initWithFrame:CGRectMake(self.headerImageView.ngg_right+20, Size1.height/2-14, Size1.width/3, 28)];
    
    //self.nickOrPhoneLable.textAlignment =NSTextAlignmentCenter;
    
    //添加点击
    self.headerImageView.userInteractionEnabled=YES;
    self.nickOrPhoneLable.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.headerImageView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.nickOrPhoneLable addGestureRecognizer:tap2];
    [self.tableView.tableHeaderView addSubview:self.nickOrPhoneLable];
    
    
 //通知
    self.infoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Size1.width-(self.headerImageView.frame.origin.x+Size1.height/2.5), self.headerImageView.frame.origin.y, Size1.height/2.5, Size1.height/2.5)];
    self.infoImageView.image = [UIImage imageNamed:@"info.png"];
    [self.tableView.tableHeaderView addSubview:self.infoImageView];
    self.infoLable = [[UILabel alloc]initWithFrame:CGRectMake(self.infoImageView.ngg_x-15, self.infoImageView.ngg_bottom+3, self.infoImageView.ngg_width+30, 28)];
    [self.infoLable setText:@"通知"];
    [self.infoLable setTextColor:[UIColor whiteColor]];
    self.infoLable.textAlignment= NSTextAlignmentCenter;
    [self.tableView.tableHeaderView addSubview:self.infoLable];
    self.infoImageView.userInteractionEnabled = YES;
    self.infoLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapInfo1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfoClick:)];
    UITapGestureRecognizer *tapInfo2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfoClick:)];
    [self.infoLable addGestureRecognizer:tapInfo1];
    [self.infoImageView addGestureRecognizer:tapInfo2];
    
}
#pragma mark-通知点击事件
-(void)tapInfoClick:(UITapGestureRecognizer *)recognizer{
    
    if (USERDEFINE.currentUser==nil) {
        [self login];
    }else{
        //跳转到设置界面
        NGGInfoViewController *infoVC = [[NGGInfoViewController alloc]init];
        infoVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
   
}

#pragma mark-头像点击事件
-(void)tapClick:(UITapGestureRecognizer *)recognizer
{
    if (USERDEFINE.currentUser==nil) {
        [self login];
    }else{
        NGGMyNesTableViewController *myNes = [[NGGMyNesTableViewController alloc]init];
        myNes.img = self.headerImageView.image;
        myNes.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myNes animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayCellTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID=@"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section==0) {
        cell.textLabel.text = self.arrayCellTitle[indexPath.section];
        //切换图标
        UIImageView *changeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Change"]];
        changeImageView.frame = CGRectMake(3, 3, cell.ngg_height-12, cell.ngg_height-12);
        cell.accessoryView = changeImageView;
    }
    else{
        cell.textLabel.text = self.arrayCellTitle[indexPath.section];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.0f;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (USERDEFINE.currentUser.Usermark==1) {
            UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否切换到买家" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*Ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.arrayCellTitle = @[@"我是买家",@"实名认证",@"收货地址管理",@"意见反馈",@"联系客服"];
                /***用户切换状态***/
                USERDEFINE.currentUser.Usermark=0;
//                flg=0;
                [self.tableView reloadData];
            }];
            UIAlertAction*Cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:Ok];
            [alert addAction:Cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否切换到卖家" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*Ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.arrayCellTitle = @[@"我是卖家",@"实名认证",@"收货地址管理",@"意见反馈",@"联系客服"];
                /***用户切换状态***/
                USERDEFINE.currentUser.Usermark=1;
//                flg=1;
                [self.tableView reloadData];
            }];
            UIAlertAction*Cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:Ok];
            [alert addAction:Cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else if (indexPath.section==1){
        if (USERDEFINE.currentUser==nil) {
            [self login];
        }else{
            //实名认证
        }
    }
    else if (indexPath.section ==2){
        if (USERDEFINE.currentUser==nil) {
            [self login];
        }else{
            //地址管理
            NGGAddressViewController*addressVC = [[NGGAddressViewController alloc]init];
            addressVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }
    else if (indexPath.section ==3){
        if (USERDEFINE.currentUser==nil) {
            [self login];
        }else{
            //关于我们
            NGGFeedBackViewController *feedBackVC = [[NGGFeedBackViewController alloc]init];
            //关闭底部导航
            feedBackVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }
       
    }else if (indexPath.section==4){
        if (USERDEFINE.currentUser==nil) {
            [self login];
        }else{
            //个人信息详情
            NGGDetailedInfo *detailedInfoVC = [[NGGDetailedInfo alloc]init];
            [self.navigationController pushViewController:detailedInfoVC animated:YES];
        }
        
    }
}
#pragma mark-用户头像
-(void)updataImg{
    if (USERDEFINE.currentUser==nil) {
        self.headerImageView.image = [UIImage imageNamed:@"tuxiang"];
         self.nickOrPhoneLable.text = @"未登录";
    }else{
        NSString *path = [NSString stringWithFormat:@"%@%@",DownLoadHeaderImgURL,USERDEFINE.currentUser.userHeadimage];
        NSURL *url = [NSURL URLWithString:path];
        kDISPATCH_MAIN_THREAD([self.headerImageView sd_setImageWithURL:url];);
        if (USERDEFINE.currentUser.userNick.length!=0) {
            self.nickOrPhoneLable.text = USERDEFINE.currentUser.userNick;
        }else{
            self.nickOrPhoneLable.text = USERDEFINE.currentUser.userPhone;
        }
    }
}
//
//#pragma mark-从数据库下载头像
//-(UIImage *)downLoadHeaderImg{
//    NSString *path = [NSString stringWithFormat:@"%@%@",DownLoadHeaderImgURL,USERDEFINE.currentUser.userHeadimage];
//    NSURL *url = [NSURL URLWithString:path];
//    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
//    UIImage *image = [[UIImage alloc]initWithData:data];
//    return image;
//}


@end
