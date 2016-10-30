//
//  NGGInfoCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGInfoCell.h"
#import "UIView+NGGExtension.h"
#define LabHeight 28
#define LabWidth 80
@implementation NGGInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addControls];
      
    }
    return self;
}
-(void)addControls{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 36)];
    lab1.font = [UIFont systemFontOfSize:18 weight:1.2];
    lab1.text = @"有人报价";
    [self addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(lab1.ngg_x, lab1.ngg_bottom+5, LabWidth, LabHeight)];
    lab2.font = [UIFont systemFontOfSize:16];
    lab2.text = @"报价人:";
    [self addSubview:lab2];
    self.offeruserName = [[UILabel alloc]initWithFrame:CGRectMake(lab2.ngg_right+10, lab1.ngg_bottom+5, SCREEN_WIDTH/2, LabHeight)];
    self.offeruserName.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.offeruserName];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(lab2.ngg_x, lab2.ngg_bottom+5, LabWidth, LabHeight)];
    lab3.font = [UIFont systemFontOfSize:16];
    lab3.text = @"报价时间:";
    [self addSubview:lab3];
    self.offerPriceTime = [[UILabel alloc]initWithFrame:CGRectMake(lab2.ngg_right+10, lab2.ngg_bottom+5, SCREEN_WIDTH/2, LabHeight)];
     self.offerPriceTime.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.offerPriceTime];
    
    
    UILabel *tapLook = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-95, lab2.ngg_y-5, 75,LabHeight+10)];
    tapLook.text = @"点击查看";
    tapLook.textAlignment= NSTextAlignmentCenter;
    tapLook.layer.cornerRadius = 5;
    tapLook.layer.masksToBounds = YES;
    tapLook.backgroundColor = [UIColor redColor];
    
    [self addSubview:tapLook];
    
    
    CGRect rect = self.frame;
    rect.size.height = lab1.ngg_height+lab2.ngg_height+lab3.ngg_height+20.0f;
    self.frame = rect;
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
