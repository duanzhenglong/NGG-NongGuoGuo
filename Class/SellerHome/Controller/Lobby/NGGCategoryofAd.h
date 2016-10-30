//
//  NGGCategoryofAd.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/18.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGCategoryofAd : UIView
/**
 *显示地区查询界面
 */
+(void)ShowAdCategoryView;
/**
 *隐藏地区查询界面
 */
+(void)HiddenAdCategoryView;
 /***定义block***/
@property (copy, nonatomic) void (^AdCategoryView)(NSString*);
-(void)viewDidLoad;
@end
