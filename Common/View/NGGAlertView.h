//
//  NGGAlertView.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGAlertView : UIView
@property (strong, nonatomic) UILabel* title;
@property (strong, nonatomic) UILabel* Subtitle;

@property (strong, nonatomic) UIButton* cancle;
@property (strong, nonatomic) UIButton* ok;
@property (copy, nonatomic) void (^cancelBlock)();
@property (copy, nonatomic) void (^OkBlock)();
-(void)settitle:(NSString*)title subtitle:(NSString*)subtitle cancelTitle:(NSString*)canceltitle okTitle:(NSString*)oktitle;
@end
