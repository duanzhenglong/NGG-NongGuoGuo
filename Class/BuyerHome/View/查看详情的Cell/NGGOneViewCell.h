//
//  NGGOneViewCell.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGOneViewCell : UITableViewCell
/*买家Lab*/
@property(nonatomic, strong) UILabel *BuyLab;
/*显示买家购买的品种*/
@property(nonatomic, strong) UILabel *BuyProduct;
/*截止具体时间dayLab*/
@property(nonatomic, strong) UILabel *dayLab;
/*产品Lab*/
@property(nonatomic, strong) UILabel *ProductLab;
/*品种Lab*/
@property(nonatomic, strong) UILabel *VarietyLab;
/*价格Lab*/
@property(nonatomic, strong) UILabel *PriceLab;
/*发布时间Lab*/
@property(nonatomic, strong) UILabel *TimeLab;
/*采购人*/
@property(nonatomic, strong) UILabel *NameLab;
/*采购数量*/
@property(nonatomic, strong) UILabel *BuyCountLab;
/*所在地*/
@property(nonatomic, strong) UILabel *addressLab;
/*截止时间*/
@property(nonatomic, strong) UILabel *OverTimeLab;
@end
