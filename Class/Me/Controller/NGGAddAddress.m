//
//  NGGAddAddress.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddAddress.h"
#import "UIView+NGGExtension.h"
#import "Address.h"
#import "NGGAddAddressCell.h"
@interface NGGAddAddress ()<AddressDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSString *_userName;//用户名
    NSString *_userPhong;//用户手机号
    NSString *_areaAddress;//区域地址
    NSString *_detailedAddress;//详细地址
}
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) UIBarButtonItem *rightBtn;//右侧保存按钮
@property (strong,nonatomic) NSArray *array;
@property (strong,nonatomic) UITextView*detaAddress;//详细地址
@property (strong,nonatomic) UITextField*tiShi;//输入详细地址提示
@property (strong,nonatomic) NSString *str;//连接选择地区字符串
@end

@implementation NGGAddAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加新地址";
self.rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveRightBtn)];
self.navigationItem.rightBarButtonItem = self.rightBtn;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    _array = @[@"收货人姓名",@"联系方式",@"所在地区"];
    
    [self initializeTextView];

}
#pragma mark-初始化详细地址
-(void)initializeTextView
{
    self.detaAddress = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 64)];
    self.detaAddress.font = [UIFont systemFontOfSize:18];
    self.detaAddress.delegate = self;
    self.tiShi = [[UITextField alloc]initWithFrame:CGRectMake(0, self.detaAddress.ngg_y, self.detaAddress.ngg_width, self.detaAddress.ngg_height/2)];
    self.tiShi.enabled = NO;
    self.tiShi.placeholder = @"请填写详细地址，不少于6个字!";
    [self.tiShi setFont:[UIFont systemFontOfSize:18]];
    [self.detaAddress addSubview:self.tiShi];
    
}
#pragma mark-<UITextViewDelegate>代理
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.detaAddress.text.length ==0) {
        self.tiShi.hidden = NO;
    }else
    {
        self.tiShi.hidden=YES;
    }
}

#pragma mark-保存
-(void)saveRightBtn{
    
    [self editingTextFieldPassTag];
    if (_userName.length<=2||_userName.length>=20) {
        
        [self alert:@"请输入大于2个字小于20字的名字"];
    }else{
        if (_userPhong.length==11) {
            
            
            if (_areaAddress.length==0) {
                [self alert:@"请选择所在区域"];
            }else{
                if (_detaAddress.text.length>=4||_detaAddress.text.length<=99) {
                    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否添加该地址？" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self AddAddress];
                        
                    }];
                    [controll addAction:action1];
                    [controll addAction:action2];
                    [self presentViewController:controll animated:YES completion:nil];
                    
                }else{
                    [self alert:@"请输入大于3小于100字的详细地址"];
                }
            }
            
            
        }else{
            [self alert:@"11位合法手机号"];
        }
    }
}

#pragma mark-提示框
-(void)alert:(NSString *)str
{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [controll addAction:action];
    [self presentViewController:controll animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section ==self.array.count-1) {
        return 2;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGGAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[NGGAddAddressCell alloc]initWithReuseIdentifier:@"cellID"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0) {
        cell.textLabel.text = self.array[indexPath.section];
        cell.textField.tag = 1000;
        cell.textField.placeholder = @"请输入收货人";
        
    }else if (indexPath.section==1){
        cell.textLabel.text = self.array[indexPath.section];
        cell.textField.keyboardType = UIKeyboardTypePhonePad;
        cell.textField.tag = 1100;
        cell.textField.placeholder = @"请输入联系方式";
    }
    else if (indexPath.section==2){
        if (indexPath.row==0) {
            cell.textField.enabled = NO;
            cell.textLabel.text = self.array[indexPath.section];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (cell.detailTextLabel.text==nil) {
                cell.detailTextLabel.text = @"请选择";
            }else{
                cell.detailTextLabel.text = _areaAddress;
            }
        }else{
            [cell.textField removeFromSuperview];
            [cell addSubview:self.detaAddress];
        }
    }
    return cell;
}

#pragma mark-获取所输入的数据
-(void)editingTextFieldPassTag
{
    UITextField *textField1 = [self.view viewWithTag:1000];
    UITextField *textField2 = [self.view viewWithTag:1100];
    
    _userName = textField1.text;
    _userPhong =textField2.text;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==2&&indexPath.row==1) {
        
        return 64;
    }
    else{
        return 44;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==2&&indexPath.row==0) {
        
       [Address customChinaPicker:self superView:self.view];
    }
}

#pragma mark-AddressDelegate代理
- (void)AddressDelegateChinaModel:(ChinaArea *)chinaModel

{
    _areaAddress = [NSString stringWithFormat:@"%@ %@ %@",chinaModel.provinceModel.NAME,chinaModel.cityModel.NAME,chinaModel.areaModel.NAME];
    [self.tableView reloadData];
    
}

#pragma mark-上传地址
-(void)AddAddress
{
    NSString *str = [NSString stringWithFormat:@"%@,%@",_areaAddress,_detaAddress.text];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                                @"address":str,
                                @"username":_userName,
                                @"userphone":_userPhong,
                                @"userid":[NSString stringWithFormat:@"%d",USERDEFINE.currentUser.userId]
                                };

    [manager POST:AddAddressURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //[self alert:@"网络请求失败"];
    }];
}
@end
