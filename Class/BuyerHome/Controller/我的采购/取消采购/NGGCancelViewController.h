//
//  NGGCancelViewController.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGCancelViewController : UIViewController
/*查看详情按钮*/
@property(nonatomic,strong) UIButton *DscButton;
/*删除按钮*/
@property(nonatomic,strong) UIButton *DelBtn;
/*重新发布按钮*/
@property(nonatomic,strong) UIButton *AgainBtn;
/*产品lab*/
@property(nonatomic,strong) UILabel *ProductLab;
/*品种lab*/
@property(nonatomic,strong) UILabel *VarietyLab;
/*发布采购lab*/
@property(nonatomic,strong) UILabel *TimeLab;



@property(nonatomic,strong) NGGGoodsAttribute *Att;

@end
