//
//  AppDelegate.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "AppDelegate.h"
#import "NGGRootViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "EMSDK.h"
@interface AppDelegate ()
@end
 /*SMS key*/
#define appkey @"176feffeed52e"
#define app_secrect @"32fb3ea4e0bf47df58b9a3d9f26742b3"
 /*环信 key*/
#define Appkey @"1146160926178516#nongguoguo"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  初始化界面根控制器
     */
    self.window.frame=[[UIScreen mainScreen] bounds];
    self.window.rootViewController=[[NGGRootViewController alloc]init];
    [self.window makeKeyAndVisible];
    /**
     *  注册短信验证码的SDK
     */
    [SMSSDK registerApp:appkey withSecret:app_secrect];
    /**
     *  获取已登陆用户信息
     */
    [self AchieveUserInfo];
    /**
     *  注册环信AppKey
     */
    [self RegisterAppkey];
    
    return YES;
}

#pragma mark-获取已登陆用户信息
-(void)AchieveUserInfo{
    //读取沙盒路径
    NSString* path=[NSString stringWithFormat:@"%@/Documents/user.plist",NSHomeDirectory()];
     /*创建一个文件管理器(FileManager)*/
    NSFileManager *Manager=[NSFileManager defaultManager];
    if ([Manager fileExistsAtPath:path]) {
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
        USERDEFINE.currentUser=[NGGUser setUserInfoByDic:dic];
    }
}

#pragma mark-注册环信AppKey
-(void)RegisterAppkey{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:Appkey];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}























- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
