//
//  NGGPersonal.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/15.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPersonal.h"

@implementation NGGPersonal
+(NGGPersonal *)initWithPersonalInfoDic:(NSDictionary *)dic
{
    NGGPersonal *user = [NGGPersonal new];
    user.userPersonalNick = dic[@"user_nick"];
    user.userPersonalPhone = dic[@"user_phone"];
    user.userPersonalJob = dic[@"profession_job"];
    user.userPersonalAddress = dic[@"address_name"];
    return user;
}

@end
