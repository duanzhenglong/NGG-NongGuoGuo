//
//  NGGMyNesTableViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyNesTableViewController.h"
#import "NGGBDPhoneViewController.h"
#import "NGGPersonalInfomation.h"
#import "NGGNickViewController.h"
#import "NGGAddressViewController.h"
#import "NGGInfoCell.h"




@interface NGGMyNesTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *array;//table数组
//    UIImageView *headerImage;//用户头像
}
@property (strong, nonatomic) UIImageView* headerimage;
@end

@implementation NGGMyNesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    array = @[@"头像",@"绑定手机号",@"昵称",@"个人信息",@"收货地址"];
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-页面加载时更新table
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = array[indexPath.section];
   
    if (indexPath.section==0) {
        self.headerimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-cell.frame.size.height-36, 0, cell.frame.size.height, cell.frame.size.height)];
        self.headerimage.image = self.img;
        self.headerimage.layer.cornerRadius = self.headerimage.frame.size.height/2;
        self.headerimage.layer.masksToBounds = YES;
       
        [cell.contentView addSubview:self.headerimage];
     
    }else if(indexPath.section==1)
    {
        cell.detailTextLabel.text = USERDEFINE.currentUser.userPhone;
        
    }else if (indexPath.section==2)
    {
        cell.detailTextLabel.text = USERDEFINE.currentUser.userNick;
        
    }else if (indexPath.section==3)
    {
        if (USERDEFINE.currentUser.userAddressId==0) {
            cell.detailTextLabel.text = @"未设置";
        }

    }
    return cell;
}



#pragma mark-上传头像
-(void)addImage{
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.allowsEditing = YES;
    pick.delegate= self;
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pick animated:YES completion:nil];
}

#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img= [info objectForKey:UIImagePickerControllerEditedImage];
    if (img == nil) {
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self uploadingImage:img];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-数据上传
-(void)uploadingImage:(UIImage *)image{
    
    NSDictionary *dic = @{
                          @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                          };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //网络请求只支持text/json，application/json，text/javascript
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    //解析json格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:UpdateHeaderimgURL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //获取图片参数,MultipartFormData:html的上传图片格式
        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        NSString* formkey=[NSString stringWithFormat:@"image"];
        //name:对应的是php中的$info["image"]的“image”
        [formData appendPartWithFileData:fileData name:formkey fileName:@"defult.png" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.headerimage.image = image;
       [self updateUser];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self alert2:@"网络出错！"];
    }];
}

#pragma mark-提示框
-(void)alert2:(NSString *)str{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [controll addAction:action2];
    
    [self presentViewController:controll animated:YES completion:nil];
    
}

#pragma mark- 更新用户信息
-(void)updateUser
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *myLogin = @{
                              @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                              };
    [manager POST:CheckPersonalInfoURL parameters:myLogin success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([str isEqualToString:@"200"]) {
            //更新用户信息
            USERDEFINE.currentUser = [NGGUser setUserInfoByDic:responseObject[@"data"]];
        }else
        {
            NGGLog(@"信息更新失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        //修改头像
        [self addImage];
        
        
    }else if(indexPath.section==1)
    {
        //绑定手机号
        NGGBDPhoneViewController *bdPhoneVC = [[NGGBDPhoneViewController alloc]init];
        [self.navigationController pushViewController:bdPhoneVC animated:YES];
       
        
    }else if(indexPath.section==2){
       //修改昵称
        NGGNickViewController *nickVC = [[NGGNickViewController alloc]init];
        [self.navigationController pushViewController:nickVC animated:YES];
    }

    else if (indexPath.section==3)
    {
        //查看信息
        NGGPersonalInfomation *personalInfoVC = [[NGGPersonalInfomation alloc]init];
        [self.navigationController pushViewController:personalInfoVC animated:YES];
    }else if (indexPath.section==4)
    {
        //查看地址
        NGGAddressViewController*addressVC = [[NGGAddressViewController alloc]init];
        addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}


@end
