//
//  NGGPurchaseCell.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGGoodsAttribute.h"
@interface NGGPurchaseCell : UITableViewCell


/*产品lab*/
@property(nonatomic,strong) UILabel *ProductLab;
/*品种lab*/
@property(nonatomic,strong) UILabel *VarietyLab;
/*采购时间lab*/
@property (strong, nonatomic) UILabel *TimeLabel;
/*详情查看Btn*/
@property (strong, nonatomic) UIButton *DscButton;
/*取消采购Btn*/
@property(nonatomic,strong) UIButton *CancelBtn;


-(void)initWithForm:(NGGGoodsAttribute *)Attribute;
@end
