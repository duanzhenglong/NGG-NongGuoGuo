//
//  NGGPersonal.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/15.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGPersonal : NSObject

@property (strong,nonatomic)NSString *userPersonalNick;
@property (strong,nonatomic)NSString *userPersonalPhone;
@property (strong,nonatomic)NSString *userPersonalJob;
@property (strong,nonatomic)NSString *userPersonalAddress;
+(NGGPersonal *)initWithPersonalInfoDic:(NSDictionary *)dic;

@end
