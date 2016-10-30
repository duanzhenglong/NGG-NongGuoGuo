//
//  NGGAddressTableViewCell.h
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NGGAddressTableViewCellDelegate <NSObject>

-(void)removeClick:(NSInteger)index;
-(void)updateClick:(NSInteger)index;
-(void)tapImageClick:(NSInteger)index;


@end
@interface NGGAddressTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *userNameLab;//用户名
@property (strong,nonatomic) UILabel *userPhoneLab;//手机号
@property (strong,nonatomic) UILabel *userAddressLab;//用户地址
@property (strong,nonatomic) UILabel *defaultAdress;//默认地址
@property (strong,nonatomic) UIImageView *chooseImage;//选择
@property (strong,nonatomic) UIButton *updateBtn;//默认地址
@property (strong,nonatomic) UIButton *removeBtn;//选择
@property (strong,nonatomic) UIView *view1;//线1
@property (strong,nonatomic) UIView *view2;//线2
@property (weak,nonatomic)id<NGGAddressTableViewCellDelegate>delegate;

//初始化cell类
//初始化时直接加载userAddressLab
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier str:(NSString *)str;
- (void)setUpAddress:(NSDictionary*)dic;
@end
