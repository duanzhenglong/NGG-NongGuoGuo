//
//  UserModel.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(UserModel *)initWithDic:(NSDictionary *)dic
{
    UserModel *user = [UserModel new];
    user.userId =[NSString stringWithFormat:@"%@",dic[@"user_id"]];
    user.userNick = dic[@"user_nick"];
    user.userPwd = dic[@"user_password"];
    user.userPhone = dic[@"user_phone"];
    user.userHeadimg = dic[@"user_headimage"];
    user.userCertification = dic[@"profession_id"];
    user.userShop = dic[@"user_shop"];
    user.addId = dic[@"address_id"];
    user.professionId = dic[@"profession_id"];
    return user;
}

+(UserModel *)initWithPersonalInfoDic:(NSDictionary *)dic
{
    UserModel *user = [UserModel new];
    user.userPersonalNick = dic[@"user_nick"];
    user.userPersonalPhone = dic[@"user_phone"];
    user.userPersonalJob = dic[@"profession_job"];
    user.userPersonalAddress = dic[@"address_name"];
    return user;
}


@end
