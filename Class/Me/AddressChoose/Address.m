//
//  Address.m
//  addressChoose
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 xll. All rights reserved.
//

#import "Address.h"

#define KSWidth [[UIScreen mainScreen]bounds].size.width
#define KSHeight [[UIScreen mainScreen]bounds].size.height
#define PickHeight [[UIScreen mainScreen]bounds].size.height/2
#define RowWidth 44
#define ComponentWidth (KSWidth-20)/3
@interface Address()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic)UIView *chooseView;//选择器视图
@property (strong,nonatomic)UIView *hideView;//蒙蔽层
@property (strong,nonatomic)UIView *btnView;//添加确定按钮的视图
@property (strong,nonatomic)UIButton *btn;//确定按钮
@property (strong,nonatomic)UILabel *showAddress;//显示地址
@property (strong,nonatomic)UIPickerView *pickView;//选择器tableView

@property (strong,nonatomic)ChinaArea *chinaModel;//数据模型
@property (strong,nonatomic)NSString *selectedProvinceID;//选择的省份ID
@property (strong,nonatomic)NSString *selectedCityID;//选择的城市ID
@property (strong,nonatomic)NSString *selectedAreaID;//选择的区域ID



@end

@implementation Address

+(Address *)customChinaPicker:(id)delegate superView:(UIView*)views
{
    UIView *oldView = [views viewWithTag:1111];
    if ([oldView isKindOfClass:[Address class]]) {
        Address *navView = (Address *)oldView;
        navView.delegate = delegate;
        [navView showAddressChooseView];
        return navView;
        
        
    }else{
        Address *naView = [[Address alloc]init];
        naView.delegate = delegate;
        [views addSubview:naView];
        naView.tag =1111;
        [naView showAddressChooseView];
        return naView;
    
    }
}

//重写父类方法
- (instancetype)init{
    if (self = [super init]) {
        [self initChooseAddress];
    }
    return self;
}
//初始化城市选择器
-(void)initChooseAddress{
    // 模型的初始化
    self.chinaModel = [[ChinaArea alloc] init];
    
    // 默认
    self.selectedProvinceID = @"2";  // 北京市
    self.selectedCityID = @"52";     // 北京市
    self.selectedAreaID = @"500";    // 东城区
    
    self.chinaModel.provinceModel = ((ProvinceModel *)[self.chinaModel getProvinceDataByID:self.selectedProvinceID]);
    self.chinaModel.cityModel = ((CityModel *)[self.chinaModel getCityDataByID:self.selectedCityID]);
    self.chinaModel.areaModel = ((AreaModel *)[self.chinaModel getAreaDataByID:self.selectedAreaID]);
    //初始化视图
    self.frame = CGRectMake(0, 0,KSWidth, KSHeight);
    self.userInteractionEnabled = YES;
    self.hidden  = YES;
    self.backgroundColor = [UIColor clearColor];
    //蒙蔽层
    self.hideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSWidth, KSHeight)];
    self.hideView.backgroundColor = [UIColor colorWithRed:45 green:47 blue:57 alpha:0.0f];
    [self addSubview:self.hideView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAddressChooseView)];
    [self.hideView addGestureRecognizer:tap];
    //添加选择器视图
    self.chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, KSHeight-PickHeight, KSWidth, PickHeight)];
    self.chooseView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.chooseView];
    //添加确认视图
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSWidth, 44)];
    self.btnView.backgroundColor = [UIColor blueColor];
    [self.chooseView addSubview:self.btnView];
    //确认按钮
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(KSWidth-70, 0, 60, 44)];
    [self.btn setTitle:@"确定" forState:UIControlStateNormal];
    [self.btn setTitle:@"确定" forState:UIControlStateHighlighted];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnView addSubview:self.btn];
    //显示地址
    self.showAddress = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, KSWidth-100, 44)];
    [self.btnView addSubview:self.showAddress];
    
    //UIPickerView
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,44, KSWidth, PickHeight-44)];
    self.pickView.delegate = self;
   self.pickView.dataSource = self;
    self.pickView.backgroundColor = [UIColor brownColor];
    [self.chooseView addSubview:self.pickView];
    
}
//pickView列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//每列行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 省份
        return [self.chinaModel getAllProvinceData].count;
    }
    else if (component == 1){ // 城市
        return [self.chinaModel getCityDataByParentID:self.selectedProvinceID].count;
    }
    else{ // 区域
        return [self.chinaModel getAreaDataByParentID:self.selectedCityID].count;
    }
}
//每列宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return ComponentWidth;
}
//每行行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return RowWidth;
}
//每行视图
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    if (component == 0) { // 省份
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, ComponentWidth, RowWidth);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:18];
        textLabel.text = ((ProvinceModel *)[self.chinaModel getAllProvinceData][row]).NAME;

        [view addSubview:textLabel];
        return view;
    }
    else if (component == 1){ // 城市
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, ComponentWidth, RowWidth);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row]).NAME;
        textLabel.font = [UIFont systemFontOfSize:14];

        [view addSubview:textLabel];
        return view;
    }
    else{ // 区域
        if (!view) {
            view = [[UIView alloc] init];
        }
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(0, 0, ComponentWidth, RowWidth);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = ((AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][row]).NAME;
        textLabel.font = [UIFont systemFontOfSize:14];

        [view addSubview:textLabel];
        return view;
    }

}
// pickerView选中代理
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    switch (component) {
        case 0:{ // 选择省份
            self.selectedProvinceID = ((ProvinceModel *)[self.chinaModel getAllProvinceData][row]).ID;
            [pickerView reloadComponent:1]; // 重载城市
            [pickerView selectRow:0 inComponent:1 animated:YES];
            self.chinaModel.provinceModel = (ProvinceModel *)[self.chinaModel getAllProvinceData][row];
            // 选择了省份就自动定位到该省的第一个市
            self.selectedCityID = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][0]).ID;
            self.chinaModel.cityModel = (CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][0];
            
            // 选择了省份就自动定位到该省的第一个市的第一个区
            [pickerView  reloadComponent:2]; // 重载区域
            [pickerView selectRow:0 inComponent:2 animated:YES];
            if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][0];
            }
            else{
                self.chinaModel.areaModel.NAME = @"";
                self.chinaModel.areaModel.ID = @"";
                self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                self.chinaModel.areaModel.GRADE = @"3";
            }

           
            break;
        }
        case 1:{ // 选择城市
            self.selectedCityID = ((CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row]).ID;
            [pickerView  reloadComponent:2]; // 重载区域
            [pickerView selectRow:0 inComponent:2 animated:YES];
            self.chinaModel.cityModel = (CityModel *)[self.chinaModel getCityDataByParentID:self.selectedProvinceID][row];
            // 选择了市就定位到该市的第一个区
           
            if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][0];
            }
            else{
                self.chinaModel.areaModel.NAME = @"";
                self.chinaModel.areaModel.ID = @"";
                self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                self.chinaModel.areaModel.GRADE = @"3";
            }
            
            break;
        }
        case 2: // 选择区域
            if ([self.chinaModel getAreaDataByParentID:self.selectedCityID].count > 0) {
                self.chinaModel.areaModel = (AreaModel *)[self.chinaModel getAreaDataByParentID:self.selectedCityID][row];
            }
            else{
                self.chinaModel.areaModel.NAME = @"";
                self.chinaModel.areaModel.ID = @"";
                self.chinaModel.areaModel.PARENT_AREA_ID = @"9";
                self.chinaModel.areaModel.GRADE = @"3";
            }
            
            
            break;
        default:
            break;
    }
   
    self.showAddress.text = [NSString stringWithFormat:@"%@ %@ %@",self.chinaModel.provinceModel.NAME,self.chinaModel.cityModel.NAME,self.chinaModel.areaModel.NAME];
    
    if ([_delegate respondsToSelector:@selector(AddressDelegateChinaModel:)]) {
        [_delegate AddressDelegateChinaModel:self.chinaModel];
    }
    
}
-(void)btnClick
{
    //点击确定传值
    
    
    [self hideAddressChooseView];
}
//隐藏视图
-(void)hideAddressChooseView
{
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.chooseView.frame = CGRectMake(0,KSHeight-PickHeight , KSWidth, PickHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
             self.hideView.backgroundColor = [UIColor colorWithRed:45 green:47 blue:56 alpha:0.2f];
        } completion:^(BOOL finished) {
            self.hidden=YES;
        }];
       
    }];

}
//显示视图
-(void)showAddressChooseView
{
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    self.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        
//        self.backgroundColor = [UIColor redColor];
        
        self.chooseView.frame = CGRectMake(0,KSHeight-PickHeight , KSWidth, PickHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
             self.hideView.backgroundColor = [UIColor colorWithRed:45 green:47 blue:56 alpha:0.2f];
        }];
    }];
    

}
@end
