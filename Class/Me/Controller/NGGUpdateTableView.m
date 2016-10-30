//
//  NGGUpdateTableView.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGUpdateTableView.h"
#import "NGGUpdateCell.h"
#import "Address.h"
@interface NGGUpdateTableView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *userName;//用户名
    NSString *userPhone;//用用户手机号
    NSString *detadAddress;//详细地址
}
@property (strong,nonatomic)NSArray *array;//cell标题数组
@property (strong,nonatomic)UIBarButtonItem *rightBtn;
@property (strong,nonatomic)NSString *chooseAddress;//选择到的地址
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSString *areaAddress;//区域地址
@property (strong,nonatomic) NSMutableString *detailedAddress;//区域除外的详细地址

@end

@implementation NGGUpdateTableView

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"编辑地址";
    self.rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveRightBtn)];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _array = @[@"收货人",@"联系方式",@"收货地址"];
    

    
    
    //拆分地址串
    NSArray *array = [self.dic[@"address_name"] componentsSeparatedByString:@","];
    self.areaAddress = [array firstObject];
   self.detailedAddress= [[NSMutableString alloc]init];
    for (int i=1; i<array.count; i++) {
         self.detailedAddress = [NSMutableString stringWithFormat:@"%@%@",self.detailedAddress, array[i]];
    }
}
#pragma mark-保存
-(void)saveRightBtn{

    //[self.tableView reloadData];
    [self editingTextFieldPassTag];
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定修改地址" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateAddress];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [controll addAction:action1];
    [controll addAction:action2];
    [self presentViewController:controll animated:YES completion:nil];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.array.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NGGUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[NGGUpdateCell alloc]initWithReuseIdentifier:@"cellID"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        
        cell.textLabel.text = self.array[indexPath.section];
        cell.textField.text = self.dic[@"address_username"];
        cell.textField.tag = 100;
    }else if (indexPath.section==1){
        
        cell.textLabel.text = self.array[indexPath.section];
        cell.textField.text = self.dic[@"address_userphone"];
         cell.textField.tag = 110;
        
    }
    else if (indexPath.section==2){
        cell.textLabel.text = self.array[indexPath.section];
       
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textField.enabled = NO;
        cell.detailTextLabel.text = self.areaAddress;
    }
    else if (indexPath.section==3){
        cell.textField.frame = CGRectMake(20, 0, cell.frame.size.width-40, cell.frame.size.height);
        cell.textField.text = self.detailedAddress;
        cell.textField.tag = 1111;
        
    }
    
    return cell;
}
#pragma mark-获取所输入的信息
-(void)editingTextFieldPassTag
{
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:110];
    UITextField *textField3 = [self.view viewWithTag:1111];
    userName = textField1.text;
    userPhone =textField2.text;
    detadAddress = textField3.text;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        [Address customChinaPicker:self superView:self.view];
    }
}
- (void)AddressDelegateChinaModel:(ChinaArea *)chinaModel

{
    self.areaAddress = [NSString stringWithFormat:@"%@ %@ %@",chinaModel.provinceModel.NAME,chinaModel.cityModel.NAME,chinaModel.areaModel.NAME];
    [self.tableView reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}
#pragma mark-修改地址
-(void)updateAddress
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *updatePwd = @{
                                @"addressid":self.dic[@"address_id"],
                                @"username":userName,
                                @"phone":userPhone,
                                @"address":[NSString stringWithFormat:@"%@,%@",self.areaAddress,detadAddress]
                                };
    
    [manager POST:UpdateAddressURL parameters:updatePwd success:^(NSURLSessionDataTask *task, id responseObject) {
   
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NGGLog(@"失败");
    }];
}

@end
