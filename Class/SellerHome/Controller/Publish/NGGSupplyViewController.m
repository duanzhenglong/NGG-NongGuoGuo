//
//  NGGSupplyViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSupplyViewController.h"
#import "NGGAddressSelectView.h"
#import "HX_AddPhotoView.h"
@interface NGGSupplyViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HX_AddPhotoViewDelegate>{
    __block NSInteger addressid;
}
@property (strong, nonatomic) UITextField* textfield1;
@property (strong, nonatomic) UITextField* textfield2;
@property (strong, nonatomic) UITextField* textfield3;
@property (strong, nonatomic) UITextField* textfield4;
@property (strong, nonatomic) UITextField* textfield5;
@property (strong, nonatomic) UITextField* textfield6;
@property (strong, nonatomic) UITextView* textview;
@property (strong, nonatomic) UIButton* selectButton;
@property (strong, nonatomic) NSString* timeinterrval;
@property (strong, nonatomic) UIButton* btn;
@property (strong, nonatomic) UIView * pictureView;
 /***存放物品图片的数组***/
@property (strong, nonatomic) NSMutableArray* imageviewArray;
@end

@implementation NGGSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NGGPublishSupply HiddenPublishView];
     /***初始化数组***/
    self.imageviewArray=[NSMutableArray arrayWithCapacity:6];
    
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.tableHeaderView.backgroundColor=NGGCommonBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.navigationItem.title=@"发布供应";
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
}

#pragma mark-发布货品
-(void)ButtonClick:(UIButton*)sender{
    NGGLog(@"addressid;%ld",addressid);
    if ([self.textfield2.text isEqualToString:@""]) {
        [self NoticeInfo:@"货品名称不能为空!"];return;
    }
    if ([self.textfield4.text isEqualToString:@""]) {
        [self NoticeInfo:@"单价不能为空!"];return;
    }
    if ([self.textfield5.text isEqualToString:@""]) {
        [self NoticeInfo:@"起批量不能为空!"];return;
    }
    if ([self.btn.titleLabel.text isEqualToString:@"选择地区"]) {
        [self NoticeInfo:@"地址未选择!"];return;
    }
    if ([self.textview.text isEqualToString:@""]) {
        [self NoticeInfo:@"描述不能为空!"];return;
    }
    if (self.imageviewArray.count<2) {
        [self NoticeInfo:@"至少选择两张照片"];return;
    }
    
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
                                   @"addrid":@(addressid),
                                   @"price":self.textfield4.text,
                                   @"goodid":self.goodsid,
                                   @"timeinterval":self.timeinterrval
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:publishSupplyURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"发布成功!"]) {
            /***上传图片***/
            [self uploadingImage:responseObject[@"result"]];
        }else{
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-上传图片
-(void)uploadingImage:(NSString*)supplyid{
    NGGLog(@"%@",self.imageviewArray);
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
    [self.tableView.tableHeaderView addSubview:view2];
    
    UILabel*Label2=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label2.ngg_centerY=view2.ngg_height/2;
    Label2.text=@"货品名称:";
    [Label2 setTextColor:NGGTheMeColor];
    [Label2 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view2 addSubview:Label2];
    
    self.textfield2=[[UITextField alloc]initWithFrame:CGRectMake(Label2.ngg_right, 0, SCREEN_WIDTH-Label2.ngg_width-10, 30)];
    self.textfield2.borderStyle=UITextBorderStyleNone;
    self.textfield2.ngg_centerY=view2.ngg_height/2;
    [view2 addSubview:self.textfield2];

    /*添加4视图*/
    UIView*view4=[[UIView alloc]initWithFrame:CGRectMake(0, view2.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:view4];
    UILabel*Label4=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label4.ngg_centerY=view4.ngg_height/2;
    Label4.text=@"单价:";
    [Label4 setTextColor:NGGTheMeColor];
    [Label4 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view4 addSubview:Label4];
    
    self.textfield4=[[UITextField alloc]initWithFrame:CGRectMake(Label4.ngg_right, 0, SCREEN_WIDTH-Label4.ngg_width-10, 30)];
    self.textfield4.borderStyle=UITextBorderStyleNone;
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
    
    self.textfield5=[[UITextField alloc]initWithFrame:CGRectMake(Label5.ngg_right, 0, SCREEN_WIDTH-Label5.ngg_width-10, 30)];
    self.textfield5.borderStyle=UITextBorderStyleNone;
    self.textfield5.ngg_centerY=view5.ngg_height/2;
    [view5 addSubview:self.textfield5];
    
    /*添加6视图*/
    UIView*view6=[[UIView alloc]initWithFrame:CGRectMake(0, view5.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view6.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:view6];
    UILabel*Label6=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label6.ngg_centerY=view5.ngg_height/2;
    Label6.text=@"发货地:";
    [Label6 setTextColor:NGGTheMeColor];
    [Label6 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view6 addSubview:Label6];
    
    /***所在地***/
    UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 10, SCREEN_WIDTH -SCREEN_WIDTH / 3-10, 20)];
    [Btn setTitle:@"选择地区" forState:UIControlStateNormal];
    Btn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    Btn.layer.cornerRadius=5;
    Btn.layer.masksToBounds=YES;
    [Btn addTarget:self action:@selector(AddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [view6 addSubview:Btn];
    self.btn=Btn;
    
    
    /*添加9视图*/
    UIView*view9=[[UIView alloc]initWithFrame:CGRectMake(0, view6.ngg_bottom+5, SCREEN_WIDTH, 40)];
    view9.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view9];
    UILabel*Label9=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, 80, 25)];
    Label9.ngg_centerY=view5.ngg_height/2;
    Label9.text=@"供应时长:";
    [Label9 setTextColor:NGGTheMeColor];
    [Label9 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [view9 addSubview:Label9];
    for (int i=0; i<3; i++) {
        /***采购时长 ***/
        UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3+i*SCREEN_WIDTH / 5, 10, 20, 20)];
        [Btn setBackgroundColor:NGGTheMeColor];
        [Btn setImage:[UIImage imageNamed:@"Oils_normal"] forState:UIControlStateSelected];    ///后期更改图片
        Btn.layer.cornerRadius=10;
        Btn.layer.masksToBounds=YES;
        Btn.tag=i*4+3+100;
        [Btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view9 addSubview:Btn];
    }
    /***3天时长***/
    for (int i=0; i<3; i++) {
        UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3+20+i*SCREEN_WIDTH / 5, 10, SCREEN_WIDTH / 5, 20)];
        Alabel.textColor=[UIColor grayColor];
        [Alabel setFont:[UIFont systemFontOfSize:14]];
        Alabel.textAlignment=NSTextAlignmentLeft;
        if (i==0) {
            Alabel.text=@"  3天";
        }else if (i==1){
            Alabel.text=@"  7天";
        }else{
            Alabel.text=@"  11天";
        }
        [view9 addSubview:Alabel];
    }
    
    UIButton *firstButton=view9.subviews[1];
    firstButton.selected=YES;
    self.selectButton=firstButton;
    
    /*添加第7个label*/
    UILabel*Label7=[[UILabel alloc]initWithFrame:CGRectMake(16, view9.ngg_bottom+5, 80, 25)];
    Label7.text=@"货品描述:";
    [Label7 setTextColor:NGGTheMeColor];
    [Label7 setFont:[UIFont systemFontOfSize:17 weight:2]];
    [self.tableView.tableHeaderView addSubview:Label7];
    
    /*添加7视图*/
    UIView*view7=[[UIView alloc]initWithFrame:CGRectMake(0, Label7.ngg_bottom+5, SCREEN_WIDTH, 80)];
    view7.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:view7];
    
    self.textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.textview.text=@"如货品特色、种植情况、供应量或包装要求....";
    self.textview.textColor=[UIColor lightGrayColor];
    [self.textview setFont:[UIFont systemFontOfSize:14 weight:1]];
    self.textview.textAlignment=NSTextAlignmentCenter;
    [view7 addSubview:self.textview];
    self.textview.delegate=self;
    
    /*添加8视图*/
    UIView*view8=[[UIView alloc]initWithFrame:CGRectMake(0, view7.ngg_bottom+5, SCREEN_WIDTH, 160)];
    view8.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:view8];
    self.pictureView=view8;
    
    HX_AddPhotoView *addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:8 WithSelectType:SelectPhoto];
    addPhotoView.delegate = self;
    addPhotoView.backgroundColor = [UIColor whiteColor];
    addPhotoView.frame = CGRectMake(0, 45, SCREEN_WIDTH, 0);
    [addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {
        for (int i=0; i<photos.count; i++) {
            UIImageView *imageView=(UIImageView*)photos[i];
            [self.imageviewArray addObject:imageView.image];
        }
    }];
    [view8 addSubview:addPhotoView];
    
    /*创建发布button*/
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 40)];
    button.ngg_bottom=self.tableView.tableHeaderView.ngg_bottom-8;
    [button setBackgroundColor:NGGTheMeColor];
    [button setTitle:@"发 布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:2]];
    [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [self.tableView.tableHeaderView addSubview:button];
}

#pragma mark-采购时长的按钮点击事件
-(void)Click:(UIButton*)sender{
    self.selectButton.selected=NO;
    sender.selected=YES;
    self.selectButton=sender;
    self.timeinterrval=[NSString stringWithFormat:@"%ld",sender.tag-100];
    NGGLog(@"self.timeinterrval%@",self.timeinterrval);
}


#pragma mark-所在地按钮点击事件
-(void)AddressClick:(UIButton*)sender{
    NGGAddressSelectView *address=[[NGGAddressSelectView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [UIView animateWithDuration:0.5 animations:^{
        address.ngg_y=address.ngg_height;
    }];
    [self.tableView addSubview:address];
    address.addressBlock=^(NSInteger tag,NSString *title){
        [sender setTitle:title forState:UIControlStateNormal];
        addressid=tag;
    };
}


#pragma mark-获取提示信息
-(void)NoticeInfo:(NSString *)message{
    
    UILabel *NoticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    NoticeLabel.center=CGPointMake(self.view.ngg_width/2, self.view.ngg_height-150);
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


#pragma mark-键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
