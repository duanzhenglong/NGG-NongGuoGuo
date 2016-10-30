//
//  UITextField+NGGExtension.m
//  test2
//
//  Created by administrator on 16/9/23.
//  Copyright © 2016年 duanzhenglong. All rights reserved.
//

#import "UITextField+NGGExtension.h"

@implementation UITextField (NGGExtension)

static NSString * const NGGPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:NGGPlaceholderColorKey];
}


- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:NGGPlaceholderColorKey];
}
@end
