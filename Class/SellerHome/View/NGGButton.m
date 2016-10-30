//
//  NGGButton.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGButton.h"

@implementation NGGButton

#pragma mark-重写Button 图片在上，文字在下
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.ngg_y=18;
    self.imageView.ngg_height = self.ngg_height * 0.4;
    self.imageView.ngg_width = self.imageView.ngg_height;
    self.imageView.ngg_centerX = self.ngg_width * 0.5;
    
    self.titleLabel.ngg_x = 0;
    self.titleLabel.ngg_y = self.imageView.ngg_bottom;
    self.titleLabel.ngg_width = self.ngg_width;
    self.titleLabel.ngg_height = self.ngg_height - self.titleLabel.ngg_y;
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.backgroundColor=[UIColor whiteColor];
    
}


@end
