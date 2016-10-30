//
//  UserModel.h
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic) NSString *userId;//用户ID
@property (nonatomic,strong) NSString *userPhone;//用户手机号
@property (nonatomic,strong) NSString *userNick;//用户昵称
@property (nonatomic,strong) NSString *userPwd;//用户密码
@property (nonatomic,strong) NSString *userHeadimg;//用户头像名称
@property (nonatomic,strong) NSString *userCertification;//实名认证
@property (nonatomic,strong) NSString *userShop;//用户商店
@property (nonatomic,strong) NSString *addId;//用户默认地址ID
@property (nonatomic,strong) NSString *professionId;//用户职业
+(UserModel *)initWithDic:(NSDictionary*)dic;


@property (strong,nonatomic)NSString *userPersonalNick;
@property (strong,nonatomic)NSString *userPersonalPhone;
@property (strong,nonatomic)NSString *userPersonalJob;
@property (strong,nonatomic)NSString *userPersonalAddress;
+(UserModel *)initWithPersonalInfoDic:(NSDictionary *)dic;




@end
