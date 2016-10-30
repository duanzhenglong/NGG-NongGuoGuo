//
//  NGGTwoViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGTwoViewCell.h"

@implementation NGGTwoViewCell

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame {
  //      frame.origin.y +=5;
  //    frame.size.height -= 5;
  [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.backgroundColor = NGGColor(255, 255, 255);
    /**
     *  创建控件
     */
    [self CreatCustomizeControls];
  }
  return self;
}

- (void)CreatCustomizeControls {

  /*创建第二个cell的view*/
  UIView *views = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, self.frame.size.width, 230)];
  views.backgroundColor = [UIColor whiteColor];
  [self addSubview:views];

  /*创建ProductLab*/
  self.ProductLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
  self.ProductLab.text = @"品种:";
  [self.ProductLab setTextColor:NGGTheMeColor];
  [views addSubview:self.ProductLab];

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 30, 200,
                               40)];
  self.VarietyLab.text = @"产品:";
  [self.VarietyLab setTextColor:NGGTheMeColor];
  [views addSubview:self.VarietyLab];

  /*创建采购数量*/
  self.BuyCountLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 60, 200,
                               40)];
  self.BuyCountLab.text = @"采购数量:";
  [self.BuyCountLab setTextColor:NGGTheMeColor];
  [views addSubview:self.BuyCountLab];

  /*创建采购人*/
  self.BuyNameLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 90, 200,
                               40)];
  self.BuyNameLab.text = @"采购人:";
  [self.BuyNameLab setTextColor:NGGTheMeColor];
  [views addSubview:self.BuyNameLab];

  /*创建联系电话*/
  self.TelLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 120, 200,
                               40)];
  self.TelLab.text = @"联系方式:";
  [self.TelLab setTextColor:NGGTheMeColor];
  [views addSubview:self.TelLab];

  /*创建所在地*/
  self.addressLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 150, 200,
                               40)];
  self.addressLab.text = @"所在地:";
  [self.addressLab setTextColor:NGGTheMeColor];
  [views addSubview:self.addressLab];

  /*创建TimeLab*/
  self.TimeLab = [[UILabel alloc]
      initWithFrame:CGRectMake(10, self.ProductLab.frame.origin.y + 180, 200,
                               40)];
  self.TimeLab.text = @"采购时间:";
  [self.TimeLab setTextColor:NGGTheMeColor];
  [views addSubview:self.TimeLab];

  /******************创建获取到数据库里数据的lab******************/

  /*创建VarietyLab*/
  self.VarietyLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 40)];
  [self.VarietyLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.VarietyLab];

  /*创建ProductLab*/
  self.ProductLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.ProductLab.frame.origin.y + 30, 200,
                               40)];

  [self.ProductLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.ProductLab];

  /*创建采购数量*/
  self.BuyCountLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.VarietyLab.frame.origin.y + 60, 200,
                               40)];

  [self.BuyCountLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.BuyCountLab];

  /*创建采购人*/
  self.BuyNameLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.VarietyLab.frame.origin.y + 90, 200,
                               40)];

  [self.BuyNameLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.BuyNameLab];

  /*创建联系电话*/
  self.TelLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.VarietyLab.frame.origin.y + 120, 200,
                               40)];

  [self.TelLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.TelLab];

  /*创建所在地*/
  self.addressLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.VarietyLab.frame.origin.y + 150, 200,
                               40)];

  [self.addressLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.addressLab];

  /*创建TimeLab*/
  self.TimeLab = [[UILabel alloc]
      initWithFrame:CGRectMake(100, self.VarietyLab.frame.origin.y + 180, 200,
                               40)];

  [self.TimeLab setTextColor:NGGBlackLabColor];
  [views addSubview:self.TimeLab];

  /*设置cell被中的样式，这里让它没有变化*/
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)initWithForm:(NGGGoodsAttribute *)Attribute {

  self.VarietyLab.text = Attribute.goodsclassify_name;
  self.ProductLab.text = Attribute.needlist_goodsname;
  self.BuyCountLab.text = Attribute.needlist_number;
  self.BuyNameLab.text = Attribute.needlist_linkman;
  self.TelLab.text = Attribute.needlist_linkmanphone;
  self.addressLab.text = Attribute.address_name;
  self.TimeLab.text = Attribute.needlist_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
