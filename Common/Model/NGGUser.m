//
//  NGGUser.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGUser.h"

@implementation NGGUser

/**
 *  给用户设置属性
 *
 *  @param Dic 数据字典
 *
 *  @return 用户模型
 */
+(NGGUser*)setUserInfoByDic:(NSDictionary*)dic{
    NGGUser *user=[[NGGUser alloc]init];
    user.userId=[dic[@"user_id"] intValue];
    user.userNick=dic[@"user_nick"];
    user.userPhone=dic[@"user_phone"];
    user.userPassword=dic[@"user_password"];
    user.userCertification=dic[@"user_certification"];
    user.userHeadimage=dic[@"user_headimage"];
    user.userShop=dic[@"user_shop"];
    user.userAddressId=[dic[@"address_id"] integerValue];
    user.userProssionId=[dic[@"profession_id"] integerValue];
    return user;
}
@end
