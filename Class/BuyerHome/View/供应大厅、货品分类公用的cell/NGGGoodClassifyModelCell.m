//
//  NGGGoodClassifyModelCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGGoodClassifyModelCell.h"

@implementation NGGGoodClassifyModelCell

#pragma mark-- 在这里可以重写cell的frame
- (void)setFrame:(CGRect)frame {
  frame.origin.x = 0;
  frame.origin.y += 2;
  frame.size.width = self.frame.size.width;
  frame.size.height -= 3;
  [super setFrame:frame];
}

#pragma mark-- 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间
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

#pragma mark -给Cell自定义控件
- (void)CreatCustomizeControls {

  /*创建图片*/
  self.ImgView =
      [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 100)];
  // self.ImgView.backgroundColor=[UIColor redColor];
  [self addSubview:self.ImgView];

  /*创建标题Label*/
  self.TitleLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH - 260, 5, SCREEN_WIDTH / 2, 35)];
  [self.TitleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
  [self.TitleLabel setTextColor:NGGColorFromRGB(0x333333)];
  [self addSubview:self.TitleLabel];

  /*创建Label*/
  self.NumberLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 15, 60, 15)];
  [self.NumberLabel setFont:[UIFont systemFontOfSize:15]];
  self.NumberLabel.textAlignment = NSTextAlignmentLeft;
  [self addSubview:self.NumberLabel];

  /*创建起供Label*/
  self.AtLast =
      [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 15, 60, 15)];
  [self.AtLast setFont:[UIFont systemFontOfSize:15]];
  [self addSubview:self.AtLast];

  /*创建地址Label*/
  self.AddressLab = [[UILabel alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH - 260, self.TitleLabel.ngg_bottom,
                               0, 40)];
  [self.AddressLab setFont:[UIFont systemFontOfSize:16]];
    [self.AddressLab setTextColor:[UIColor orangeColor]];
  [self addSubview:self.AddressLab];

  /*创建卖家Label*/
  self.SellerNickLab = [[UILabel alloc]
      initWithFrame:CGRectMake(self.AddressLab.ngg_right, self.TitleLabel.ngg_bottom,
                               SCREEN_WIDTH - 40, 40)];
  [self.SellerNickLab setFont:[UIFont systemFontOfSize:16]];
  self.SellerNickLab.numberOfLines = 0;
  [self.SellerNickLab setTextColor:[UIColor orangeColor]];
  [self addSubview:self.SellerNickLab];

  /*创建时间Label*/
  self.TimeLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH - 260,
                               self.SellerNickLab.ngg_bottom, 130, 15)];
  [self.TimeLabel setFont:[UIFont systemFontOfSize:16]];
  [self addSubview:self.TimeLabel];

  /*创建查看详情Button*/
  self.DscButton = [[UIButton alloc]
      initWithFrame:CGRectMake(SCREEN_WIDTH - 100, self.TimeLabel.ngg_y, 80,
                               25)];
  [self.DscButton.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
  [self.DscButton setTitle:@"查看详情" forState:UIControlStateNormal];
  [self.DscButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
  [self.DscButton setTitleColor:[UIColor lightGrayColor]
                       forState:UIControlStateHighlighted];
  self.DscButton.layer.cornerRadius = 5;
  self.DscButton.layer.masksToBounds = YES;
  [self.DscButton setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
  [self.DscButton addTarget:self
                     action:@selector(DscButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.DscButton];
}

#pragma mark -给每个控件进行赋值
- (void)initWithForm:(NGGGoodsProperty *)Attribute {

  self.TitleLabel.text = Attribute.supplylist_goodsname;

  self.AddressLab.text = Attribute.address_name;
 [self.AddressLab sizeToFit];
  self.NumberLabel.text = Attribute.supplylist_minnumber;
  self.SellerNickLab.text = Attribute.user_nick;
  self.TimeLabel.text = Attribute.supplylist_time;

  self.AtLast.text = @"斤起供";

  NSString *strURL = Attribute.supplylist_image;

  NSURL *url = [NSURL URLWithString:strURL];

  NSData *data = [NSData dataWithContentsOfURL:url];

  self.ImgView.image = [UIImage imageWithData:data];
}

#pragma mark -查看详情按钮的触发事件
- (void)DscButtonClick:(UIButton *)sender {
  NGGLogFunc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

@end
