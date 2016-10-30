//
//  NGGUser.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGUser : NSObject
 /*用户ID*/
@property int userId;
 /*用户昵称*/
@property (strong, nonatomic) NSString* userNick;
 /*用户电话*/
@property (strong, nonatomic) NSString* userPhone;
 /*用户密码*/
@property (strong, nonatomic) NSString* userPassword;
 /*用户身份认证*/
@property (strong, nonatomic) NSString* userCertification;
 /*用户头像*/
@property (strong, nonatomic) NSString* userHeadimage;
 /*用户店铺*/
@property (strong, nonatomic) NSString* userShop;
 /*用户地址ID*/
@property NSUInteger userAddressId;
 /*用户职位ID*/
@property NSUInteger userProssionId;

 /***额外属性：用来判断当前用户是卖家还是买家***/
@property int  Usermark;

/**
 *  给用户设置属性
 *
 *  @param Dic 数据字典
 *
 *  @return 用户模型
 */
+(NGGUser*)setUserInfoByDic:(NSDictionary*)dic;

@end
