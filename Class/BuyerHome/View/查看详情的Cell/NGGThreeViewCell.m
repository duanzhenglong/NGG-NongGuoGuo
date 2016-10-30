//
//  NGGThreeViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGThreeViewCell.h"

@implementation NGGThreeViewCell

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame {
  //    frame.origin.y +=5;
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
  /*创建第三个cell的view*/
  UIView *views =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
  views.backgroundColor = [UIColor whiteColor];
  [self addSubview:views];

  self.DescLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 40)];

  [views addSubview:self.DescLab];

  /*设置cell被中的样式，这里让它没有变化*/
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)initWithForm:(NGGGoodsAttribute *)Attribute {

  self.DescLab.text = Attribute.needlist_desc;
}

@end
