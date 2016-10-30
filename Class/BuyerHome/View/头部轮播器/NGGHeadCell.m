

//
//  NGGHeadNewsViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGHeadCell.h"
#import "NGGNewScrollView.h"
@implementation NGGHeadCell {
  UIView *_testView;
}

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame {
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

#pragma mark -创建控件
- (void)CreatCustomizeControls {
    /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
  _testView =
      [[UIView alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH, 40)];
  [_testView sizeToFit];
  // _testView.backgroundColor=[UIColor redColor];
  [self addSubview:_testView];
  NGGNewScrollView *View = [[NGGNewScrollView alloc]
      initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                               _testView.frame.size.height)];
  View.backgroundColor = [UIColor blueColor];
  View.titleArray =
      [NSArray arrayWithObjects:@" 3分钟前  苹果 1/斤  香蕉 0.8/斤",
                                @"5分钟前 大白菜0.5/斤 红萝卜1.2/斤",
                                @"10分钟前 走地鸡 20/斤 猪肉18/斤",
                                @"15分钟前 花生油 16/斤 菜籽油12/斤", nil];

  View.titleFont = 14;
  View.titleColor = [UIColor blackColor];
  View.BGColor = [UIColor clearColor];
  [_testView addSubview:View];

  /*头条Label*/
  UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 70, 30)];
  [self addSubview:Label1];
  [Label1 setTextColor:NGGColorFromRGB(0x30c2bd)];
  [Label1 setFont:[UIFont systemFontOfSize:17 weight:4]];
  [Label1 setText:@"最新消息"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}
@end
