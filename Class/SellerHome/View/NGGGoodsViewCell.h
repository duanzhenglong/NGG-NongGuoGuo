//
//  NGGGoodsViewCell.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGGoodsAttribute.h"
@interface NGGGoodsViewCell : UITableViewCell

/*标题*/
@property (strong, nonatomic) UILabel*TitleLabel;
/*内容*/
@property (strong, nonatomic) UILabel*ConentLabel;
 /*采购数量*/
@property (strong, nonatomic) UILabel*NumberLabel;
 /*采购时间*/
@property (strong, nonatomic) UILabel*TimeLabel;
/*详情查看*/
@property (strong, nonatomic) UIButton*DscButton;

-(void)initWithForm:(NGGGoodsAttribute*)Attribute;
@end
