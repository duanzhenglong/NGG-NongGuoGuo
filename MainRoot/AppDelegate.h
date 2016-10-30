//
//  AppDelegate.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGUser.h"
#import "NGGPersonal.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

 /*声明一个用户模型属性 作为当前登陆用户*/
@property (strong, nonatomic) NGGUser* currentUser;
 /***个人信息模型 作为查看个人当前信息，修改职业***/
@property (strong, nonatomic) NGGPersonal* userPersonalModel;

@end

