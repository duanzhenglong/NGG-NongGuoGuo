//
//  NGGSupplyViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSupplyViewController.h"
@interface NGGSupplyViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UITextField* textfield1;
@property (strong, nonatomic) UITextField* textfield2;
@property (strong, nonatomic) UITextField* textfield3;
@property (strong, nonatomic) UITextField* textfield4;
@property (strong, nonatomic) UITextField* textfield5;
@property (strong, nonatomic) UITextField* textfield6;
@property (strong, nonatomic) UITextView* textview;
 /***存放物品图片的数组***/
@property (strong, nonatomic) NSMutableArray* imageviewArray;
@end

@implementation NGGSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NGGPublishSupply HiddenPublishView];
     /***初始化数组***/
    self.imageviewArray=[[NSMutableArray alloc]init];
    
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
}

#pragma mark-发布货品
-(void)ButtonClick:(UIButton*)sender{
    // 手机当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter*ftm=[[NSDateFormatter alloc]init];
    [ftm setDateFormat:@"YYY-MM-dd hh:mm:ss"];//这句不能少，一定要给格式
    NSString*stringNowtime=[ftm stringFromDate:nowDate];
     /***进行发布***/
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"time":stringNowtime,
                                   @"goodname":self.textfield2.text,
                                   @"minnum":self.textfield5.text,
                                   @"desc":self.textview.text,
                                   @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId],//卖家id
                                   @"goodsclassifyid":self.goodsclassifyid,
                                   @"addrid":@"1",
                                   @"price":self.textfield4.text,
                                   @"goodid":self.goodsid,
                                   @"timeinterval":@"3"
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:publishSupplyURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"发布成功!"]) {
            /***上传图片***/
            NGGLogFunc
            [self uploadingImage:responseObject[@"result"]];
        }else{
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void)Button1:(UIButton*)sender{
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
    [self.imageviewArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-上传图片
-(void)uploadingImage:(NSString*)supplyid{
    NSDictionary *dic = @{
                          @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId] ,//卖家id
                          @"supplyid":supplyid,
                          };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //网络请求只支持text/json，application/json，text/javascript
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //解析json格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:uploadimageURL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //获取图片参数,MultipartFormData:html的上传图片格式
        for (int i=0; i<self.imageviewArray.count; i++) {
          NSData *fileData = UIImageJPEGRepresentation(self.imageviewArray[i], 1.0);
          NSString* formkey=[NSString stringWithFormat:@"image%d.png",i+1];
          //name:对应的是php中的$info["image"]的“image”
          [formData appendPartWithFileData:fileData name:@"image[]" fileName:formkey mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark-textview代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.textview.text=@"";
    self.textview.textAlignment=NSTextAlignmentLeft;
    [self.textview setFont:[UIFont systemFontOfSize:13 weight:1]];
    self.textview.textColor=[UIColor blackColor];
}

#pragma mark-自定义控件
-(void)CreatCustomizeControls{
    /*添加2视图*/
    UIView*view2=[[UIView alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel*Label2=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label2.ngg_centerY=view2.ngg_height/2;
    Label2.text=@"货品名称:";
    [Label2 setTextColor:NGGTheMeColor];
    [Label2 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view2 addSubview:Label2];
    
    self.textfield2=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-5, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield2.borderStyle=UITextBorderStyleLine;
    self.textfield2.layer.borderWidth=1;
    self.textfield2.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield2.ngg_centerY=view2.ngg_height/2;
    [view2 addSubview:self.textfield2];

    /*添加4视图*/
    UIView*view4=[[UIView alloc]initWithFrame:CGRectMake(0, view2.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    UILabel*Label4=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label4.ngg_centerY=view4.ngg_height/2;
    Label4.text=@"单价:";
    [Label4 setTextColor:NGGTheMeColor];
    [Label4 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view4 addSubview:Label4];
    
    self.textfield4=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-5, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield4.borderStyle=UITextBorderStyleLine;
    self.textfield4.layer.borderWidth=1;
    self.textfield4.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield4.ngg_centerY=view4.ngg_height/2;
    [view4 addSubview:self.textfield4];
    
    /*添加5视图*/
    UIView*view5=[[UIView alloc]initWithFrame:CGRectMake(0, view4.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view5.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view5];
    UILabel*Label5=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label5.ngg_centerY=view5.ngg_height/2;
    Label5.text=@"起批量:";
    [Label5 setTextColor:NGGTheMeColor];
    [Label5 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view5 addSubview:Label5];
    
    self.textfield5=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-5, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield5.borderStyle=UITextBorderStyleLine;
    self.textfield5.layer.borderWidth=1;
    self.textfield5.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield5.ngg_centerY=view5.ngg_height/2;
    [view5 addSubview:self.textfield5];
    
    /*添加6视图*/
    UIView*view6=[[UIView alloc]initWithFrame:CGRectMake(0, view5.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view6.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view6];
    UILabel*Label6=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label6.ngg_centerY=view5.ngg_height/2;
    Label6.text=@"发货地:";
    [Label6 setTextColor:NGGTheMeColor];
    [Label6 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view6 addSubview:Label6];
    
    self.textfield6=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH*3/4-5, 0, SCREEN_WIDTH*3/4, 30)];
    self.textfield6.borderStyle=UITextBorderStyleLine;
    self.textfield6.layer.borderWidth=1;
    self.textfield6.layer.borderColor=NGGCommonBgColor.CGColor;
    self.textfield6.ngg_centerY=view5.ngg_height/2;
    [view6 addSubview:self.textfield6];
    
    /*添加第7个label*/
    UILabel*Label7=[[UILabel alloc]initWithFrame:CGRectMake(16, view6.ngg_bottom+5, 80, 25)];
    Label7.text=@"货品描述:";
    [Label7 setTextColor:NGGTheMeColor];
    [Label7 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [self.view addSubview:Label7];
    
    /*添加7视图*/
    UIView*view7=[[UIView alloc]initWithFrame:CGRectMake(0, Label7.ngg_bottom+5, SCREEN_WIDTH, 100)];
    view7.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view7];
    
    self.textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.textview.text=@"如货品特色、种植情况、供应量或包装要求....";
    self.textview.textColor=[UIColor lightGrayColor];
    [self.textview setFont:[UIFont systemFontOfSize:17 weight:2]];
    self.textview.textAlignment=NSTextAlignmentCenter;
    [view7 addSubview:self.textview];
    self.textview.delegate=self;
    
    /*添加8视图*/
    UIView*view8=[[UIView alloc]initWithFrame:CGRectMake(0, view7.ngg_bottom+5, SCREEN_WIDTH, 100)];
    view8.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view8];
    
    UIButton*button1=[[UIButton alloc]initWithFrame:CGRectMake(16, 0, 40, 35)];
    button1.ngg_centerY=view8.ngg_height/2;
    [button1 setImage:[UIImage imageNamed:@"xiangji"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(Button1:) forControlEvents:UIControlEventTouchUpInside];
    [view8 addSubview:button1];
    
    /*创建发布button*/
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(20, view8.ngg_bottom+30, SCREEN_WIDTH-40, 35)];
    [button setBackgroundColor:NGGTheMeColor];
    [button setTitle:@"发 布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:2]];
    [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [self.view addSubview:button];
}

#pragma mark-键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
