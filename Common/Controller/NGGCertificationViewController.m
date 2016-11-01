//
//  NGGCertificationViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/11/1.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGCertificationViewController.h"

@interface NGGCertificationViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UITextField* nametext;
@property (strong, nonatomic) UITextField* numtext;
@property (strong, nonatomic) UIButton* clickBtn1;
@property (strong, nonatomic) UIButton* clickBtn2;
@property (strong, nonatomic) NSMutableArray* array;
@end

static NSInteger tag;
@implementation NGGCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array=[[NSMutableArray alloc]init];
    self.navigationItem.title=@"实名认证";
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
  
}


#pragma mark-进行认证
-(void)certification:(UIButton*)sender{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"userid":@(USERDEFINE.currentUser.userId),
                                   @"usercertificate":@"1"
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:certificationURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        NGGLog(@"%@",str);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString* CellID=@"CellId";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        if (indexPath.row==0) {
            [self setcell1:cell];
        }else{
            [self setcell3:cell];
        }
        /***下画线***/
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-12, 0.5)];
        view.backgroundColor=NGGCutLineColor;
        [cell addSubview:view];
        
        return cell;
    }else{
        static NSString* CelliD=@"Cellid";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CelliD];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CelliD];
        }
        [self setcell2:cell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }else{
        return 380;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 40;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectio{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 180, 40)];
    label.text=@"上传证件照:";
    return label;
}

-(void)setcell1:(UITableViewCell*)cell
{
    /**真实姓名***/
    UITextField* Text=[[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, 50)];
    Text.placeholder=@"请输入你的真实姓名";
    [Text setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:Text];
    self.numtext=Text;

}
-(void)setcell3:(UITableViewCell*)cell{
    /**身份证号码***/
    UITextField* Text1=[[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, 50)];
    Text1.placeholder=@"请输入15或18位身份证号";
    [Text1 setFont:[UIFont systemFontOfSize:18]];
    [cell addSubview:Text1];
    self.numtext=Text1;
}

-(void)setcell2:(UITableViewCell*)cell
{
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(12, 10, (SCREEN_WIDTH-34)/2, 110)];
    button.backgroundColor=[UIColor lightGrayColor];
    [button setTitle:@"点击上传" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadimage:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=100;
    [cell addSubview:button];
    self.clickBtn1=button;
    /***示意图***/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(button.ngg_right+10, button.ngg_y+5, (SCREEN_WIDTH-34)/2, 112)];
    imageview.backgroundColor=NGGRandomColor;
    imageview.image=[UIImage imageNamed:@"实名认证示例1_170x113_"];
    [cell addSubview:imageview];
    /***信息***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(13, button.ngg_bottom+10, (SCREEN_WIDTH-38)/2, 20)];
    Alabel.textColor=[UIColor grayColor];
    [Alabel setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"请上传清晰正面照片";
    [cell addSubview:Alabel];
    /***信息***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(Alabel.ngg_right+20, button.ngg_bottom+10, (SCREEN_WIDTH-38)/2, 20)];
    Alabel1.textColor=[UIColor grayColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel1.textAlignment=NSTextAlignmentCenter;
    Alabel1.text=@"正面照片示意图";
    [cell addSubview:Alabel1];
    
    
    
    UIButton*button1=[[UIButton alloc]initWithFrame:CGRectMake(12, Alabel.ngg_bottom+10, (SCREEN_WIDTH-34)/2, 110)];
    button1.backgroundColor=[UIColor lightGrayColor];
    [button1 setTitle:@"点击上传" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(loadimage:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag=101;
    [cell addSubview:button1];
    self.clickBtn2=button1;
    /***示意图***/
    UIImageView*imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(button1.ngg_right+10, button1.ngg_y+5, (SCREEN_WIDTH-34)/2, 112)];
    imageview1.backgroundColor=NGGRandomColor;
    imageview1.image=[UIImage imageNamed:@"实名认证示例2_170x113_"];
    [cell addSubview:imageview1];
    /***信息***/
    UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(13, button1.ngg_bottom+10, (SCREEN_WIDTH-38)/2, 20)];
    Alabel2.textColor=[UIColor grayColor];
    [Alabel2 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel2.textAlignment=NSTextAlignmentCenter;
    Alabel2.text=@"请上传清晰反面照片";
    [cell addSubview:Alabel2];
    /***信息***/
    UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(Alabel2.ngg_right+20, button1.ngg_bottom+10, (SCREEN_WIDTH-38)/2, 20)];
    Alabel3.textColor=[UIColor grayColor];
    [Alabel3 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel3.textAlignment=NSTextAlignmentCenter;
    Alabel3.text=@"反面示意图";
    [cell addSubview:Alabel3];
    
    /***立即认证***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(15, Alabel2.ngg_bottom+15, SCREEN_WIDTH-30, 45)];
    [Btn setBackgroundColor:NGGTheMeColor];
    [Btn setTitle:@"立即认证" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    Btn.layer.cornerRadius=5;
    Btn.layer.masksToBounds=YES;
    [Btn addTarget:self action:@selector(certification:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:Btn];
}


-(void)loadimage:(UIButton*)sender{
    tag=sender.tag;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *button1=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }];
    UIAlertAction *button2=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /***创建图片选择器***/
        UIImagePickerController* picker=[[UIImagePickerController alloc]init];
        /***设置选择器选择资源的类型***/
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        picker.allowsEditing=YES;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *button3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:button1];
    [alert addAction:button2];
    [alert addAction:button3];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark-imagepicker代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image=[info objectForKey:UIImagePickerControllerEditedImage];
    if (image==nil) {
        image=[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    UIButton*btn=[self.view viewWithTag:tag];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
