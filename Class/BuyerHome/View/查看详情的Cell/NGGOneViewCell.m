//
//  NGGOneViewCell.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOneViewCell.h"

@implementation NGGOneViewCell

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{
    //    frame.origin.y +=5;
//    frame.size.height -= 5;
    [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=NGGColor(255, 255, 255);
        /**
         *  创建控件
         */
        [self CreatCustomizeControls];
    }
    return self;
}

- (void)CreatCustomizeControls{
    
    /*创建第一个cell的view*/
     UIView *views=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
     views.backgroundColor=[UIColor whiteColor];
     [self addSubview:views];
    
    
    /*创建BuyProduct*/
    self.BuyProduct=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 30)];
    self.BuyProduct.text=@"[买]";
    [self.BuyProduct setTextColor:[UIColor redColor]];
    [views addSubview:self.BuyProduct];
    
    /*创建VarietyLab*/
    self.OverTimeLab=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/1.8, 10, SCREEN_WIDTH/2, 30)];
    
    self.OverTimeLab.text=@"截止时间还剩:    天";
    [self.OverTimeLab setFont:[UIFont systemFontOfSize:14]];
    [self.OverTimeLab setTextColor:[UIColor grayColor]];
    [views addSubview:self.OverTimeLab];
    
    /*设置cell被中的样式，这里让它没有变化*/
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
