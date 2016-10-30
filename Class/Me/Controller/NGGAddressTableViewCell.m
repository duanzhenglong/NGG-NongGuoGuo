//
//  NGGAddressTableViewCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddressTableViewCell.h"
#import "UIView+NGGExtension.h"

@implementation NGGAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier str:(NSString *)str;
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addControls:str];
        
    }
    return self;
}

-(void)setUpAddress:(NSDictionary *)dic{
    self.userNameLab.text = dic[@"address_username"];
    self.userPhoneLab.text = dic[@"address_userphone"];
    
    //拆分地址
    NSArray *array = [dic[@"address_name"] componentsSeparatedByString:@","];
    NSMutableString *str = [[NSMutableString alloc]init];
    for (int i=0; i<array.count; i++) {
        str = [NSMutableString stringWithFormat:@"%@ %@",str, array[i]];
    }
    self.userAddressLab.text = str;
    _userAddressLab.numberOfLines=0;
    [_userAddressLab sizeToFit];

}

//加载控件
-(void)addControls:(NSString *)str{
    //用户名
    _userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH/2-20, 28)];
    _userNameLab.textAlignment =NSTextAlignmentLeft;
    
    //手机号
    _userPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/2-20, 28)];
    _userPhoneLab.textAlignment =NSTextAlignmentRight;
    //线1
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(10, _userNameLab.ngg_bottom+5, SCREEN_WIDTH-10, 2)];
    
    _view1.backgroundColor = NGGColorA(220, 220, 220, 255);
    //收货地址
   
    _userAddressLab = [[UILabel alloc]initWithFrame:CGRectMake(20, _view1.ngg_bottom+10, SCREEN_WIDTH-40, 64)];
    _userAddressLab.text = str;
    _userAddressLab.numberOfLines=0;
    [_userAddressLab sizeToFit];
    
    //线2
    _view2  = [[UIView alloc]initWithFrame: CGRectMake(10, _userAddressLab.ngg_bottom+5, SCREEN_WIDTH-5, 2)];
    _view2.backgroundColor = NGGColorA(220, 220, 220, 255);
    //选择按钮
    _chooseImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, _view2.ngg_bottom+19, 16, 16)];
    _chooseImage.layer.cornerRadius = _chooseImage.ngg_width/2;
    _chooseImage.layer.masksToBounds = YES;
    //默认收货地址
    _defaultAdress = [[UILabel alloc]initWithFrame:CGRectMake(_chooseImage.ngg_right+5, _view2.ngg_bottom+13, 120, 28)];
    _defaultAdress.text = @"默认收货地址";
    [_defaultAdress setFont:[UIFont systemFontOfSize:14]];
    //修改Btn
    _updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-84, _view2.ngg_bottom+5, 64, 44)];
    _updateBtn.layer.cornerRadius = 8.0f;
    _updateBtn.layer.masksToBounds= YES;
    _updateBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:1.2];
    [_updateBtn setTitle:@"修改" forState:UIControlStateNormal];
    [_updateBtn setBackgroundColor:NGGTheMeColor];
    //删除Btn
     _removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_updateBtn.ngg_x-74, _view2.ngg_bottom+5, 64, 44)];
    _removeBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:1.2];
    _removeBtn.layer.cornerRadius = 8.0f;
    _removeBtn.layer.masksToBounds= YES;
    [_removeBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_removeBtn setBackgroundColor:[UIColor redColor]];
    

    self.userNameLab.font = [UIFont systemFontOfSize:16];
     self.userPhoneLab.font = [UIFont systemFontOfSize:16];
    self.userAddressLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:_userNameLab];
    [self addSubview:_userPhoneLab];
    [self addSubview:_view1];
    
    [self addSubview:_userAddressLab];
    [self addSubview:_view2];
    [self addSubview:_chooseImage];
    [self addSubview:_defaultAdress];
    [self addSubview:_removeBtn];
    [self addSubview:_updateBtn];
    
    CGRect rect = self.frame;
    rect.size.height = _userNameLab.ngg_height+_userAddressLab.ngg_height+_updateBtn.ngg_height+40.0f;
    self.frame = rect;
    
    //点击事件
    //修改
    [_updateBtn addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    //删除
    [_removeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    //默认按钮-
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    _chooseImage.userInteractionEnabled = YES;
    [_chooseImage addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    _defaultAdress.userInteractionEnabled = YES;
    [_defaultAdress addGestureRecognizer:tap2];

}

#pragma mark-删除
-(void)remove{
    
    if ([self.delegate respondsToSelector:@selector(removeClick:)]) {
        [self.delegate removeClick:self.tag];
    }
}
#pragma mark-修改
-(void)update{

    if ([self.delegate respondsToSelector:@selector(updateClick:)]) {
        [self.delegate updateClick:self.tag];
    }
}
#pragma mark-修改默认
-(void)tapImage{
    
    if ([self.delegate respondsToSelector:@selector(tapImageClick:)]) {
        [self.delegate tapImageClick:self.tag];
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
