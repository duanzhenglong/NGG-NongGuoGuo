//
//  NGGTwoViewCell.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGTwoViewCell : UITableViewCell

/*品种Lab*/
@property(nonatomic, strong) UILabel *VarietyLab;
/*产品Lab*/
@property(nonatomic, strong) UILabel *ProductLab;
/*采购数量*/
@property(nonatomic, strong) UILabel *BuyCountLab;
/*采购人*/
@property(nonatomic, strong) UILabel *BuyNameLab;
/*联系方式*/
@property(nonatomic, strong) UILabel *TelLab;
/*发布采购时间Lab*/
@property(nonatomic, strong) UILabel *TimeLab;
/*截止时间*/
@property(nonatomic, strong) UILabel *AtLast;
/*所在地*/
@property(nonatomic, strong) UILabel *addressLab;
/*截止时间*/
@property(nonatomic, strong) UILabel *OverTimeLab;

- (void)initWithForm:(NGGGoodsAttribute *)Attribute;
@end
