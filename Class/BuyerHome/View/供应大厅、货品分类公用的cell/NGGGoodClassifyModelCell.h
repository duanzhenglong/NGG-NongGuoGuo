//
//  NGGGoodClassifyModelCell.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGGoodsProperty.h"
@interface NGGGoodClassifyModelCell : UITableViewCell
/*图片*/
@property(nonatomic, strong) UIImageView *ImgView;
/*标题*/
@property(strong, nonatomic) UILabel *TitleLabel;
/*内容*/
@property(strong, nonatomic) UILabel *AddressLab;
/*采购数量*/
@property(strong, nonatomic) UILabel *NumberLabel;
/*采购时间*/
@property(strong, nonatomic) UILabel *TimeLabel;
/*详情查看*/
@property(strong, nonatomic) UIButton *DscButton;
/*卖家昵称*/
@property(strong, nonatomic) UILabel *SellerNickLab;
/*多少斤起供*/
@property(nonatomic, strong) UILabel *AtLast;

- (void)initWithForm:(NGGGoodsProperty *)Attribute;


@end
